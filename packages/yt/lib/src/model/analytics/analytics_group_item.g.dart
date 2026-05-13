// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_group_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyticsGroupItem _$AnalyticsGroupItemFromJson(Map<String, dynamic> json) =>
    AnalyticsGroupItem(
      kind: json['kind'] as String? ?? 'youtubeAnalytics#groupItem',
      etag: json['etag'] as String,
      id: json['id'] as String,
      groupId: json['groupId'] as String,
      resource: AnalyticsGroupItemResource.fromJson(
        json['resource'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$AnalyticsGroupItemToJson(AnalyticsGroupItem instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'id': instance.id,
      'groupId': instance.groupId,
      'resource': instance.resource,
    };

AnalyticsGroupItemResource _$AnalyticsGroupItemResourceFromJson(
  Map<String, dynamic> json,
) => AnalyticsGroupItemResource(
  id: json['id'] as String,
  kind: json['kind'] as String,
);

Map<String, dynamic> _$AnalyticsGroupItemResourceToJson(
  AnalyticsGroupItemResource instance,
) => <String, dynamic>{'id': instance.id, 'kind': instance.kind};
