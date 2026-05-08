import 'package:googleapis_auth/auth_browser.dart';
import 'package:http/browser_client.dart' as html;

import 'oauth_access_control_interface.dart';

OAuthAccessControl getOAuthAccessControl(ClientId? clientId) =>
    OAuthAccessControlWeb(clientId);

class OAuthAccessControlWeb extends BaseOAuthAccessControl {
  final httpClient = html.BrowserClient();

  OAuthAccessControlWeb(super.identifier);

  @override
  Future<void> init() async {
    clientId ?? Exception();

    nullableAccessCredentials = await requestAccessCredentials(
      clientId: clientId!.identifier,
      scopes: ['https://www.googleapis.com/auth/youtube.force-ssl'],
    );

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
