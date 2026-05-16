// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivitySnippet _$ActivitySnippetFromJson(Map<String, dynamic> json) =>
    ActivitySnippet(
      publishedAt: json['publishedAt'] as String?,
      channelId: json['channelId'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      thumbnails: json['thumbnails'] as Map<String, dynamic>?,
      channelTitle: json['channelTitle'] as String?,
      type: json['type'] as String?,
      groupId: json['groupId'] as String?,
    );

Map<String, dynamic> _$ActivitySnippetToJson(ActivitySnippet instance) =>
    <String, dynamic>{
      'publishedAt': instance.publishedAt,
      'channelId': instance.channelId,
      'title': instance.title,
      'description': instance.description,
      'thumbnails': instance.thumbnails,
      'channelTitle': instance.channelTitle,
      'type': instance.type,
      'groupId': instance.groupId,
    };
