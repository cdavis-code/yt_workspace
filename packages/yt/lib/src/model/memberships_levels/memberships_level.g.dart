// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memberships_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembershipsLevel _$MembershipsLevelFromJson(Map<String, dynamic> json) =>
    MembershipsLevel(
      kind: json['kind'] as String? ?? 'youtube#membershipsLevel',
      etag: json['etag'] as String,
      id: json['id'] as String,
      snippet: MembershipsLevelSnippet.fromJson(
        json['snippet'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$MembershipsLevelToJson(MembershipsLevel instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'id': instance.id,
      'snippet': instance.snippet,
    };
