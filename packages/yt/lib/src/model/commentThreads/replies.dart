import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:yt/src/model/comments/comment.dart';

part 'replies.g.dart';

/// The replies object is a container that contains a list of replies to the comment, if any exist. The replies.comments property represents the list of comments itself.
@JsonSerializable()
class Replies {
  /// A list of one or more replies to the top-level comment. Each item in the list is a comment resource.
  ///
  /// The list contains a limited number of replies, and unless the number of items in the list equals the value of the snippet.totalReplyCount property, the list of replies is only a subset of the total number of replies available for the top-level comment. To retrieve all of the replies for the top-level comment, you need to call the comments.list method and use the parentId request parameter to identify the comment for which you want to retrieve replies.
  final List<Comment> value;

  Replies({required this.value});

  factory Replies.fromJson(Map<String, dynamic> json) =>
      _$RepliesFromJson(json);

  Map<String, dynamic> toJson() => _$RepliesToJson(this);

  @override
  String toString() => json.encode(toJson());
}
