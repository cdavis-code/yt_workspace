import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../response_metadata.dart';
import 'category_snippet.dart';

part 'video_category.g.dart';

/// A videoCategory resource identifies a category that has been or could be associated with uploaded videos.
@JsonSerializable()
class VideoCategory extends ResponseMetadata {
  /// The ID that YouTube uses to uniquely identify the video category.
  final String id;

  /// The snippet object contains basic details about the video category, including its title.
  final CategorySnippet? snippet;

  VideoCategory({
    required super.kind,
    required super.etag,
    required this.id,
    this.snippet,
  });

  factory VideoCategory.fromJson(Map<String, dynamic> json) =>
      _$VideoCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$VideoCategoryToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
