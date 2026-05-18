import 'package:oauth2/oauth2.dart' as oauth2;

import 'oauth_access_control.dart'
    if (dart.library.io) 'oauth_access_control_io.dart'
    if (dart.library.html) 'oauth_access_control_web.dart';

abstract class OAuthAccessControl {
  /// Bearer access token string suitable for an `Authorization` header.
  String get token;

  /// Creates a platform-specific [OAuthAccessControl].
  ///
  /// When [oauthClient] is supplied the caller is assumed to have already
  /// performed the OAuth 2.0 flow and the implementation will use the
  /// supplied client directly. When `null`, the implementation loads
  /// (and possibly obtains) credentials from disk.
  factory OAuthAccessControl([oauth2.Client? oauthClient]) =>
      getOAuthAccessControl(oauthClient);

  Future<void> init();

  Future<void> checkAccessToken();
}

abstract class BaseOAuthAccessControl implements OAuthAccessControl {
  oauth2.Client? oauthClient;

  bool initialized = false;

  BaseOAuthAccessControl(this.oauthClient) {
    if (oauthClient != null) {
      initialized = true;
    }
  }

  oauth2.Client get client => initialized
      ? oauthClient!
      : throw StateError(
          'OAuthAccessControl has not been initialized. '
          'Call init() before accessing the client.',
        );

  @override
  String get token => client.credentials.accessToken;
}
