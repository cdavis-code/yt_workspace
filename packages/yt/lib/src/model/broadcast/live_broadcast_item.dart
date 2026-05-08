import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../response_metadata.dart';
import 'content_details.dart';
import 'snippet.dart';
import 'statistics.dart';
import 'status.dart';

part 'live_broadcast_item.g.dart';

/// [LiveBroadcastItem] Resource
@JsonSerializable(explicitToJson: true)
class LiveBroadcastItem extends ResponseMetadata
    implements Comparable<LiveBroadcastItem> {
  /// The ID that YouTube assigns to uniquely identify the broadcast.
  final String id;

  /// The [Snippet] object contains basic details about the event, including its [Snippet.title], [Snippet.description], [Snippet.scheduledStartTime], and [Snippet.scheduledEndTime].
  final Snippet? snippet;

  /// The [Status] object contains information about the event's status.
  final Status? status;

  /// The [ContentDetails] object contains information about the event's video content, such as whether the content can be shown in an embedded video player or if it will be archived and therefore available for viewing after the event has concluded.
  final ContentDetails? contentDetails;

  /// The [Statistics] object contains statistics related to a live broadcast. The values for these statistics can change during the broadcast and can only be retrieved while the broadcast is live.
  final Statistics? statistics;

  LiveBroadcastItem({
    required super.kind,
    required super.etag,
    required this.id,
    this.snippet,
    this.status,
    this.contentDetails,
    this.statistics,
  });

  factory LiveBroadcastItem.fromJson(Map<String, dynamic> json) =>
      _$LiveBroadcastItemFromJson(json);

  Map<String, dynamic> toJson() => _$LiveBroadcastItemToJson(this);

  @override
  String toString() => jsonEncode(toJson());

  @override
  int compareTo(other) =>
      defaultStartTime(
        DateTime.fromMillisecondsSinceEpoch(0).toUtc(),
      ).compareTo(
        other.defaultStartTime(DateTime.fromMillisecondsSinceEpoch(0).toUtc()),
      );

  DateTime defaultStartTime([DateTime? otherwise]) =>
      snippet != null && snippet!.scheduledStartTime != null
      ? snippet!.scheduledStartTime!
      : otherwise ?? DateTime.fromMillisecondsSinceEpoch(0).toUtc();
}
