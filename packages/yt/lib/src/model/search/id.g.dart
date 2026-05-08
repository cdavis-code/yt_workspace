// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Id _$IdFromJson(Map<String, dynamic> json) => Id(
  kind: json['kind'] as String,
  videoId: json['videoId'] as String?,
  channelId: json['channelId'] as String?,
  playlistId: json['playlistId'] as String?,
);

Map<String, dynamic> _$IdToJson(Id instance) => <String, dynamic>{
  'kind': instance.kind,
  'videoId': instance.videoId,
  'channelId': instance.channelId,
  'playlistId': instance.playlistId,
};
