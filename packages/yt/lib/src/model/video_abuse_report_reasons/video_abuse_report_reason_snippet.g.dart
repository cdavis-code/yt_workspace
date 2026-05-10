// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_abuse_report_reason_snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoAbuseReportReasonSnippet _$VideoAbuseReportReasonSnippetFromJson(
  Map<String, dynamic> json,
) => VideoAbuseReportReasonSnippet(
  label: json['label'] as String,
  secondaryReasons: (json['secondaryReasons'] as List<dynamic>?)
      ?.map((e) => SecondaryReason.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$VideoAbuseReportReasonSnippetToJson(
  VideoAbuseReportReasonSnippet instance,
) => <String, dynamic>{
  'label': instance.label,
  'secondaryReasons': instance.secondaryReasons,
};
