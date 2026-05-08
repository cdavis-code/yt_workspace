import 'dart:convert';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:universal_io/io.dart';

import 'timing.dart';
import 'position.dart';

part 'watermarks_resource.g.dart';

/// A watermark resource identifies an image that displays during playbacks of a
/// specified channel's videos. You can also specify a target channel to which
/// the image will link as well as timing details that determine when the
/// watermark appears during video playbacks and the length of time it is
/// visible.
@JsonSerializable()
class WatermarksResource {
  /// The timing object encapsulates information about the time during a video
  /// playback when a channel's watermark image will display.
  final Timing timing;

  /// The position object encapsulates information about the spatial position
  /// within the video where the watermark image will display.
  final Position position;

  /// The URL for the channel's watermark image. YouTube will generate this URL
  /// and return it in the API response to a watermark.set request.
  String? imageUrl;

  /// The size of the watermark image, in bytes.
  @JsonKey(fromJson: stringToUint8List, toJson: imageBytesToList)
  final Uint8List imageBytes;

  /// The YouTube channel ID of the channel that the watermark image links to.
  final String targetChannelId;

  WatermarksResource({
    required this.timing,
    required this.position,
    this.imageUrl = '',
    required this.imageBytes,
    required this.targetChannelId,
  });

  factory WatermarksResource.fromFile({
    required Timing timing,
    required Position position,
    String? imageUrl = '',
    required File imageFile,
    required String targetChannelId,
  }) => WatermarksResource(
    timing: timing,
    position: position,
    imageUrl: imageUrl,
    imageBytes: imageFile.readAsBytesSync(),
    targetChannelId: targetChannelId,
  );

  factory WatermarksResource.fromFilePath({
    required Timing timing,
    required Position position,
    String? imageUrl = '',
    required String imageFileName,
    required String targetChannelId,
  }) => WatermarksResource.fromFile(
    timing: timing,
    position: position,
    imageUrl: imageUrl,
    imageFile: File(imageFileName),
    targetChannelId: targetChannelId,
  );

  factory WatermarksResource.fromJson(Map<String, dynamic> json) =>
      _$WatermarksResourceFromJson(json);

  Map<String, dynamic> toJson() => _$WatermarksResourceToJson(this);

  @override
  String toString() => jsonEncode(toJson());

  static List<int> imageBytesToList(Uint8List imageBytes) =>
      List.from(imageBytes);

  static Uint8List stringToUint8List(List<int> value) =>
      Uint8List.fromList(value);
}
