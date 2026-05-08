// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_broadcast_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveBroadcastResponse _$LiveBroadcastResponseFromJson(
  Map<String, dynamic> json,
) => LiveBroadcastResponse(
  kind: json['kind'] as String,
  etag: json['etag'] as String,
  nextPageToken: json['nextPageToken'] as String?,
  prevPageToken: json['prevPageToken'] as String?,
  pageInfo: json['pageInfo'] == null
      ? null
      : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
  broadcastItems: (json['items'] as List<dynamic>?)
      ?.map((e) => LiveBroadcastItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$LiveBroadcastResponseToJson(
  LiveBroadcastResponse instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'nextPageToken': instance.nextPageToken,
  'prevPageToken': instance.prevPageToken,
  'pageInfo': instance.pageInfo?.toJson(),
  'items': instance.broadcastItems?.map((e) => e.toJson()).toList(),
};
