import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'content_details.g.dart';

///The contentDetails object is included in the resource if the included item is a YouTube video. The object contains additional information about the video.
@JsonSerializable()
class ContentDetails {
  ///The ID that YouTube uses to uniquely identify a video. To retrieve the video resource, set the id query parameter to this value in your API request.
  final String videoId;

  ///A user-generated note for this item. The property value has a maximum length of 280 characters.
  final String? note;

  ///The date and time that the video was published to YouTube. The value is specified in ISO 8601 format.
  final DateTime videoPublishedAt;

  ContentDetails({
    required this.videoId,
    this.note,
    required this.videoPublishedAt,
  });

  factory ContentDetails.fromJson(Map<String, dynamic> json) =>
      _$ContentDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ContentDetailsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
