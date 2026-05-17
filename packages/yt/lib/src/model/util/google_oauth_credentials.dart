import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:json_annotation/json_annotation.dart';

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

  /// Extracts the [ClientId] from whichever format is present.
  ///
  /// Throws [ArgumentError] if neither `web` nor `installed` is found.
  ClientId toClientId() {
    final config = web ?? installed;

    if (config == null) {
      throw ArgumentError(
        'Google OAuth credentials must contain either "web" or "installed" '
        'root key. Download a valid file from Google Cloud Console > '
        'API & Services > Credentials.',
      );
    }

    return config.toClientId();
  }

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

  /// Converts to [ClientId] for use with googleapis_auth.
  ClientId toClientId() => ClientId(clientId, clientSecret);

  factory GoogleOAuthClientConfig.fromJson(Map<String, dynamic> json) =>
      _$GoogleOAuthClientConfigFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleOAuthClientConfigToJson(this);

  /// Safe toString — masks the client secret.
  @override
  String toString() =>
      'GoogleOAuthClientConfig(clientId: $clientId, clientSecret: [redacted])';
}
