import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../response_metadata.dart';
import 'video_abuse_report_reason.dart';

part 'video_abuse_report_reason_list_response.g.dart';

@JsonSerializable()
class VideoAbuseReportReasonListResponse extends ResponseMetadata {
  final List<VideoAbuseReportReason> items;

  VideoAbuseReportReasonListResponse({
    required super.kind,
    required super.etag,
    required this.items,
  });

  factory VideoAbuseReportReasonListResponse.fromJson(
          Map<String, dynamic> json) =>
      _$VideoAbuseReportReasonListResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$VideoAbuseReportReasonListResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}