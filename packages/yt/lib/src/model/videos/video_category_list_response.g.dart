// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_category_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoCategoryListResponse _$VideoCategoryListResponseFromJson(
  Map<String, dynamic> json,
) => VideoCategoryListResponse(
  kind: json['kind'] as String,
  etag: json['etag'] as String,
  videoCategoryItems: (json['items'] as List<dynamic>?)
      ?.map((e) => VideoCategory.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$VideoCategoryListResponseToJson(
  VideoCategoryListResponse instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'items': instance.videoCategoryItems,
};
