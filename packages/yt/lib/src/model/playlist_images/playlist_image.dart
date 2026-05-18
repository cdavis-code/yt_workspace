import 'package:json_annotation/json_annotation.dart';

import 'playlist_image_snippet.dart';

part 'playlist_image.g.dart';

/// A playlistImage resource contains information about a custom playlist
/// image. The API supports the ability to create, read, update, and delete
/// these images.
@JsonSerializable()
class PlaylistImage {
  final String kind;
  final String? id;
  final PlaylistImageSnippet? snippet;

  PlaylistImage({this.kind = 'youtube#playlistImage', this.id, this.snippet});

  factory PlaylistImage.fromJson(Map<String, dynamic> json) =>
      _$PlaylistImageFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistImageToJson(this);
}
