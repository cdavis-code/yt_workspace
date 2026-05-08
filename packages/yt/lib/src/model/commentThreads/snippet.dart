import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:yt/src/model/comments/comment.dart';

import 'replies.dart';

part 'snippet.g.dart';

@JsonSerializable()
/// The snippet object contains basic details about the comment thread. It also contains the thread's top-level comment, which is a comment resource.
class Snippet {
  /// The YouTube channel that is associated with the comments in the thread. (The snippet.videoId property identifies the video.)
  /// - If the comments are about a video, then the value identifies the channel that uploaded the video. (The snippet.videoId property identifies the video.)
  /// - If the comments refer to the channel itself, the snippet.videoId property will not have a value.
  final String? channelId;

  /// The ID of the video that the comments refer to, if any. If this property is not present or does not have a value, then the thread applies to the channel and not to a specific video.
  final String videoId;

  /// The thread's top-level comment. The property's value is a comment resource.
  final Comment topLevelComment;

  /// This setting indicates whether the current viewer can reply to the thread.
  final bool canReply;

  /// The total number of replies that have been submitted in response to the top-level comment.
  final int totalReplyCount;

  /// This setting indicates whether the thread, including all of its comments and comment replies, is visible to all YouTube users.
  final bool isPublic;

  /// The replies object is a container that contains a list of replies to the comment, if any exist. The replies.comments property represents the list of comments itself.
  final Replies? replies;

  Snippet({
    this.channelId,
    required this.videoId,
    required this.topLevelComment,
    required this.canReply,
    required this.totalReplyCount,
    required this.isPublic,
    this.replies,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);

  Map<String, dynamic> toJson() => _$SnippetToJson(this);

  @override
  String toString() => json.encode(toJson());
}
