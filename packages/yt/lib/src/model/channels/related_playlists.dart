import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'related_playlists.g.dart';

///The RelatedPlaylists object encapsulates information about the channel's content.
@JsonSerializable()
class RelatedPlaylists {
  ///The relatedPlaylists object is a map that identifies playlists associated with the channel, such as the channel's uploaded videos or liked videos. You can retrieve any of these playlists using the playlists.list method.
  final String likes;

  ///The ID of the playlist that contains the channel's uploaded videos. Use the videos.insert method to upload new videos and the videos.delete method to delete previously uploaded videos.
  final String uploads;

  RelatedPlaylists({required this.likes, required this.uploads});

  factory RelatedPlaylists.fromJson(Map<String, dynamic> json) =>
      _$RelatedPlaylistsFromJson(json);

  Map<String, dynamic> toJson() => _$RelatedPlaylistsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
