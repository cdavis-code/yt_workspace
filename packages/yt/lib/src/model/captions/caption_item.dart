import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../response_metadata.dart';
import 'snippet.dart';

part 'caption_item.g.dart';

/// A caption resource contains information about a YouTube video caption track.
@JsonSerializable()
class CaptionItem extends ResponseMetadata {
  /// The ID that YouTube uses to uniquely identify the caption track.
  final String id;

  /// The snippet object contains basic details about the caption track.
  final CaptionSnippet? snippet;

  CaptionItem({
    required super.kind,
    required super.etag,
    required this.id,
    this.snippet,
  });

  factory CaptionItem.fromJson(Map<String, dynamic> json) =>
      _$CaptionItemFromJson(json);

  Map<String, dynamic> toJson() => _$CaptionItemToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
