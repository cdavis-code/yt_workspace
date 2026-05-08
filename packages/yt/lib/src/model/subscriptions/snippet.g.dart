// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Snippet _$SnippetFromJson(Map<String, dynamic> json) => Snippet(
  publishedAt: DateTime.parse(json['publishedAt'] as String),
  channelTitle: json['channelTitle'] as String?,
  title: json['title'] as String,
  description: json['description'] as String,
  resourceId: ResourceId.fromJson(json['resourceId'] as Map<String, dynamic>),
  channelId: json['channelId'] as String,
  thumbnails: Thumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SnippetToJson(Snippet instance) => <String, dynamic>{
  'publishedAt': instance.publishedAt.toIso8601String(),
  'channelTitle': instance.channelTitle,
  'title': instance.title,
  'description': instance.description,
  'resourceId': instance.resourceId,
  'channelId': instance.channelId,
  'thumbnails': instance.thumbnails,
};
