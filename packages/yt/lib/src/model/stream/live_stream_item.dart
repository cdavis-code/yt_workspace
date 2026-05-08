import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../response_metadata.dart';
import 'cdn.dart';
import 'snippet.dart';
import 'status.dart';

part 'live_stream_item.g.dart';

/// A liveStream resource contains information about the video stream that you are transmitting to YouTube. The stream provides the content that will be broadcast to YouTube users. Once created, a liveStream resource can be bound to one or more liveBroadcast resources.
@JsonSerializable()
class LiveStreamItem extends ResponseMetadata {
  /// The ID that YouTube assigns to uniquely identify the stream.
  final String id;

  /// The snippet object contains basic details about the stream, including its channel, title, and description.
  final Snippet? snippet;

  /// The cdn object defines the live stream's content delivery network (CDN) settings. These settings provide details about the manner in which you stream your content to YouTube.
  final Cdn? cdn;

  /// The status object contains information about live stream's status.
  final Status? status;

  LiveStreamItem({
    required super.kind,
    required super.etag,
    required this.id,
    this.snippet,
    this.status,
    this.cdn,
  });

  factory LiveStreamItem.fromJson(Map<String, dynamic> json) =>
      _$LiveStreamItemFromJson(json);

  Map<String, dynamic> toJson() => _$LiveStreamItemToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
