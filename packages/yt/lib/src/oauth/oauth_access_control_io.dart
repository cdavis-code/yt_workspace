import 'dart:convert';
import 'dart:math';

import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:universal_io/io.dart';
import 'package:yt/src/model/util/google_oauth_credentials.dart';
import 'package:yt/src/util/credentials_path.dart';
import 'package:yt/src/util/util.dart';

import 'oauth_access_control_interface.dart';

OAuthAccessControl getOAuthAccessControl(oauth2.Client? oauthClient) =>
    OAuthAccessControlIo(oauthClient);

class OAuthAccessControlIo extends BaseOAuthAccessControl {
  static const _scopes = <String>[
    'https://www.googleapis.com/auth/youtube.force-ssl',
  ];

  static final String _userHome =
      Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'] ?? '';

  static final String _defaultDir =
      '$_userHome/${Util.defaultCredentialsDirname}';

  static final _tokensFile = File(
    CredentialsPath.accessTokensFile(
      defaultPath: '$_defaultDir/${Util.accessCredentialsFilename}',
    ),
  );

  late final String _clientId;
  late final String _clientSecret;
  late final Uri _authEndpoint;
  late final Uri _tokenEndpoint;
  late final Uri _redirectUrl;

  OAuthAccessControlIo(super.oauthClient) {
    // When the caller already supplied an oauth2.Client we have everything
    // we need; skip filesystem IO entirely.
    if (oauthClient != null) return;

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

    final GoogleOAuthCredentials googleCredentials;
    try {
      final decoded =
          json.decode(credentialsFile.readAsStringSync())
              as Map<String, dynamic>;

      googleCredentials = GoogleOAuthCredentials.fromJson(decoded);
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
        '"$resolvedPath" (${e.runtimeType}).',
      );
    }

    final config = googleCredentials.web ?? googleCredentials.installed;
    if (config == null) {
      throw ArgumentError(
        'Google OAuth credentials must contain either "web" or "installed" '
        'root key.',
      );
    }

