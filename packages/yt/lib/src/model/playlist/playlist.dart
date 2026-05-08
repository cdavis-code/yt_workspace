import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../response_metadata.dart';
import 'content_details.dart';
import 'player.dart';
import 'snippet.dart';
import 'status.dart';

part 'playlist.g.dart';

/// A playlist resource represents a YouTube playlist. A playlist is a collection of videos that can be viewed sequentially and shared with other users. By default, playlists are publicly visible to other users, but playlists can be public or private.
///
/// YouTube also uses playlists to identify special collections of videos for a channel, such as:
///
/// - uploaded videos
/// - positively rated (liked) videos
/// To be more specific, these lists are associated with a channel, which is a collection of a person, group, or company's videos, playlists, and other YouTube information. You can retrieve the playlist IDs for each of these lists from the channel resource for a given channel.
///
/// You can then use the playlistItems.list method to retrieve any of those lists. You can also add or remove items from those lists by calling the playlistItems.insert and playlistItems.delete methods.
@JsonSerializable()
class Playlist extends ResponseMetadata {
  /// The ID that YouTube uses to uniquely identify the playlist.
  final String id;

  /// The [Snippet] object contains basic details about the playlist, such as its title and description.
  final Snippet? snippet;

  /// The [Status] object contains status information for the playlist.
  final Status? status;

  /// The [ContentDetails] object contains information about the playlist content, including the number of videos in the playlist.
  final ContentDetails? contentDetails;

  /// The [Player] object contains information that you would use to play the playlist in an embedded player.
  final Player? player;

  /// The localizations object encapsulates translations of the playlist's metadata.
  final dynamic localizations;

  Playlist({
    required super.kind,
    required super.etag,
    required this.id,
    this.snippet,
    this.status,
    this.contentDetails,
    this.player,
    this.localizations,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
