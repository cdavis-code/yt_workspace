// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'super_sticker_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperStickerMetadata _$SuperStickerMetadataFromJson(
  Map<String, dynamic> json,
) => SuperStickerMetadata(
  stickerId: json['stickerId'] as String?,
  altText: json['altText'] as String?,
  language: json['language'] as String?,
);

Map<String, dynamic> _$SuperStickerMetadataToJson(
  SuperStickerMetadata instance,
) => <String, dynamic>{
  'stickerId': instance.stickerId,
  'altText': instance.altText,
  'language': instance.language,
};
