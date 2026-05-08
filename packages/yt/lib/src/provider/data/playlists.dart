import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'playlists.g.dart';

///A playlist resource represents a YouTube playlist. A playlist is a collection of videos that can be viewed sequentially and shared with other users. By default, playlists are publicly visible to other users, but playlists can be public or private.
///
///YouTube also uses playlists to identify special collections of videos for a channel, such as:
///
///- uploaded videos
///- positively rated (liked) videos
///To be more specific, these lists are associated with a channel, which is a collection of a person, group, or company's videos, playlists, and other YouTube information. You can retrieve the playlist IDs for each of these lists from the channel resource for a given channel.
///
///You can then use the [authList()] ot [apiKeyList()] method to retrieve any of those lists. You can also add or remove items from those lists by calling the [insert()] and [delete()] methods.
@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class PlaylistClient {
  factory PlaylistClient(Dio dio, {String baseUrl}) = _PlaylistClient;

  ///Returns a collection of playlists that match the API request parameters. For example, you can retrieve all playlists that the authenticated user owns, or you can retrieve one or more playlists by their unique IDs.
  @GET('/playlists')
  Future<PlaylistResponse> list(
    @Query('key') String? apiKey,
    @Header('Accept') String accept,
    @Query('part') String parts, {
    @Query('channelId') String? channelId,
    @Query('id') String? id,
    @Query('mine') bool? mine,
    @Query('hl') int? hl,
    @Query('maxResults') int? maxResults,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('onBehalfOfContentOwnerChannel')
    String? onBehalfOfContentOwnerChannel,
    @Query('pageToken') String? pageToken,
  });

  ///Creates a playlist.
  @POST('/playlists')
  Future<Playlist> insert(
    @Header('Accept') String accept,
    @Header('Content-Type') String contentType,
    @Query('part') String part,
    @Body() Map<String, dynamic> body, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('onBehalfOfContentOwnerChannel')
    String? onBehalfOfContentOwnerChannel,
  });

  ///Modifies a playlist. For example, you could change a playlist's title, description, or privacy status.
  @PUT('/playlists')
  Future<Playlist> update(
    @Header('Accept') String accept,
    @Header('Content-Type') String contentType,
    @Query('part') String parts,
    @Body() Map<String, dynamic> body, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });

  ///Deletes a playlist
  @DELETE('/playlists')
  Future<void> delete(
    @Header('Accept') String accept,
    @Query('id') String id, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });
}
