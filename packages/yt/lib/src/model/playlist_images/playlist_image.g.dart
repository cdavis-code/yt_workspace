// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistImage _$PlaylistImageFromJson(Map<String, dynamic> json) =>
    PlaylistImage(
      kind: json['kind'] as String? ?? 'youtube#playlistImage',
      id: json['id'] as String?,
      snippet: json['snippet'] == null
          ? null
          : PlaylistImageSnippet.fromJson(
              json['snippet'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$PlaylistImageToJson(PlaylistImage instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'id': instance.id,
      'snippet': instance.snippet,
    };
