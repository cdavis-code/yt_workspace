import 'package:json_annotation/json_annotation.dart';

import 'secondary_reason.dart';

part 'video_abuse_report_reason_snippet.g.dart';

@JsonSerializable()
class VideoAbuseReportReasonSnippet {
  final String label;

  @JsonKey(name: 'secondaryReasons')
  final List<SecondaryReason>? secondaryReasons;

  VideoAbuseReportReasonSnippet({required this.label, this.secondaryReasons});

  factory VideoAbuseReportReasonSnippet.fromJson(Map<String, dynamic> json) =>
      _$VideoAbuseReportReasonSnippetFromJson(json);

  Map<String, dynamic> toJson() => _$VideoAbuseReportReasonSnippetToJson(this);
}
