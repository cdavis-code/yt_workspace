// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentDetails _$ContentDetailsFromJson(Map<String, dynamic> json) =>
    ContentDetails(
      videoId: json['videoId'] as String,
      note: json['note'] as String?,
      videoPublishedAt: DateTime.parse(json['videoPublishedAt'] as String),
    );

Map<String, dynamic> _$ContentDetailsToJson(ContentDetails instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'note': instance.note,
      'videoPublishedAt': instance.videoPublishedAt.toIso8601String(),
    };
