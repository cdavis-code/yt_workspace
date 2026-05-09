// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
  kind: json['kind'] as String? ?? 'youtube#member',
  etag: json['etag'] as String,
  snippet: MemberSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'snippet': instance.snippet,
};
