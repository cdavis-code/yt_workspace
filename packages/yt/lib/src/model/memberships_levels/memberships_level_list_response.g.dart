// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memberships_level_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembershipsLevelListResponse _$MembershipsLevelListResponseFromJson(
  Map<String, dynamic> json,
) => MembershipsLevelListResponse(
  kind: json['kind'] as String? ?? 'youtube#membershipsLevelListResponse',
  etag: json['etag'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => MembershipsLevel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MembershipsLevelListResponseToJson(
  MembershipsLevelListResponse instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'items': instance.items,
};
