// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityListResponse _$ActivityListResponseFromJson(
  Map<String, dynamic> json,
) => ActivityListResponse(
  kind: json['kind'] as String,
  etag: json['etag'] as String,
  nextPageToken: json['nextPageToken'] as String?,
  prevPageToken: json['prevPageToken'] as String?,
  pageInfo: json['pageInfo'] == null
      ? null
      : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
  activityItems: (json['items'] as List<dynamic>?)
      ?.map((e) => Activity.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ActivityListResponseToJson(
  ActivityListResponse instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'nextPageToken': instance.nextPageToken,
  'prevPageToken': instance.prevPageToken,
  'pageInfo': instance.pageInfo,
  'items': instance.activityItems,
};
