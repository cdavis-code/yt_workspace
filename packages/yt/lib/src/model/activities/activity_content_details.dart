import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'activity_content_details.g.dart';

/// The contentDetails object contains information about the content associated with the activity.
@JsonSerializable(explicitToJson: true)
class ActivityContentDetails {
  /// The upload object contains information about the uploaded video.
  final ActivityContentUpload? upload;

  /// The like object contains information about a resource that received a positive (like) rating.
  final ActivityContentResource? like;

  /// The favorite object contains information about a video that was marked as a favorite video.
  final ActivityContentResource? favorite;

  /// The comment object contains information about a resource that received a comment.
  final ActivityContentResource? comment;

  /// The subscription object contains information about a channel that a user subscribed to.
  final ActivityContentResource? subscription;

  /// The playlistItem object contains information about a new playlist item.
  final ActivityContentPlaylistItem? playlistItem;

  /// The recommendation object contains information about a recommended resource.
  final ActivityContentRecommendation? recommendation;

  /// The social object contains details about a social network post.
  final ActivityContentSocial? social;

  ActivityContentDetails({
    this.upload,
    this.like,
    this.favorite,
    this.comment,
    this.subscription,
    this.playlistItem,
    this.recommendation,
    this.social,
  });

  factory ActivityContentDetails.fromJson(Map<String, dynamic> json) =>
      _$ActivityContentDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityContentDetailsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}

/// Contains information about the uploaded video.
@JsonSerializable()
class ActivityContentUpload {
  /// The ID that YouTube uses to uniquely identify the uploaded video.
  final String? videoId;

  ActivityContentUpload({this.videoId});

  factory ActivityContentUpload.fromJson(Map<String, dynamic> json) =>
      _$ActivityContentUploadFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityContentUploadToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}

/// Contains information about a resource which is the target of a user activity.
@JsonSerializable()
class ActivityContentResource {
  /// An object that identifies the resource that the user liked, added to favorites, or commented on.
  final Map<String, dynamic>? resourceId;

  ActivityContentResource({this.resourceId});

  factory ActivityContentResource.fromJson(Map<String, dynamic> json) =>
      _$ActivityContentResourceFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityContentResourceToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}

/// Contains information about a new playlist item.
@JsonSerializable()
class ActivityContentPlaylistItem {
  /// An object that identifies the resource that was added to the playlist.
  final Map<String, dynamic>? resourceId;

  /// The value that YouTube uses to uniquely identify the playlist.
  final String? playlistId;

  /// The value that YouTube uses to uniquely identify the item in the playlist.
  final String? playlistItemId;

  ActivityContentPlaylistItem({
    this.resourceId,
    this.playlistId,
    this.playlistItemId,
  });

  factory ActivityContentPlaylistItem.fromJson(Map<String, dynamic> json) =>
      _$ActivityContentPlaylistItemFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityContentPlaylistItemToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}

/// Contains information about a recommended resource.
@JsonSerializable()
class ActivityContentRecommendation {
  /// An object that identifies the recommended resource.
  final Map<String, dynamic>? resourceId;

  /// The reason that the resource is recommended to the user.
  final String? reason;

  /// An object that identifies the seed resource that caused the recommendation.
  final Map<String, dynamic>? seedResourceId;

  ActivityContentRecommendation({
    this.resourceId,
    this.reason,
    this.seedResourceId,
  });

  factory ActivityContentRecommendation.fromJson(Map<String, dynamic> json) =>
      _$ActivityContentRecommendationFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityContentRecommendationToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}

/// Contains details about a social network post.
@JsonSerializable()
class ActivityContentSocial {
  /// The name of the social network.
  final String? type;

  /// An object that identifies the resource associated with a social network post.
  final Map<String, dynamic>? resourceId;

  /// The author of the social network post.
  final String? author;

  /// The URL of the social network post.
  final String? referenceUrl;

  /// An image of the post's author.
  final String? imageUrl;

  ActivityContentSocial({
    this.type,
    this.resourceId,
    this.author,
    this.referenceUrl,
    this.imageUrl,
  });

  factory ActivityContentSocial.fromJson(Map<String, dynamic> json) =>
      _$ActivityContentSocialFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityContentSocialToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
