// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnails_set_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThumbnailsSetResponse _$ThumbnailsSetResponseFromJson(
  Map<String, dynamic> json,
) => ThumbnailsSetResponse(
  kind: json['kind'] as String,
  etag: json['etag'] as String,
  items: (json['items'] as List<dynamic>)
      .map(
        (e) => (e as Map<String, dynamic>).map(
          (k, e) => MapEntry(k, Thumbnail.fromJson(e as Map<String, dynamic>)),
        ),
      )
      .toList(),
);

Map<String, dynamic> _$ThumbnailsSetResponseToJson(
  ThumbnailsSetResponse instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'items': instance.items,
};
