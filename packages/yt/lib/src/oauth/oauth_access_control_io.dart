import 'dart:convert';

import 'package:googleapis_auth/auth_io.dart';
import 'package:http/io_client.dart';
import 'package:universal_io/io.dart';
import 'package:yt/src/util/util.dart';

import 'oauth_access_control_interface.dart';

OAuthAccessControl getOAuthAccessControl(ClientId? clientId) =>
    OAuthAccessControlIo(clientId);

class OAuthAccessControlIo extends BaseOAuthAccessControl {
  static final _userHome =
      Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];

  static final _credentialsFile = File(
    '$_userHome/${Util.accessCredentialsFilePath}',
  );

  final httpClient = IOClient();

  OAuthAccessControlIo(super.identifier) {
    clientId ??= ClientId.fromJson(
      json.decode(
        File(
          '$_userHome/${Util.defaultCredentialsFilePath}',
        ).readAsStringSync(),
      ),
    );
  }

  @override
  Future<void> init() async {
    if (_credentialsFile.existsSync()) {
      nullableAccessCredentials = AccessCredentials.fromJson(
        json.decode(_credentialsFile.readAsStringSync()),
      );

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
        json.encode(nullableAccessCredentials),
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
}
