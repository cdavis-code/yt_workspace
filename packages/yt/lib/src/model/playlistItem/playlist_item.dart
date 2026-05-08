import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../response_metadata.dart';
import 'content_details.dart';
import 'snippet.dart';
import 'status.dart';

part 'playlist_item.g.dart';

/// A playlistItem resource identifies another resource, such as a video, that is included in a playlist. In addition, the playlistItem resource contains details about the included resource that pertain specifically to how that resource is used in that playlist.
///
/// YouTube also uses a playlist to identify a channel's list of uploaded videos, with each playlistItem in that list representing one uploaded video.
@JsonSerializable()
class PlaylistItem extends ResponseMetadata {
  /// The ID that YouTube uses to uniquely identify the playlist.
  final String id;

  /// The [Snippet] object contains basic details about the playlist item, such as its title and position in the playlist.
  final Snippet? snippet;

  /// The [Status] object contains information about the playlist item's privacy status.
  final Status? status;

  /// The [ContentDetails] object is included in the resource if the included item is a YouTube video. The object contains additional information about the video.
  final ContentDetails? contentDetails;

  PlaylistItem({
    required super.kind,
    required super.etag,
    required this.id,
    this.snippet,
    this.status,
    this.contentDetails,
  });

  factory PlaylistItem.fromJson(Map<String, dynamic> json) =>
      _$PlaylistItemFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistItemToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
