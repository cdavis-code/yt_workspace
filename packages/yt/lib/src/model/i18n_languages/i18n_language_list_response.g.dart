// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i18n_language_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

I18nLanguageListResponse _$I18nLanguageListResponseFromJson(
  Map<String, dynamic> json,
) => I18nLanguageListResponse(
  kind: json['kind'] as String? ?? 'youtube#i18nLanguageListResponse',
  etag: json['etag'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => I18nLanguage.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$I18nLanguageListResponseToJson(
  I18nLanguageListResponse instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'items': instance.items,
};
