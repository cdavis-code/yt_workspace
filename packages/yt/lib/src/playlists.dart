import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/playlists.dart';

///A playlist resource represents a YouTube playlist. A playlist is a collection of videos that can be viewed sequentially and shared with other users. By default, playlists are publicly visible to other users, but playlists can be public or private.
///
///YouTube also uses playlists to identify special collections of videos for a channel, such as:
///
///- uploaded videos
///- positively rated (liked) videos
///To be more specific, these lists are associated with a channel, which is a collection of a person, group, or company's videos, playlists, and other YouTube information. You can retrieve the playlist IDs for each of these lists from the channel resource for a given channel.
///
///You can then use the [list()] method to retrieve any of those lists. You can also add or remove items from those lists by calling the [insert()] and [delete()] methods.
class Playlists extends YouTubeApiHelper {
  final PlaylistClient _rest;

  Playlists({required super.dio, super.apiKey}) : _rest = PlaylistClient(dio);

  ///Returns a collection of playlists that match the API request parameters.
  ///For example, you can retrieve all playlists that the authenticated user
  ///owns, or you can retrieve one or more playlists by their unique IDs.
  Future<PlaylistResponse> list({
    String part = 'contentDetails,id,localizations,player,snippet,status',
    List<String> partList = const [],
    String? channelId,
    String? id,
    bool? mine,
    int? maxResults,
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
    String? pageToken,
  }) async {
    return _rest.list(
      apiKey,
      accept,
      buildParts(partList, part),
      channelId: channelId,
      id: id,
      mine: mine,
      maxResults: maxResults,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
      pageToken: pageToken,
    );
  }

  ///Creates a playlist.
  Future<Playlist> insert({
    String part = 'contentDetails,id,localizations,player,snippet,status',
    List<String> partList = const [],
    required Map<String, dynamic> body,
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
  }) async {
    return await _rest.insert(
      accept,
      contentType,
      buildParts(partList, part),
      body,
    );
  }

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
