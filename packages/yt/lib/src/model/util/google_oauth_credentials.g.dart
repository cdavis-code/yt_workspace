// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_oauth_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleOAuthCredentials _$GoogleOAuthCredentialsFromJson(
  Map<String, dynamic> json,
) => GoogleOAuthCredentials(
  web: json['web'] == null
      ? null
      : GoogleOAuthClientConfig.fromJson(json['web'] as Map<String, dynamic>),
  installed: json['installed'] == null
      ? null
      : GoogleOAuthClientConfig.fromJson(
          json['installed'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$GoogleOAuthCredentialsToJson(
  GoogleOAuthCredentials instance,
) => <String, dynamic>{'web': instance.web, 'installed': instance.installed};

GoogleOAuthClientConfig _$GoogleOAuthClientConfigFromJson(
  Map<String, dynamic> json,
) => GoogleOAuthClientConfig(
  clientId: json['client_id'] as String,
  clientSecret: json['client_secret'] as String,
  authUri: json['auth_uri'] as String?,
  tokenUri: json['token_uri'] as String?,
  redirectUris: (json['redirect_uris'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  projectId: json['project_id'] as String?,
);

Map<String, dynamic> _$GoogleOAuthClientConfigToJson(
  GoogleOAuthClientConfig instance,
) => <String, dynamic>{
  'client_id': instance.clientId,
  'client_secret': instance.clientSecret,
  'auth_uri': instance.authUri,
  'token_uri': instance.tokenUri,
  'redirect_uris': instance.redirectUris,
  'project_id': instance.projectId,
};
