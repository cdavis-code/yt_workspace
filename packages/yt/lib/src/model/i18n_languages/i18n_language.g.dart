// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i18n_language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

I18nLanguage _$I18nLanguageFromJson(Map<String, dynamic> json) => I18nLanguage(
  kind: json['kind'] as String? ?? 'youtube#i18nLanguage',
  etag: json['etag'] as String,
  id: json['id'] as String,
  snippet: I18nLanguageSnippet.fromJson(
    json['snippet'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$I18nLanguageToJson(I18nLanguage instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'id': instance.id,
      'snippet': instance.snippet,
    };
