import 'package:json_annotation/json_annotation.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

part 'google_oauth_credentials.g.dart';

/// Represents a Google OAuth client secrets file.
///
/// Google exports OAuth credentials in two formats:
/// - `web` (for web applications)
/// - `installed` (for desktop/mobile apps)
///
/// Both formats contain the same fields but under different root keys.
@JsonSerializable()
class GoogleOAuthCredentials {
  final GoogleOAuthClientConfig? web;
  final GoogleOAuthClientConfig? installed;

  GoogleOAuthCredentials({this.web, this.installed});

  /// Returns whichever of [web] or [installed] is populated.
  ///
  /// Throws [ArgumentError] if neither is present.
  GoogleOAuthClientConfig get config {
    final result = web ?? installed;
    if (result == null) {
      throw ArgumentError(
        'Google OAuth credentials must contain either "web" or "installed" '
        'root key. Download a valid file from Google Cloud Console > '
        'API & Services > Credentials.',
      );
    }
    return result;
  }

  /// Builds an [oauth2.AuthorizationCodeGrant] from whichever format is
  /// present, using the embedded endpoints and client credentials.
  oauth2.AuthorizationCodeGrant toAuthorizationCodeGrant() =>
      config.toAuthorizationCodeGrant();

  factory GoogleOAuthCredentials.fromJson(Map<String, dynamic> json) =>
      _$GoogleOAuthCredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleOAuthCredentialsToJson(this);
}

/// Represents the OAuth client configuration under either "web" or "installed" key.
@JsonSerializable()
class GoogleOAuthClientConfig {
  @JsonKey(name: 'client_id')
  final String clientId;

  @JsonKey(name: 'client_secret')
  final String clientSecret;

  @JsonKey(name: 'auth_uri')
  final String? authUri;

  @JsonKey(name: 'token_uri')
  final String? tokenUri;

  @JsonKey(name: 'redirect_uris')
  final List<String>? redirectUris;

  @JsonKey(name: 'project_id')
  final String? projectId;

  GoogleOAuthClientConfig({
    required this.clientId,
    required this.clientSecret,
    this.authUri,
    this.tokenUri,
    this.redirectUris,
    this.projectId,
  });

  /// Builds an [oauth2.AuthorizationCodeGrant] from this config's
  /// embedded endpoints and client credentials.
  ///
  /// Falls back to Google's default OAuth 2.0 endpoints when [authUri]
  /// or [tokenUri] is missing.
  oauth2.AuthorizationCodeGrant toAuthorizationCodeGrant() =>
      oauth2.AuthorizationCodeGrant(
        clientId,
        Uri.parse(authUri ?? 'https://accounts.google.com/o/oauth2/auth'),
        Uri.parse(tokenUri ?? 'https://oauth2.googleapis.com/token'),
        secret: clientSecret,
      );

  factory GoogleOAuthClientConfig.fromJson(Map<String, dynamic> json) =>
      _$GoogleOAuthClientConfigFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleOAuthClientConfigToJson(this);

  /// Safe toString — masks the client secret.
  @override
  String toString() =>
      'GoogleOAuthClientConfig(clientId: $clientId, clientSecret: [redacted])';
}
