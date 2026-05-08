import 'dart:convert';

import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:universal_io/io.dart';
import 'package:yaml/yaml.dart';

part 'oauth_credentials.g.dart';

@JsonSerializable()
class OAuthCredentials {
  final String identifier;
  final String secret;

  OAuthCredentials(this.identifier, this.secret);

  ClientId get oAuthClientId => ClientId(identifier, secret);

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

  @override
  String toString() => jsonEncode(toJson());
}
