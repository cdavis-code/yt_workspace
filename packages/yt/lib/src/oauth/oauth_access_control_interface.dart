import 'package:googleapis_auth/googleapis_auth.dart';

import 'oauth_access_control.dart'
    if (dart.library.io) 'oauth_access_control_io.dart'
    if (dart.library.html) 'oauth_access_control_web.dart';

abstract class OAuthAccessControl {
  String get token;

  factory OAuthAccessControl(ClientId? clientId) =>
      getOAuthAccessControl(clientId);

  Future<void> init();

  Future<void> checkAccessToken();
}

abstract class BaseOAuthAccessControl implements OAuthAccessControl {
  ClientId? clientId;

  bool initialized = false;

  AccessCredentials? nullableAccessCredentials;

  AccessCredentials get accessCredentials =>
      initialized ? nullableAccessCredentials! : throw Exception();

  @override
  String get token => accessCredentials.accessToken.data;

  BaseOAuthAccessControl(this.clientId);
}
