import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../page_info.dart';
import '../list_response.dart';
import 'playlist_item.dart';

part 'playlist_item_list_response.g.dart';

///A collection of playlist items that match the API request parameters. You can retrieve all of the playlist items in a specified playlist or retrieve one or more playlist items by their unique IDs. Try it now.
@JsonSerializable()
class PlaylistItemListResponse extends ListResponse {
  ///A list of playlist items that match the request criteria.
  @JsonKey(name: 'items')
  final List<PlaylistItem>? playlistItemItems;

  PlaylistItemListResponse({
    required super.kind,
    required super.etag,
    super.nextPageToken,
    super.prevPageToken,
    required super.pageInfo,
    this.playlistItemItems,
  });

  List<PlaylistItem> get items => playlistItemItems ?? [];

  factory PlaylistItemListResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaylistItemListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistItemListResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
