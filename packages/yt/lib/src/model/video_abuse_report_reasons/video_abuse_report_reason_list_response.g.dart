// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_abuse_report_reason_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoAbuseReportReasonListResponse _$VideoAbuseReportReasonListResponseFromJson(
  Map<String, dynamic> json,
) => VideoAbuseReportReasonListResponse(
  kind: json['kind'] as String,
  etag: json['etag'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => VideoAbuseReportReason.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$VideoAbuseReportReasonListResponseToJson(
  VideoAbuseReportReasonListResponse instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'items': instance.items,
};
