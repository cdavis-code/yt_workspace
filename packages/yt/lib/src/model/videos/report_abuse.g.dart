// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_abuse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportAbuse _$ReportAbuseFromJson(Map<String, dynamic> json) => ReportAbuse(
  videoId: json['videoId'] as String,
  reasonId: json['reasonId'] as String,
  secondaryReasonId: json['secondaryReasonId'] as String?,
  comments: json['comments'] as String?,
  language: json['language'] as String?,
);

Map<String, dynamic> _$ReportAbuseToJson(ReportAbuse instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'reasonId': instance.reasonId,
      'secondaryReasonId': instance.secondaryReasonId,
      'comments': instance.comments,
      'language': instance.language,
    };
