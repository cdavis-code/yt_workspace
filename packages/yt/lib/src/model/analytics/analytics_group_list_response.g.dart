// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_group_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyticsGroupListResponse _$AnalyticsGroupListResponseFromJson(
  Map<String, dynamic> json,
) => AnalyticsGroupListResponse(
  kind: json['kind'] as String? ?? 'youtubeAnalytics#groupListResponse',
  etag: json['etag'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => AnalyticsGroup.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AnalyticsGroupListResponseToJson(
  AnalyticsGroupListResponse instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'items': instance.items,
};
