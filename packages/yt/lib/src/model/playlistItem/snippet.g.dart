// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Snippet _$SnippetFromJson(Map<String, dynamic> json) => Snippet(
  publishedAt: DateTime.parse(json['publishedAt'] as String),
  channelId: json['channelId'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  thumbnails: Thumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
  channelTitle: json['channelTitle'] as String,
  videoOwnerChannelTitle: json['videoOwnerChannelTitle'] as String,
  videoOwnerChannelId: json['videoOwnerChannelId'] as String,
  playlistId: json['playlistId'] as String,
  position: (json['position'] as num).toInt(),
  resourceId: ResourceId.fromJson(json['resourceId'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SnippetToJson(Snippet instance) => <String, dynamic>{
  'publishedAt': instance.publishedAt.toIso8601String(),
  'channelId': instance.channelId,
  'title': instance.title,
  'description': instance.description,
  'thumbnails': instance.thumbnails.toJson(),
  'channelTitle': instance.channelTitle,
  'videoOwnerChannelTitle': instance.videoOwnerChannelTitle,
  'videoOwnerChannelId': instance.videoOwnerChannelId,
  'playlistId': instance.playlistId,
  'position': instance.position,
  'resourceId': instance.resourceId.toJson(),
};
