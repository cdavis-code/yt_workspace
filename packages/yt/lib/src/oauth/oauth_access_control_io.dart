import 'dart:convert';

import 'package:googleapis_auth/auth_io.dart';
import 'package:http/io_client.dart';
import 'package:universal_io/io.dart';
import 'package:yt/src/model/util/google_oauth_credentials.dart';
import 'package:yt/src/util/credentials_path.dart';
import 'package:yt/src/util/util.dart';

import 'oauth_access_control_interface.dart';

OAuthAccessControl getOAuthAccessControl(ClientId? clientId) =>
    OAuthAccessControlIo(clientId);

class OAuthAccessControlIo extends BaseOAuthAccessControl {
  static final String _userHome =
      Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'] ?? '';

  static final String _defaultDir =
      '$_userHome/${Util.defaultCredentialsDirname}';

  static final _credentialsFile = File(
    CredentialsPath.accessTokensFile(
      defaultPath: '$_defaultDir/${Util.accessCredentialsFilename}',
    ),
  );

  final httpClient = IOClient();

  OAuthAccessControlIo(super.identifier) {
    final resolvedPath = CredentialsPath.clientSecretsFile(
      defaultPath: '$_defaultDir/${Util.credentialsFilename}',
    );
    final credentialsFile = File(resolvedPath);

    if (!credentialsFile.existsSync()) {
      throw ArgumentError(
        'OAuth client secrets file not found at "$resolvedPath". '
        'Download it from Google Cloud Console and save it, or set the '
        'YT_CLIENT_SECRETS_FILE environment variable.',
      );
    }

    _checkFilePermissions(credentialsFile);

    if (clientId != null) return;

    try {
      final decoded =
          json.decode(credentialsFile.readAsStringSync())
              as Map<String, dynamic>;

      final googleCredentials = GoogleOAuthCredentials.fromJson(decoded);
      clientId = googleCredentials.toClientId();
    } on ArgumentError {
      rethrow;
    } on FormatException catch (_) {
      throw ArgumentError(
        'OAuth client secrets file at "$resolvedPath" contains '
        'invalid JSON. Ensure it is a valid Google OAuth client secret file.',
      );
    } catch (e) {
      throw ArgumentError(
        'Failed to parse OAuth client secrets file at '
        '"$resolvedPath": $e',
      );
    }
  }

  @override
  Future<void> init() async {
    if (_credentialsFile.existsSync()) {
      _checkFilePermissions(_credentialsFile);

      try {
        final decoded = json.decode(_credentialsFile.readAsStringSync());

        if (decoded is! Map<String, dynamic>) {
          throw ArgumentError(
            'Access tokens file at "${_credentialsFile.path}" contains '
            'invalid data. Expected JSON object, got ${decoded.runtimeType}. '
            'Delete the file and re-authorize with yt_cli.',
          );
        }

        nullableAccessCredentials = AccessCredentials.fromJson(decoded);
      } on ArgumentError {
        rethrow;
      } on FormatException catch (_) {
        throw ArgumentError(
          'Access tokens file at "${_credentialsFile.path}" contains '
          'invalid JSON. Delete the file and re-authorize with yt_cli.',
        );
      } catch (e) {
        throw ArgumentError(
          'Failed to parse access tokens file at '
          '"${_credentialsFile.path}": $e',
        );
      }

      nullableAccessCredentials = await refreshCredentials(
        clientId!,
        nullableAccessCredentials!,
        httpClient,
      );
    } else {
      nullableAccessCredentials = await obtainAccessCredentialsViaUserConsent(
        clientId!,
        ['https://www.googleapis.com/auth/youtube.force-ssl'],
        httpClient,
        (String url) {
          print('Please go to the following URL and grant access:');
          print('  => $url');
        },
      );

      _credentialsFile.writeAsStringSync(
        json.encode(nullableAccessCredentials!.toJson()),
        flush: true,
      );
    }

    initialized = true;
  }

  @override
  Future<void> checkAccessToken() async {
    if (!initialized) {
      await init();
    }

    if (accessCredentials.accessToken.expiry.isBefore(DateTime.now())) {
      nullableAccessCredentials = await refreshCredentials(
        clientId!,
        accessCredentials,
        httpClient,
      );
    }
  }

  /// Warns if a credential file is readable by group or other users.
  static void _checkFilePermissions(File file) {
    try {
      final stat = file.statSync();
      // Check group (0x20) and other (0x04) read bits on Unix.
      if (Platform.isLinux || Platform.isMacOS) {
        const groupRead = 0x20;
        const otherRead = 0x04;
        if (stat.mode & (groupRead | otherRead) != 0) {
          stderr.writeln(
            'WARNING: ${file.path} has overly permissive permissions '
            '(${stat.modeString}).\n'
            'Run: chmod 600 ${file.path}',
          );
        }
      }
    } catch (_) {
      // Non-fatal — permission check is advisory only.
    }
  }
}
