// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistItem _$PlaylistItemFromJson(Map<String, dynamic> json) => PlaylistItem(
  kind: json['kind'] as String,
  etag: json['etag'] as String,
  id: json['id'] as String,
  snippet: json['snippet'] == null
      ? null
      : Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
  status: json['status'] == null
      ? null
      : Status.fromJson(json['status'] as Map<String, dynamic>),
  contentDetails: json['contentDetails'] == null
      ? null
      : ContentDetails.fromJson(json['contentDetails'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PlaylistItemToJson(PlaylistItem instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'id': instance.id,
      'snippet': instance.snippet,
      'status': instance.status,
      'contentDetails': instance.contentDetails,
    };
