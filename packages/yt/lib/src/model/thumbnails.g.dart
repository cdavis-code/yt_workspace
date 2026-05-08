// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Thumbnails _$ThumbnailsFromJson(Map<String, dynamic> json) => Thumbnails(
  thumbnailsDefault: Thumbnail.fromJson(
    json['default'] as Map<String, dynamic>,
  ),
  medium: json['medium'] == null
      ? null
      : Thumbnail.fromJson(json['medium'] as Map<String, dynamic>),
  high: json['high'] == null
      ? null
      : Thumbnail.fromJson(json['high'] as Map<String, dynamic>),
  standard: json['standard'] == null
      ? null
      : Thumbnail.fromJson(json['standard'] as Map<String, dynamic>),
  maxres: json['maxres'] == null
      ? null
      : Thumbnail.fromJson(json['maxres'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ThumbnailsToJson(Thumbnails instance) =>
    <String, dynamic>{
      'default': instance.thumbnailsDefault.toJson(),
      'medium': instance.medium?.toJson(),
      'high': instance.high?.toJson(),
      'standard': instance.standard?.toJson(),
      'maxres': instance.maxres?.toJson(),
    };