    _clientId = config.clientId;
    _clientSecret = config.clientSecret;
    _authEndpoint = Uri.parse(
      config.authUri ?? 'https://accounts.google.com/o/oauth2/auth',
    );
    _tokenEndpoint = Uri.parse(
      config.tokenUri ?? 'https://oauth2.googleapis.com/token',
    );
    final firstRedirect = (config.redirectUris ?? const <String>[]).isNotEmpty
        ? config.redirectUris!.first
        : 'http://localhost:8080/callback';
    _redirectUrl = Uri.parse(firstRedirect);
  }

  @override
  Future<void> init() async {
    if (initialized) return;

    if (_tokensFile.existsSync()) {
      _checkFilePermissions(_tokensFile);

      final oauth2.Credentials credentials;
      try {
        final raw = _tokensFile.readAsStringSync();
        final decoded = json.decode(raw);

        if (decoded is! Map<String, dynamic>) {
          throw ArgumentError(
            'Access tokens file at "${_tokensFile.path}" contains '
            'invalid data. Expected JSON object, got ${decoded.runtimeType}. '
            'Delete the file and re-authorize with yt_cli.',
          );
        }

        credentials = oauth2.Credentials.fromJson(raw);
      } on ArgumentError {
        rethrow;
      } on FormatException catch (_) {
        throw ArgumentError(
          'Access tokens file at "${_tokensFile.path}" contains '
          'invalid JSON. Delete the file and re-authorize with yt_cli.',
        );
      } catch (e) {
        throw ArgumentError(
          'Failed to parse access tokens file at '
          '"${_tokensFile.path}" (${e.runtimeType}).',
        );
      }

      oauthClient = oauth2.Client(
        credentials,
        identifier: _clientId,
        secret: _clientSecret,
      );

      if (credentials.canRefresh && credentials.isExpired) {
        await _refreshAndPersist();
      }
    } else {
      oauthClient = await _runInteractiveFlow();
      _persistCredentials();
    }

    initialized = true;
  }

  @override
  Future<void> checkAccessToken() async {
    if (!initialized) {
      await init();
      return;
    }

    final credentials = oauthClient!.credentials;
    if (credentials.isExpired && credentials.canRefresh) {
      await _refreshAndPersist();
    }
  }

  Future<void> _refreshAndPersist() async {
    oauthClient = await oauthClient!.refreshCredentials();
    _persistCredentials();
  }

  void _persistCredentials() {
    _tokensFile.parent.createSync(recursive: true);
    _tokensFile.writeAsStringSync(
      oauthClient!.credentials.toJson(),
      flush: true,
    );
    _restrictFilePermissions(_tokensFile);
  }

  /// Generates a cryptographically random PKCE code verifier per RFC 7636 §4.1.
  /// 32 random bytes base64url-encoded (no padding) yields a 43-character
  /// verifier within the [43, 128] range required by the spec.
  static String _generateCodeVerifier() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return base64UrlEncode(bytes).replaceAll('=', '');
  }

  Future<oauth2.Client> _runInteractiveFlow() async {
    // Explicit PKCE per RFC 8252: harden against authorization-code
    // interception on the loopback redirect.
    final grant = oauth2.AuthorizationCodeGrant(
      _clientId,
      _authEndpoint,
      _tokenEndpoint,
      secret: _clientSecret,
      codeVerifier: _generateCodeVerifier(),
    );

    // RFC 8252 §7.3: prefer an OS-allocated ephemeral port when the
    // registered redirect URI does not pin one.
    final hasFixedPort = _redirectUrl.hasPort && _redirectUrl.port != 0;
    final server = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      hasFixedPort ? _redirectUrl.port : 0,
    );
    final actualRedirectUrl = hasFixedPort
        ? _redirectUrl
        : _redirectUrl.replace(port: server.port);

    final baseAuthUrl = grant.getAuthorizationUrl(
      actualRedirectUrl,
      scopes: _scopes,
    );
    final authorizationUrl = baseAuthUrl.replace(
      queryParameters: <String, String>{
        ...baseAuthUrl.queryParameters,
        'access_type': 'offline',
        'prompt': 'consent',
      },
    );

    // Write to stderr so the prompt is never captured by callers piping
    // stdout to a file or to another process.
    stderr.writeln('Please go to the following URL and grant access:');
    stderr.writeln('  => $authorizationUrl');

    final expectedPath = actualRedirectUrl.path.isEmpty
        ? '/'
        : actualRedirectUrl.path;

    try {
      // Drain incoming requests until we receive one matching the redirect
      // path. This avoids treating a stray /favicon.ico (or any unrelated
      // probe) as the OAuth callback — the first request is no longer
      // implicitly trusted.
      HttpRequest? authRequest;
      await for (final request in server) {
        final uri = request.uri;
        final reqPath = uri.path.isEmpty ? '/' : uri.path;
        if (reqPath != expectedPath) {
          request.response
            ..statusCode = HttpStatus.notFound
            ..write('Not Found');
          await request.response.close();
          continue;
        }
        if (!uri.queryParameters.containsKey('code') &&
            !uri.queryParameters.containsKey('error')) {
          request.response
            ..statusCode = HttpStatus.badRequest
            ..write('Missing OAuth response parameters.');
          await request.response.close();
          continue;
        }
        authRequest = request;
        break;
      }

      if (authRequest == null) {
        throw StateError(
          'OAuth callback server closed before receiving a '
          'response.',
        );
      }

      // Acknowledge the browser.
      authRequest.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = ContentType.html
        ..write(
          '<h1>Authorization successful!</h1>'
          '<p>You can close this tab and return to your terminal.</p>',
        );
      await authRequest.response.close();

      return await grant.handleAuthorizationResponse(
        authRequest.uri.queryParameters,
      );
    } finally {
      await server.close();
    }
  }

  static void _checkFilePermissions(File file) {
    // Unix-only — POSIX mode bits have no meaningful equivalent on Windows.
    if (Platform.isWindows) return;
    try {
      final mode = file.statSync().mode;
      // Mask 0x3F == 0o077 — bits for group (rwx) and other (rwx).
      // Any non-zero result means someone besides the owner can access the
      // file, which is unsafe for OAuth client secrets / refresh tokens.
      if ((mode & 0x3F) != 0) {
        final octal = (mode & 0x1FF).toRadixString(8).padLeft(3, '0');
        // Best-effort, non-fatal.
        stderr.writeln(
          'Warning: OAuth credential file "${file.path}" has mode 0$octal '
          '(group/other accessible). Run "chmod 600 ${file.path}" to '
          'restrict it.',
        );
      }
    } catch (_) {
      // Best-effort only.
    }
  }

  static void _restrictFilePermissions(File file) {
    // Unix-only — Windows NTFS ACLs are managed via the Explorer Security
    // tab or icacls; chmod is meaningless here.
    if (Platform.isWindows) return;
    // Use the absolute path to chmod to avoid honoring a malicious PATH
    // entry that shadows the system binary. /bin/chmod is the standard
    // location on macOS and Linux; /usr/bin/chmod is the BSD/Solaris
    // fallback. We try both before giving up.
    const candidates = ['/bin/chmod', '/usr/bin/chmod'];
    for (final chmod in candidates) {
      if (!File(chmod).existsSync()) continue;
      try {
        final result = Process.runSync(chmod, ['600', file.path]);
        if (result.exitCode == 0) return;
        stderr.writeln(
          'Warning: failed to chmod 600 "${file.path}" '
          '(exit ${result.exitCode}): ${result.stderr}',
        );
        return;
      } catch (e) {
        stderr.writeln('Warning: failed to chmod 600 "${file.path}": $e');
        return;
      }
    }
    stderr.writeln(
      'Warning: chmod binary not found at /bin/chmod or /usr/bin/chmod; '
      'cannot restrict permissions on "${file.path}".',
    );
  }
}
