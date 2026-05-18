import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'cuepoint.g.dart';

/// The Cuepoint resource identifies a cuepoint in a live broadcast video stream.
/// A cuepoint can be used to trigger an ad break.
@JsonSerializable()
class Cuepoint {
  /// The ID that YouTube assigns to uniquely identify the cuepoint. Output only.
  final String? id;

  /// The cuepoint's type. The only currently supported value is `cueTypeAd`.
  final String cueType;

  /// The duration, in seconds, of the cuepoint. The default value is `30`.
  final int? durationSecs;

  /// The offset, in milliseconds, when YouTube should insert the cuepoint. The
  /// time offset is measured relative to the time that the broadcast began.
  ///
  /// Note that you can only specify a value for either `insertionOffsetTimeMs`
  /// or `walltimeMs`, but not both.
  final int? insertionOffsetTimeMs;

  /// The wall clock time at which the cuepoint should be inserted. The value is
  /// specified as a number of milliseconds since the Unix epoch.
  ///
  /// Note that you can only specify a value for either `insertionOffsetTimeMs`
  /// or `walltimeMs`, but not both.
  final int? walltimeMs;

  Cuepoint({
    this.id,
    this.cueType = 'cueTypeAd',
    this.durationSecs,
    this.insertionOffsetTimeMs,
    this.walltimeMs,
  });

  factory Cuepoint.fromJson(Map<String, dynamic> json) =>
      _$CuepointFromJson(json);

  Map<String, dynamic> toJson() => _$CuepointToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
