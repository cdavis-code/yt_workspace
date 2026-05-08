// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) => Thumbnail(
  url: json['url'] as String,
  width: (json['width'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
);

Map<String, dynamic> _$ThumbnailToJson(Thumbnail instance) => <String, dynamic>{
  'url': instance.url,
  'width': instance.width,
  'height': instance.height,
};
