// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caption_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptionItem _$CaptionItemFromJson(Map<String, dynamic> json) => CaptionItem(
  kind: json['kind'] as String,
  etag: json['etag'] as String,
  id: json['id'] as String,
  snippet: json['snippet'] == null
      ? null
      : CaptionSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CaptionItemToJson(CaptionItem instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'id': instance.id,
      'snippet': instance.snippet,
    };
