import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../response_metadata.dart';
import 'activity_snippet.dart';
import 'activity_content_details.dart';

part 'activity.g.dart';

/// An activity resource contains information about an action that a particular channel, or user, has taken on YouTube.
@JsonSerializable()
class Activity extends ResponseMetadata {
  /// The ID that YouTube uses to uniquely identify the activity.
  final String id;

  /// The snippet object contains basic details about the activity, including the activity's type and group ID.
  final ActivitySnippet? snippet;

  /// The contentDetails object contains information about the content associated with the activity.
  final ActivityContentDetails? contentDetails;

  Activity({
    required super.kind,
    required super.etag,
    required this.id,
    this.snippet,
    this.contentDetails,
  });

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
