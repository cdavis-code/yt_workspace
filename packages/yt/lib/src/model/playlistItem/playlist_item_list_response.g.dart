// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_item_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistItemListResponse _$PlaylistItemListResponseFromJson(
  Map<String, dynamic> json,
) => PlaylistItemListResponse(
  kind: json['kind'] as String,
  etag: json['etag'] as String,
  nextPageToken: json['nextPageToken'] as String?,
  prevPageToken: json['prevPageToken'] as String?,
  pageInfo: json['pageInfo'] == null
      ? null
      : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
  playlistItemItems: (json['items'] as List<dynamic>?)
      ?.map((e) => PlaylistItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PlaylistItemListResponseToJson(
  PlaylistItemListResponse instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'nextPageToken': instance.nextPageToken,
  'prevPageToken': instance.prevPageToken,
  'pageInfo': instance.pageInfo,
  'items': instance.playlistItemItems,
};
