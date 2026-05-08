// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoListResponse _$VideoListResponseFromJson(Map<String, dynamic> json) =>
    VideoListResponse(
      kind: json['kind'] as String,
      etag: json['etag'] as String,
      nextPageToken: json['nextPageToken'] as String?,
      prevPageToken: json['prevPageToken'] as String?,
      pageInfo: json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      videoItems: (json['items'] as List<dynamic>?)
          ?.map((e) => VideoItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VideoListResponseToJson(VideoListResponse instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'nextPageToken': instance.nextPageToken,
      'prevPageToken': instance.prevPageToken,
      'pageInfo': instance.pageInfo,
      'items': instance.videoItems,
    };
