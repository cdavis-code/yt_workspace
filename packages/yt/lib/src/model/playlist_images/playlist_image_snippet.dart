import 'package:json_annotation/json_annotation.dart';

part 'playlist_image_snippet.g.dart';

/// The snippet object contains basic details about the playlist image,
/// including its associated playlist, the image type and the dimensions
/// of the image.
@JsonSerializable()
class PlaylistImageSnippet {
  /// The ID that YouTube uses to uniquely identify the playlist that
  /// the image is associated with.
  final String? playlistId;

  /// The image type. The default value is `default`.
  final String? type;

  /// The image's width.
  final int? width;

  /// The image's height.
  final int? height;

  PlaylistImageSnippet({this.playlistId, this.type, this.width, this.height});

  factory PlaylistImageSnippet.fromJson(Map<String, dynamic> json) =>
      _$PlaylistImageSnippetFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistImageSnippetToJson(this);
}
