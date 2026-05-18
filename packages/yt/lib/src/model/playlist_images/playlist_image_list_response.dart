import 'package:json_annotation/json_annotation.dart';

import 'playlist_image.dart';

part 'playlist_image_list_response.g.dart';

@JsonSerializable()
class PlaylistImageListResponse {
  final String kind;
  final String? etag;
  final String? nextPageToken;
  final String? prevPageToken;
  final List<PlaylistImage>? items;

  PlaylistImageListResponse({
    this.kind = 'youtube#playlistImageListResponse',
    this.etag,
    this.nextPageToken,
    this.prevPageToken,
    this.items,
  });

  factory PlaylistImageListResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaylistImageListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistImageListResponseToJson(this);
}
