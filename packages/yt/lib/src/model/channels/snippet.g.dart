// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Snippet _$SnippetFromJson(Map<String, dynamic> json) => Snippet(
  title: json['title'] as String,
  description: json['description'] as String,
  customUrl: json['customUrl'] as String?,
  publishedAt: json['publishedAt'] == null
      ? null
      : DateTime.parse(json['publishedAt'] as String),
  thumbnails: json['thumbnails'] == null
      ? null
      : Thumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
  defaultLanguage: json['defaultLanguage'] as String?,
  localized: json['localized'] == null
      ? null
      : Localized.fromJson(json['localized'] as Map<String, dynamic>),
  country: json['country'] as String?,
);

Map<String, dynamic> _$SnippetToJson(Snippet instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'customUrl': instance.customUrl,
  'publishedAt': instance.publishedAt?.toIso8601String(),
  'thumbnails': instance.thumbnails?.toJson(),
  'defaultLanguage': instance.defaultLanguage,
  'localized': instance.localized?.toJson(),
  'country': instance.country,
};
