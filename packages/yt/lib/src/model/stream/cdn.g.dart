// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cdn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cdn _$CdnFromJson(Map<String, dynamic> json) => Cdn(
  ingestionType: json['ingestionType'] as String,
  ingestionInfo: IngestionInfo.fromJson(
    json['ingestionInfo'] as Map<String, dynamic>,
  ),
  resolution: json['resolution'] as String,
  frameRate: json['frameRate'] as String,
);

Map<String, dynamic> _$CdnToJson(Cdn instance) => <String, dynamic>{
  'ingestionType': instance.ingestionType,
  'ingestionInfo': instance.ingestionInfo.toJson(),
  'resolution': instance.resolution,
  'frameRate': instance.frameRate,
};
