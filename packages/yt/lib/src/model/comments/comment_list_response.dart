import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

import '../page_info.dart';
import '../list_response.dart';
import 'comment.dart';

part 'comment_list_response.g.dart';

/// A comment resource contains information about a single YouTube comment. A comment resource can represent a comment about either a video or a channel. In addition, the comment could be a top-level comment or a reply to a top-level comment.
@JsonSerializable()
class CommentListResponse extends ListResponse {
  /// A list of comments that match the request criteria.
  @JsonKey(name: 'items')
  final List<Comment>? commentItems;

  CommentListResponse({
    required super.kind,
    required super.etag,
    super.nextPageToken,
    super.prevPageToken,
    super.pageInfo,
    this.commentItems,
  });

  List<Comment> get items => commentItems ?? [];

  factory CommentListResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommentListResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
