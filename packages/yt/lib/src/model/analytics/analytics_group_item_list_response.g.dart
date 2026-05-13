// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_group_item_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyticsGroupItemListResponse _$AnalyticsGroupItemListResponseFromJson(
  Map<String, dynamic> json,
) => AnalyticsGroupItemListResponse(
  kind: json['kind'] as String? ?? 'youtubeAnalytics#groupItemListResponse',
  etag: json['etag'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => AnalyticsGroupItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AnalyticsGroupItemListResponseToJson(
  AnalyticsGroupItemListResponse instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'items': instance.items,
};
