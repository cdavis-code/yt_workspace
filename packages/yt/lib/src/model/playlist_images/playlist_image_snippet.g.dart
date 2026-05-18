// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_image_snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistImageSnippet _$PlaylistImageSnippetFromJson(
  Map<String, dynamic> json,
) => PlaylistImageSnippet(
  playlistId: json['playlistId'] as String?,
  type: json['type'] as String?,
  width: (json['width'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
);

Map<String, dynamic> _$PlaylistImageSnippetToJson(
  PlaylistImageSnippet instance,
) => <String, dynamic>{
  'playlistId': instance.playlistId,
  'type': instance.type,
  'width': instance.width,
  'height': instance.height,
};
