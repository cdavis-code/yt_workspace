// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscriber_snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriberSnippet _$SubscriberSnippetFromJson(Map<String, dynamic> json) =>
    SubscriberSnippet(
      title: json['title'] as String,
      description: json['description'] as String,
      channelId: json['channelId'] as String,
      thumbnails: Thumbnails.fromJson(
        json['thumbnails'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$SubscriberSnippetToJson(SubscriberSnippet instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'channelId': instance.channelId,
      'thumbnails': instance.thumbnails,
    };
