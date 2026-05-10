import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../response_metadata.dart';
import 'video_abuse_report_reason_snippet.dart';

part 'video_abuse_report_reason.g.dart';

@JsonSerializable()
class VideoAbuseReportReason extends ResponseMetadata {
  final String id;
  final VideoAbuseReportReasonSnippet? snippet;

  VideoAbuseReportReason({
    required super.kind,
    required super.etag,
    required this.id,
    this.snippet,
  });

  factory VideoAbuseReportReason.fromJson(Map<String, dynamic> json) =>
      _$VideoAbuseReportReasonFromJson(json);

  Map<String, dynamic> toJson() => _$VideoAbuseReportReasonToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}