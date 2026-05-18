// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i18n_region_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

I18nRegionListResponse _$I18nRegionListResponseFromJson(
  Map<String, dynamic> json,
) => I18nRegionListResponse(
  kind: json['kind'] as String? ?? 'youtube#i18nRegionListResponse',
  etag: json['etag'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => I18nRegion.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$I18nRegionListResponseToJson(
  I18nRegionListResponse instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'items': instance.items,
};
