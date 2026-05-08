import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'playlist_items.g.dart';

///A playlistItem resource identifies another resource, such as a video, that is included in a playlist. In addition, the playlistItem resource contains details about the included resource that pertain specifically to how that resource is used in that playlist.
///
///YouTube also uses a playlist to identify a channel's list of uploaded videos, with each playlistItem in that list representing one uploaded video. You can retrieve the playlist ID for that list from the channel resource for a given channel.
///You can then use the [authList()] ot [apiKeyList()] method to retrieve any of those lists. You can also add or remove items from those lists by calling the [insert()] and [delete()] methods.
@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class PlaylistItemsClient {
  factory PlaylistItemsClient(Dio dio, {String baseUrl}) = _PlaylistItemsClient;

  ///Returns a collection of playlist items that match the API request parameters. You can retrieve all of the playlist items in a specified playlist or retrieve one or more playlist items by their unique IDs.
  @GET('/playlistItems')
  Future<PlaylistItemListResponse> list(
    @Query('key') String? apiKey,
    @Header('Accept') String accept,
    @Query('part') String parts, {
    @Query('id') String? id,
    @Query('playlistId') String? playlistId,
    @Query('maxResults') int? maxResults,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('pageToken') String? pageToken,
    @Query('videoId') String? videoId,
  });

  ///Creates a playlist.
  @POST('/playlistItems')
  Future<Playlist> insert(
    @Header('Accept') String accept,
    @Header('Content-Type') String contentType,
    @Query('part') String part,
    @Body() Map<String, dynamic> body, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });

  ///Modifies a playlist. For example, you could change a playlist's title, description, or privacy status.
  @PUT('/playlistItems')
  Future<Playlist> update(
    @Header('Accept') String accept,
    @Header('Content-Type') String contentType,
    @Query('part') String parts,
    @Body() Map<String, dynamic> body, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });

  ///Deletes a playlist
  @DELETE('/playlistItems')
  Future<void> delete(
    @Header('Accept') String accept,
    @Query('id') String id, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });
}
