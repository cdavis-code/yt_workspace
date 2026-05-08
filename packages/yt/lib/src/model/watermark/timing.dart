import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'timing.g.dart';

/// The timing object encapsulates information about the time during a video
/// playback when a channel's watermark image will display.
@JsonSerializable()
class Timing {
  /// The timing method that determines when the watermark image is displayed
  /// during the video playback. If the value is offsetFromStart, then the
  /// offsetMs field represents an offset from the start of the video. If the
  /// value is offsetFromEnd, then the offsetMs field represents an offset from
  /// the end of the video.
  final String type;

  /// The time offset, specified in milliseconds, that determines when the
  /// promoted item appears during video playbacks. The type property's value
  /// determines whether the offset is measured from the start or end of the
  /// video.
  final int offsetMs;

  /// The length of time, in milliseconds, that the watermark image should
  /// display.
  final int durationMs;

  Timing({
    required this.type,
    required this.offsetMs,
    required this.durationMs,
  });

  factory Timing.fromJson(Map<String, dynamic> json) => _$TimingFromJson(json);

  Map<String, dynamic> toJson() => _$TimingToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
