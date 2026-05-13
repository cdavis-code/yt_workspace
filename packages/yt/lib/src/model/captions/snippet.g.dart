// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptionSnippet _$CaptionSnippetFromJson(Map<String, dynamic> json) =>
    CaptionSnippet(
      videoId: json['videoId'] as String,
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
      trackKind: json['trackKind'] as String?,
      language: json['language'] as String?,
      name: json['name'] as String?,
      audioTrackType: json['audioTrackType'] as String?,
      isCC: json['isCC'] as bool?,
      isLarge: json['isLarge'] as bool?,
      isEasyReader: json['isEasyReader'] as bool?,
      isDraft: json['isDraft'] as bool?,
      isAutoSynced: json['isAutoSynced'] as bool?,
      status: json['status'] as String?,
      failureReason: json['failureReason'] as String?,
    );

Map<String, dynamic> _$CaptionSnippetToJson(CaptionSnippet instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
      'trackKind': instance.trackKind,
      'language': instance.language,
      'name': instance.name,
      'audioTrackType': instance.audioTrackType,
      'isCC': instance.isCC,
      'isLarge': instance.isLarge,
      'isEasyReader': instance.isEasyReader,
      'isDraft': instance.isDraft,
      'isAutoSynced': instance.isAutoSynced,
      'status': instance.status,
      'failureReason': instance.failureReason,
    };
