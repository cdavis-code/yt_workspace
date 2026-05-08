import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'broadcast.g.dart';

///A liveBroadcast resource represents an event that will be streamed, via live video, on YouTube.
@RestApi(baseUrl: 'https://youtube.googleapis.com/youtube/v3')
abstract class BroadcastClient {
  factory BroadcastClient(Dio dio, {String baseUrl}) = _BroadcastClient;

  ///Returns a list of YouTube broadcasts that match the API request parameters.
  @GET('/liveBroadcasts')
  Future<LiveBroadcastResponse> list(
    @Header('Accept') String accept,
    @Query('part') String parts, {
    @Query('broadcastStatus') String? broadcastStatus,
    @Query('broadcastType') String? broadcastType,
    @Query('id') String? id,
    @Query('maxResults') int? maxResults,
    @Query('mine') bool? mine,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('onBehalfOfContentOwnerChannel')
    String? onBehalfOfContentOwnerChannel,
    @Query('pageToken') String? pageToken,
  });

  ///Creates a broadcast.
  @POST('/liveBroadcasts')
  Future<LiveBroadcastItem> insert(
    // @Header('Authorization')
    //     String authorization,
    @Header('Accept') String accept,
    @Header('Content-Type') String contentType,
    @Query('part') String part,
    @Body() Map<String, dynamic> body, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('onBehalfOfContentOwnerChannel')
    String? onBehalfOfContentOwnerChannel,
  });

  ///Updates a broadcast. For example, you could modify the broadcast settings defined in the [LiveBroadcastItem] resource's [LiveBroadcastItem.contentDetails] object.
  @PUT('/liveBroadcasts')
  Future<LiveBroadcastItem> update(
    // @Header('Authorization')
    //     String authorization,
    @Header('Accept') String accept,
    @Header('Content-Type') String contentType,
    @Query('part') String parts,
    @Body() Map<String, dynamic> body, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('onBehalfOfContentOwnerChannel')
    String? onBehalfOfContentOwnerChannel,
  });

  ///Binds a YouTube broadcast to a stream or removes an existing binding between a broadcast and a stream. A broadcast can only be bound to one video stream, though a video stream may be bound to more than one broadcast.
  @POST('/liveBroadcasts/bind')
  Future<LiveBroadcastItem> bind(
    // @Header('Authorization')
    //     String authorization,
    @Header('Accept') String accept,
    @Query('id') String id,
    @Query('streamId') String? streamId,
    @Query('part') String parts, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('onBehalfOfContentOwnerChannel')
    String? onBehalfOfContentOwnerChannel,
  });

  ///Changes the status of a YouTube live broadcast and initiates any processes associated with the new status. For example, when you transition a broadcast's status to testing, YouTube starts to transmit video to that broadcast's monitor stream. Before calling this method, you should confirm that the value of the [LiveBroadcastItem.status] property for the stream bound to your broadcast is active.
  @POST('/liveBroadcasts/transition')
  Future<LiveBroadcastItem> transition(
    // @Header('Authorization')
    //     String authorization,
    @Header('Accept') String accept,
    @Query('id') String id,
    @Query('part') String parts, {
    @Query('broadcastStatus') String? broadcastStatus,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('onBehalfOfContentOwnerChannel')
    String? onBehalfOfContentOwnerChannel,
  });

  ///Deletes a broadcast.
  @DELETE('/liveBroadcasts')
  Future<void> delete(
    // @Header('Authorization')
    //     String authorization,
    @Header('Accept') String accept,
    @Query('id') String id, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('onBehalfOfContentOwnerChannel')
    String? onBehalfOfContentOwnerChannel,
  });
}
