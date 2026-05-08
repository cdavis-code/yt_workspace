import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../page_info.dart';
import '../list_response.dart';
import 'video_item.dart';

part 'video_list_response.g.dart';

/// Retrieves the ratings that the authorized user gave to a list of specified videos.
@JsonSerializable()
class VideoListResponse extends ListResponse {
  /// A list of videos that match the request criteria.
  @JsonKey(name: 'items')
  final List<VideoItem>? videoItems;

  VideoListResponse({
    required super.kind,
    required super.etag,
    super.nextPageToken,
    super.prevPageToken,
    required super.pageInfo,
    this.videoItems,
  });

  List<VideoItem> get items => videoItems ?? [];

  factory VideoListResponse.fromJson(Map<String, dynamic> json) =>
      _$VideoListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VideoListResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
