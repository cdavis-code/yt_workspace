// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_stream_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveStreamListResponse _$LiveStreamListResponseFromJson(
  Map<String, dynamic> json,
) => LiveStreamListResponse(
  kind: json['kind'] as String,
  etag: json['etag'] as String,
  nextPageToken: json['nextPageToken'] as String?,
  prevPageToken: json['prevPageToken'] as String?,
  pageInfo: json['pageInfo'] == null
      ? null
      : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
  liveStreamItems: (json['items'] as List<dynamic>?)
      ?.map((e) => LiveStreamItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$LiveStreamListResponseToJson(
  LiveStreamListResponse instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'nextPageToken': instance.nextPageToken,
  'prevPageToken': instance.prevPageToken,
  'pageInfo': instance.pageInfo,
  'items': instance.liveStreamItems,
};
