// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_stream_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveStreamItem _$LiveStreamItemFromJson(Map<String, dynamic> json) =>
    LiveStreamItem(
      kind: json['kind'] as String,
      etag: json['etag'] as String,
      id: json['id'] as String,
      snippet: json['snippet'] == null
          ? null
          : Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
      status: json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      cdn: json['cdn'] == null
          ? null
          : Cdn.fromJson(json['cdn'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LiveStreamItemToJson(LiveStreamItem instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'id': instance.id,
      'snippet': instance.snippet,
      'cdn': instance.cdn,
      'status': instance.status,
    };
