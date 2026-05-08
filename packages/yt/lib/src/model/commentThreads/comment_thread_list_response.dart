import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

import '../page_info.dart';
import '../list_response.dart';
import 'comment_thread.dart';

part 'comment_thread_list_response.g.dart';

/// A comment resource contains information about a single YouTube comment. A comment resource can represent a comment about either a video or a channel. In addition, the comment could be a top-level comment or a reply to a top-level comment.
@JsonSerializable()
class CommentThreadListResponse extends ListResponse {
  /// A list of comments that match the request criteria.
  @JsonKey(name: 'items')
  final List<CommentThread>? commentThreadItems;

  CommentThreadListResponse({
    required super.kind,
    required super.etag,
    super.nextPageToken,
    super.prevPageToken,
    required super.pageInfo,
    this.commentThreadItems,
  });

  List<CommentThread> get items => commentThreadItems ?? [];

  factory CommentThreadListResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentThreadListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommentThreadListResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
