// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_image_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistImageListResponse _$PlaylistImageListResponseFromJson(
  Map<String, dynamic> json,
) => PlaylistImageListResponse(
  kind: json['kind'] as String? ?? 'youtube#playlistImageListResponse',
  etag: json['etag'] as String?,
  nextPageToken: json['nextPageToken'] as String?,
  prevPageToken: json['prevPageToken'] as String?,
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => PlaylistImage.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PlaylistImageListResponseToJson(
  PlaylistImageListResponse instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'nextPageToken': instance.nextPageToken,
  'prevPageToken': instance.prevPageToken,
  'items': instance.items,
};
