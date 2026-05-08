import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../response_metadata.dart';
import 'snippet.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment extends ResponseMetadata {
  final String id;
  final Snippet? snippet;

  Comment({
    required super.kind,
    required super.etag,
    required this.id,
    this.snippet,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  @override
  String toString() => json.encode(toJson());
}
