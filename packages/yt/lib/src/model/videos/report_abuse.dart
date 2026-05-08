import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'report_abuse.g.dart';

///Reports a video for containing abusive content.
@JsonSerializable()
class ReportAbuse {
  ///Identifies the video that is being reported for containing abusive content. Set the value to that video's YouTube video ID.
  final String videoId;

  ///Specifies the reason that the video that is being reported for containing abusive content. Set the value to the appropriate videoAbuseReportReason resource's unique ID.
  final String reasonId;

  ///Specifies the secondary reason that the video that is being reported for containing abusive content. A secondary reason provides a more specific description of the objectionable content than the primary reason, which the reasonId property identifies. Set the value to the appropriate secondary reason's unique ID.
  final String? secondaryReasonId;

  ///Provides any additional information that the reporter wants to add.
  final String? comments;

  ///Identifies a language spoken by the reporter.
  final String? language;

  ReportAbuse({
    required this.videoId,
    required this.reasonId,
    this.secondaryReasonId,
    this.comments,
    this.language,
  });

  factory ReportAbuse.fromJson(Map<String, dynamic> json) =>
      _$ReportAbuseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportAbuseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
