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
  scheduledStartTime: json['scheduledStartTime'] == null
      ? null
      : DateTime.parse(json['scheduledStartTime'] as String),
  scheduledEndTime: json['scheduledEndTime'] == null
      ? null
      : DateTime.parse(json['scheduledEndTime'] as String),
  actualStartTime: json['actualStartTime'] == null
      ? null
      : DateTime.parse(json['actualStartTime'] as String),
  liveChatId: json['liveChatId'] as String?,
);

Map<String, dynamic> _$SnippetToJson(Snippet instance) => <String, dynamic>{
  'publishedAt': instance.publishedAt?.toIso8601String(),
  'channelId': instance.channelId,
  'title': instance.title,
  'description': instance.description,
  'thumbnails': instance.thumbnails?.toJson(),
  'scheduledStartTime': instance.scheduledStartTime?.toIso8601String(),
  'scheduledEndTime': instance.scheduledEndTime?.toIso8601String(),
  'actualStartTime': instance.actualStartTime?.toIso8601String(),
  'liveChatId': instance.liveChatId,
};
