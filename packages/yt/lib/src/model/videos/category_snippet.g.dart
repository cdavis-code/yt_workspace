// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategorySnippet _$CategorySnippetFromJson(Map<String, dynamic> json) =>
    CategorySnippet(
      channelId: json['channelId'] as String?,
      title: json['title'] as String,
      assignable: json['assignable'] as bool,
    );

Map<String, dynamic> _$CategorySnippetToJson(CategorySnippet instance) =>
    <String, dynamic>{
      'channelId': instance.channelId,
      'title': instance.title,
      'assignable': instance.assignable,
    };
