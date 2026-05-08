import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'configuration_issue.dart';

part 'health_status.g.dart';

///This object contains information about the live stream's health status, which could be used to identify, diagnose, and resolve streaming problems.
@JsonSerializable(explicitToJson: true)
class HealthStatus {
  ///The status code of this stream.
  ///
  ///Valid values for this property are:
  ///- good – There are no configuration issues for which the severity is warning or worse.
  ///- ok – There are no configuration issues for which the severity is error.
  ///- bad – The stream has some issues for which the severity is error.
  ///- noData – YouTube's live streaming backend servers do not have any information about the stream's health status.
  final String? status;

  ///The last time that the stream's health status was updated. The value reflects a UNIX timestamp in seconds.
  final int? lastUpdateTimeSeconds;

  ///This object contains a list of configuration issues affecting the stream.
  final List<ConfigurationIssue> configurationIssues;

  HealthStatus({
    this.status,
    this.lastUpdateTimeSeconds,
    required this.configurationIssues,
  });

  factory HealthStatus.fromJson(Map<String, dynamic> json) =>
      _$HealthStatusFromJson(json);

  Map<String, dynamic> toJson() => _$HealthStatusToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
