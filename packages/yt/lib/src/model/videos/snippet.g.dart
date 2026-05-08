// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Snippet _$SnippetFromJson(Map<String, dynamic> json) => Snippet(
  publishedAt: json['publishedAt'] == null
      ? null
      : DateTime.parse(json['publishedAt'] as String),
  channelId: json['channelId'] as String?,
  title: json['title'] as String,
  description: json['description'] as String,
  thumbnails: json['thumbnails'] == null
      ? null
      : Thumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
  channelTitle: json['channelTitle'] as String?,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  categoryId: json['categoryId'] as String?,
  liveBroadcastContent: json['liveBroadcastContent'] as String,
  defaultLanguage: json['defaultLanguage'] as String?,
  localized: json['localized'] == null
      ? null
      : Localized.fromJson(json['localized'] as Map<String, dynamic>),
  defaultAudioLanguage: json['defaultAudioLanguage'] as String?,
);

Map<String, dynamic> _$SnippetToJson(Snippet instance) => <String, dynamic>{
  'publishedAt': instance.publishedAt?.toIso8601String(),
  'channelId': instance.channelId,
  'title': instance.title,
  'description': instance.description,
  'thumbnails': instance.thumbnails?.toJson(),
  'channelTitle': instance.channelTitle,
  'tags': instance.tags,
  'categoryId': instance.categoryId,
  'liveBroadcastContent': instance.liveBroadcastContent,
  'defaultLanguage': instance.defaultLanguage,
  'localized': instance.localized?.toJson(),
  'defaultAudioLanguage': instance.defaultAudioLanguage,
};
