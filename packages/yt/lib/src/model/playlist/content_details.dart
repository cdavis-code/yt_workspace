import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'content_details.g.dart';

///The contentDetails object contains information about the playlist content, including the number of videos in the playlist.
@JsonSerializable()
class ContentDetails {
  ///The number of videos in the playlist.
  final int itemCount;

  ContentDetails({required this.itemCount});

  factory ContentDetails.fromJson(Map<String, dynamic> json) =>
      _$ContentDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ContentDetailsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
