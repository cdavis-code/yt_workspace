import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../response_metadata.dart';
import '../thumbnail.dart';

part 'thumbnails_set_response.g.dart';

@JsonSerializable()
class ThumbnailsSetResponse extends ResponseMetadata {
  final List<Map<String, Thumbnail>> items;

  ThumbnailsSetResponse({
    required super.kind,
    required super.etag,
    required this.items,
  });

  factory ThumbnailsSetResponse.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailsSetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailsSetResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
