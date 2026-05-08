import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'resource_id.dart';
import '../thumbnails.dart';

part 'snippet.g.dart';

///The snippet object contains basic details about the playlist item, such as its title and position in the playlist.
@JsonSerializable(explicitToJson: true)
class Snippet {
  ///The date and time that the item was added to the playlist. The value is specified in ISO 8601 format.
  final DateTime publishedAt;

  ///The ID that YouTube uses to uniquely identify the user that added the item to the playlist.
  final String channelId;

  ///The item's title.
  final String title;

  ///The item's description.
  final String description;

  ///A map of thumbnail images associated with the playlist item. For each object in the map, the key is the name of the thumbnail image, and the value is an object that contains other information about the thumbnail.
  final Thumbnails thumbnails;

  ///The channel title of the channel that the playlist item belongs to.
  final String channelTitle;

  ///The channel title of the channel that uploaded this video.
  final String videoOwnerChannelTitle;

  ///The channel ID of the channel that uploaded this video.
  final String videoOwnerChannelId;

  ///The ID that YouTube uses to uniquely identify the playlist that the playlist item is in.
  final String playlistId;

  ///The order in which the item appears in the playlist. The value uses a zero-based index, so the first item has a position of 0, the second item has a position of 1, and so forth.
  final int position;

  ///The id object contains information that can be used to uniquely identify the resource that is included in the playlist as the playlist item.
  final ResourceId resourceId;

  Snippet({
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.description,
    required this.thumbnails,
    required this.channelTitle,
    required this.videoOwnerChannelTitle,
    required this.videoOwnerChannelId,
    required this.playlistId,
    required this.position,
    required this.resourceId,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);

  Map<String, dynamic> toJson() => _$SnippetToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
