// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i18n_region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

I18nRegion _$I18nRegionFromJson(Map<String, dynamic> json) => I18nRegion(
  kind: json['kind'] as String? ?? 'youtube#i18nRegion',
  etag: json['etag'] as String,
  id: json['id'] as String,
  snippet: I18nRegionSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
);

Map<String, dynamic> _$I18nRegionToJson(I18nRegion instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'id': instance.id,
      'snippet': instance.snippet,
    };
