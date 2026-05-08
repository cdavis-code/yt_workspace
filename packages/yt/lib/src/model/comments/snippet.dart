import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'author_channel_id.dart';

part 'snippet.g.dart';

@JsonSerializable()
/// The snippet object contains basic details about the comment.
class Snippet {
  /// The display name of the user who posted the comment.
  final String authorDisplayName;

  /// The URL for the avatar of the user who posted the comment.
  final String authorProfileImageUrl;

  /// The URL of the comment author's YouTube channel, if available.
  final String authorChannelUrl;

  /// This object encapsulates information about the comment author's YouTube channel, if available.
  final AuthorChannelId authorChannelId;

  /// The ID of the YouTube channel associated with the comment.
  /// - If the comment is a video comment, then this property identifies the video's channel, and the snippet.videoId property identifies the video.
  /// -If the comment is a channel comment, then this property identifies the channel that the comment is about.
  final String? channelId;

  /// The ID of the video that the comment refers to. This property is only present if the comment was made on a video.
  final String? videoId;

  /// The comment's text. The text can be retrieved in either plain text or HTML. (The comments.list and commentThreads.list methods both support a textFormat parameter, which specifies the desired text format.)
  ///
  /// Note that even the plain text may differ from the original comment text. For example, it may replace video links with video titles.
  final String textDisplay;

  /// The original, raw text of the comment as it was initially posted or last updated. The original text is only returned if it is accessible to the authenticated user, which is only guaranteed if the user is the comment's author.
  final String textOriginal;

  /// The unique ID of the parent comment. This property is only set if the comment was submitted as a reply to another comment.
  final String? parentId;

  /// This setting indicates whether the current viewer can rate the comment.
  final bool canRate;

  /// The rating the viewer has given to this comment. Note that this property does not currently identify dislike ratings, though this behavior is subject to change. In the meantime, the property value is like if the viewer has rated the comment positively. The value is none in all other cases, including the user having given the comment a negative rating or not having rated the comment.
  ///
  /// Valid values for this property are:
  /// - like
  /// - none
  final String viewerRating;

  /// The total number of likes (positive ratings) the comment has received.
  final int likeCount;

  /// The comment's moderation status. This property is only returned if the API request was authorized by the owner of the channel or the video on which the requested comments were made. In addition, note that this property is not set if the API request used the id filter parameter.
  ///
  /// Valid values for this property are:
  /// - heldForReview
  /// - likelySpam
  /// - published
  /// - rejected
  final String? moderationStatus;

  /// The date and time when the comment was originally published. The value is specified in ISO 8601 format.
  final DateTime publishedAt;

  /// The date and time when the comment was last updated. The value is specified in ISO 8601 format.
  final DateTime updatedAt;

  Snippet({
    required this.authorDisplayName,
    required this.authorProfileImageUrl,
    required this.authorChannelUrl,
    required this.authorChannelId,
    this.channelId,
    this.videoId,
    required this.textDisplay,
    required this.textOriginal,
    this.parentId,
    required this.canRate,
    required this.viewerRating,
    required this.likeCount,
    this.moderationStatus,
    required this.publishedAt,
    required this.updatedAt,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);

  Map<String, dynamic> toJson() => _$SnippetToJson(this);

  @override
  String toString() => json.encode(toJson());
}
