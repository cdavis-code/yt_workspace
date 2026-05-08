// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistResponse _$PlaylistResponseFromJson(Map<String, dynamic> json) =>
    PlaylistResponse(
      kind: json['kind'] as String,
      etag: json['etag'] as String,
      nextPageToken: json['nextPageToken'] as String?,
      prevPageToken: json['prevPageToken'] as String?,
      pageInfo: json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      playlistItems: (json['items'] as List<dynamic>?)
          ?.map((e) => Playlist.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaylistResponseToJson(PlaylistResponse instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'nextPageToken': instance.nextPageToken,
      'prevPageToken': instance.prevPageToken,
      'pageInfo': instance.pageInfo?.toJson(),
      'items': instance.playlistItems?.map((e) => e.toJson()).toList(),
    };
