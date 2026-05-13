import 'package:json_annotation/json_annotation.dart';

import 'json_settings.dart';

part 'jwt_credentials.g.dart';

@JsonSerializable(explicitToJson: true)
class JwtCredentials {
  final JsonSettings settings;
  final String scope;

  JwtCredentials({required this.settings, required this.scope});

  factory JwtCredentials.fromJson(Map<String, dynamic> json) =>
      _$JwtCredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$JwtCredentialsToJson(this);

  /// Safe toString — masks the private key embedded in settings.
  @override
  String toString() => 'JwtCredentials(scope: $scope, settings: [redacted])';
}
