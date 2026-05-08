import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/playlist_items.dart';

class PlaylistItems extends YouTubeApiHelper {
  final PlaylistItemsClient _rest;

  PlaylistItems({required super.dio, super.token, super.apiKey})
    : _rest = PlaylistItemsClient(dio);

  ///Returns a collection of playlists that match the API request parameters. For example, you can retrieve all playlists that the authenticated user owns, or you can retrieve one or more playlists by their unique IDs.
  Future<PlaylistItemListResponse> list({
    String part = 'contentDetails,id,localizations,player,snippet,status',
    List<String> partList = const [],
    String? playlistId,
    String? id,
    int? maxResults,
    String? onBehalfOfContentOwner,
    String? videoId,
    String? pageToken,
  }) async {
    return _rest.list(
      apiKey,
      accept,
      buildParts(partList, part),
      playlistId: playlistId,
      id: id,
      maxResults: maxResults,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      pageToken: pageToken,
      videoId: videoId,
    );
  }

  ///Creates a playlist.
  Future<Playlist> insert({
    String part = 'contentDetails,id,localizations,player,snippet,status',
    List<String> partList = const [],
    required Map<String, dynamic> body,
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
  }) async =>
      await _rest.insert(accept, contentType, buildParts(partList, part), body);

  ///Modifies a playlist. For example, you could change a playlist's title, description, or privacy status.
  Future<Playlist> update({
    String part = 'contentDetails,id,localizations,player,snippet,status',
    List<String> partList = const [],
    required Map<String, dynamic> body,
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
  }) async {
    return await _rest.update(
      accept,
      contentType,
      buildParts(partList, part),
      body,
    );
  }

  ///Deletes a playlist.
  Future<void> delete({
    required String id,
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
  }) async {
    return await _rest.delete(accept, id);
  }
}
