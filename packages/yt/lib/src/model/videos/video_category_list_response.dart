import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../response_metadata.dart';
import 'video_category.dart';

part 'video_category_list_response.g.dart';

@JsonSerializable()
class VideoCategoryListResponse extends ResponseMetadata {
  /// A list of video categories that can be associated with YouTube videos. In this map, the video category ID is the map key, and its value is the corresponding videoCategory resource.
  @JsonKey(name: 'items')
  final List<VideoCategory>? videoCategoryItems;

  VideoCategoryListResponse({
    required super.kind,
    required super.etag,
    this.videoCategoryItems,
  });

  List<VideoCategory> get items => videoCategoryItems ?? [];

  factory VideoCategoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$VideoCategoryListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VideoCategoryListResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
