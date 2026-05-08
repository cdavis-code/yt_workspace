import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'thumbnail.dart';

part 'thumbnails.g.dart';

///Valid key values are:
///- default – The default thumbnail image. The default thumbnail for a video – or a resource that refers to a video, such as a playlist item or search result – is 120px wide and 90px tall. The default thumbnail for a channel is 88px wide and 88px tall.
///- medium – A higher resolution version of the thumbnail image. For a video (or a resource that refers to a video), this image is 320px wide and 180px tall. For a channel, this image is 240px wide and 240px tall.
///- high – A high resolution version of the thumbnail image. For a video (or a resource that refers to a video), this image is 480px wide and 360px tall. For a channel, this image is 800px wide and 800px tall.
@JsonSerializable(explicitToJson: true)
class Thumbnails {
  @JsonKey(name: 'default')
  final Thumbnail thumbnailsDefault;
  final Thumbnail? medium;
  final Thumbnail? high;
  final Thumbnail? standard;
  final Thumbnail? maxres;

  Thumbnails({
    required this.thumbnailsDefault,
    this.medium,
    this.high,
    required this.standard,
    this.maxres,
  });

  factory Thumbnails.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailsFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
