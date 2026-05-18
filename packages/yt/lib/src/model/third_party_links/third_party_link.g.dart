// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'third_party_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThirdPartyLink _$ThirdPartyLinkFromJson(
  Map<String, dynamic> json,
) => ThirdPartyLink(
  kind: json['kind'] as String? ?? 'youtube#thirdPartyLink',
  etag: json['etag'] as String,
  linkingToken: json['linkingToken'] as String?,
  status: json['status'] == null
      ? null
      : ThirdPartyLinkStatus.fromJson(json['status'] as Map<String, dynamic>),
  snippet: json['snippet'] == null
      ? null
      : ThirdPartyLinkSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ThirdPartyLinkToJson(ThirdPartyLink instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'linkingToken': instance.linkingToken,
      'status': instance.status,
      'snippet': instance.snippet,
    };
