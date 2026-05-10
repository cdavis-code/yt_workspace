// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_abuse_report_reason.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoAbuseReportReason _$VideoAbuseReportReasonFromJson(
  Map<String, dynamic> json,
) => VideoAbuseReportReason(
  kind: json['kind'] as String,
  etag: json['etag'] as String,
  id: json['id'] as String,
  snippet: json['snippet'] == null
      ? null
      : VideoAbuseReportReasonSnippet.fromJson(
          json['snippet'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$VideoAbuseReportReasonToJson(
  VideoAbuseReportReason instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'id': instance.id,
  'snippet': instance.snippet,
};
