import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'activity_snippet.g.dart';

/// The snippet object contains basic details about the activity, including the activity's type and group ID.
@JsonSerializable(explicitToJson: true)
class ActivitySnippet {
  /// The date and time that the activity occurred.
  final String? publishedAt;

  /// The ID that YouTube uses to uniquely identify the channel associated with the activity.
  final String? channelId;

  /// The title of the resource primarily associated with the activity.
  final String? title;

  /// The description of the resource primarily associated with the activity.
  final String? description;

  /// A map of thumbnail images associated with the resource.
  final Map<String, dynamic>? thumbnails;

  /// Channel title for the channel responsible for this activity.
  final String? channelTitle;

  /// The type of activity that the resource describes.
  final String? type;

  /// The group ID associated with the activity.
  final String? groupId;

  ActivitySnippet({
    this.publishedAt,
    this.channelId,
    this.title,
    this.description,
    this.thumbnails,
    this.channelTitle,
    this.type,
    this.groupId,
  });

  factory ActivitySnippet.fromJson(Map<String, dynamic> json) =>
      _$ActivitySnippetFromJson(json);

  Map<String, dynamic> toJson() => _$ActivitySnippetToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
