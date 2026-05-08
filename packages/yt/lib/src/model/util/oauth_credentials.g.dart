// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OAuthCredentials _$OAuthCredentialsFromJson(Map<String, dynamic> json) =>
    OAuthCredentials(json['identifier'] as String, json['secret'] as String);

Map<String, dynamic> _$OAuthCredentialsToJson(OAuthCredentials instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'secret': instance.secret,
    };
