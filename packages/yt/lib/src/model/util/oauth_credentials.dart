import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:universal_io/io.dart';
import 'package:yaml/yaml.dart';

part 'oauth_credentials.g.dart';

/// Minimal OAuth client identifier/secret pair.
///
/// Use [toAuthorizationCodeGrant] when you also know the provider's
/// authorization and token endpoints (e.g. Google's standard OAuth 2.0
/// endpoints).
@JsonSerializable()
class OAuthCredentials {
  final String identifier;
  final String secret;

  OAuthCredentials(this.identifier, this.secret);

  /// Convenience constructor returning an [oauth2.AuthorizationCodeGrant]
  /// pre-configured with Google's default OAuth 2.0 endpoints.
  oauth2.AuthorizationCodeGrant toAuthorizationCodeGrant({
    Uri? authorizationEndpoint,
    Uri? tokenEndpoint,
  }) => oauth2.AuthorizationCodeGrant(
    identifier,
    authorizationEndpoint ??
        Uri.parse('https://accounts.google.com/o/oauth2/auth'),
    tokenEndpoint ?? Uri.parse('https://oauth2.googleapis.com/token'),
    secret: secret,
  );

  factory OAuthCredentials.fromYamlFile(File yamlFile) {
    return OAuthCredentials.fromYamlString(yamlFile.readAsStringSync());
  }

  factory OAuthCredentials.fromYaml(String yamlFilePath) {
    return OAuthCredentials.fromYamlString(
      File(yamlFilePath).readAsStringSync(),
    );
  }

  factory OAuthCredentials.fromYamlString(String yaml) {
    final credentialsYaml = loadYaml(yaml) as Map;

    return OAuthCredentials.fromJson(
      credentialsYaml.map<String, dynamic>(
        (key, value) => MapEntry(key, value),
      ),
    );
  }

  factory OAuthCredentials.fromJsonFile(File jsonFile) {
    return OAuthCredentials.fromYamlString(jsonFile.readAsStringSync());
  }

  factory OAuthCredentials.fromJsonString(String jsonString) {
    return OAuthCredentials.fromJson(jsonDecode(jsonString));
  }

  factory OAuthCredentials.fromJson(Map<String, dynamic> json) =>
      _$OAuthCredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$OAuthCredentialsToJson(this);

  /// JSON representation safe to surface in logs / diagnostic output.
  /// The OAuth client secret is replaced with `[redacted]`.
  ///
  /// Use [toJson] only when persisting credentials to a private,
  /// permission-restricted location (e.g. the `~/.yt` credentials file).
  Map<String, dynamic> toRedactedJson() => <String, dynamic>{
    'identifier': identifier,
    'secret': '[redacted]',
  };

  /// Safe toString — masks the OAuth client secret.
  @override
  String toString() =>
      'OAuthCredentials(identifier: $identifier, secret: [redacted])';
}
