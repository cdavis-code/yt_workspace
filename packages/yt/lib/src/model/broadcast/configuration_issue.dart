import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'configuration_issue.g.dart';

///This object contains a descriptions of a configuration issue affecting the stream.
@JsonSerializable()
class ConfigurationIssue {
  ///Identifies the type of error affecting the stream.
  final String? type;

  ///Indicates how severe the issue is to the stream.
  ///
  ///Valid values for this property are:
  ///- info – The video is broadcast to viewers with no adverse effect on performance.
  ///- infowarning – The video is broadcast to viewers, but performance is not optimal.
  ///- infoerror – The video cannot be broadcast to viewers.
  final String? severity;

  ///A short description of the issue. The Configuration Issues for LiveStream Resources document identifies the reason associated with each configuration issue type.
  final String? reason;

  ///A detailed description of the issue. When possible, the description provides information about how to resolve the issue. The Configuration Issues for LiveStream Resources document lists all of the configuration issue types and their associated descriptions.
  final String? description;

  ConfigurationIssue({this.type, this.severity, this.reason, this.description});

  factory ConfigurationIssue.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationIssueFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationIssueToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
