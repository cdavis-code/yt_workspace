import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../page_info.dart';
import '../list_response.dart';
import 'playlist.dart';

part 'playlist_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PlaylistResponse extends ListResponse {
  /// A list of playlists that match the request criteria.
  @JsonKey(name: 'items')
  final List<Playlist>? playlistItems;

  PlaylistResponse({
    required super.kind,
    required super.etag,
    super.nextPageToken,
    super.prevPageToken,
    required super.pageInfo,
    this.playlistItems,
  });

  List<Playlist> get items => playlistItems ?? [];

  factory PlaylistResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaylistResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
