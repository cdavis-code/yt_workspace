// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoCategory _$VideoCategoryFromJson(Map<String, dynamic> json) =>
    VideoCategory(
      kind: json['kind'] as String,
      etag: json['etag'] as String,
      id: json['id'] as String,
      snippet: json['snippet'] == null
          ? null
          : CategorySnippet.fromJson(json['snippet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VideoCategoryToJson(VideoCategory instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'id': instance.id,
      'snippet': instance.snippet,
    };
