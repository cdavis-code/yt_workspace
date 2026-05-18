import 'package:oauth2/oauth2.dart' as oauth2;

import 'oauth_access_control_interface.dart';

OAuthAccessControl getOAuthAccessControl(oauth2.Client? oauthClient) =>
    OAuthAccessControlWeb(oauthClient);

/// Web stub.
///
/// OAuth flows that require local-loopback redirects or filesystem access
/// are not supported when this package is compiled for the browser.
/// Use [`Yt.withApiKey()`] for read-only access on the web, or run the
/// OAuth flow on a `dart:io` target (CLI, server, desktop).
class OAuthAccessControlWeb extends BaseOAuthAccessControl {
  OAuthAccessControlWeb(super.oauthClient);

  static const _unsupportedMessage =
      'yt OAuth is not supported on the web platform. '
      'Use Yt.withApiKey() or run on dart:io.';

  @override
  Future<void> init() async {
    throw UnsupportedError(_unsupportedMessage);
  }

  @override
  Future<void> checkAccessToken() async {
    throw UnsupportedError(_unsupportedMessage);
  }
}
