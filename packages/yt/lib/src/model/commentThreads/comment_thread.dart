import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../response_metadata.dart';
import 'snippet.dart';

part 'comment_thread.g.dart';

@JsonSerializable()
class CommentThread extends ResponseMetadata {
  final String id;
  final Snippet? snippet;

  CommentThread({
    required super.kind,
    required super.etag,
    required this.id,
    this.snippet,
  });

  factory CommentThread.fromJson(Map<String, dynamic> json) =>
      _$CommentThreadFromJson(json);

  Map<String, dynamic> toJson() => _$CommentThreadToJson(this);

  @override
  String toString() => json.encode(toJson());
}
