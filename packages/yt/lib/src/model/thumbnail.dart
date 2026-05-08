import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'thumbnail.g.dart';

///A map of thumbnail images associated with the broadcast. For each nested object in this object, the key is the name of the thumbnail image, and the value is an object that contains other information about the thumbnail.
@JsonSerializable()
class Thumbnail {
  ///The image's URL.
  final String url;

  ///The image's width.
  final int? width;

  ///The image's height.
  final int? height;

  Thumbnail({required this.url, this.width, this.height});

  factory Thumbnail.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
