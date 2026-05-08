import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../response_metadata.dart';
import 'content_details.dart';
import 'live_streaming_details.dart';
import 'player.dart';
import 'snippet.dart';
import 'statistics.dart';
import 'status.dart';

part 'video_item.g.dart';

/// A video resource represents a YouTube video.
@JsonSerializable()
class VideoItem extends ResponseMetadata {
  /// The ID that YouTube uses to uniquely identify the video.
  final String id;

  /// The snippet object contains basic details about the video, such as its title, description, and category.
  final Snippet? snippet;

  /// The contentDetails object contains information about the video content, including the length of the video and an indication of whether captions are available for the video.
  final ContentDetails? contentDetails;

  /// The status object contains information about the video's uploading, processing, and privacy statuses.
  final Status? status;

  /// The statistics object contains statistics about the video.
  final Statistics? statistics;

  /// The player object contains information that you would use to play the video in an embedded player.
  final Player? player;

  // final FileDetails? fileDetails;
  // final ProcessingDetails? processingDetails;
  // final Suggestions? suggestions;
  final LiveStreamingDetails? liveStreamingDetails;
  // final Localizations? localizations;

  VideoItem({
    required super.kind,
    required super.etag,
    required this.id,
    this.snippet,
    this.status,
    this.contentDetails,
    this.statistics,
    this.player,
    this.liveStreamingDetails,
  });

  factory VideoItem.fromJson(Map<String, dynamic> json) =>
      _$VideoItemFromJson(json);

  Map<String, dynamic> toJson() => _$VideoItemToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
