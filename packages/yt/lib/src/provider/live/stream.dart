import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'stream.g.dart';

///A liveStream resource contains information about the video stream that you are transmitting to YouTube. The stream provides the content that will be broadcast to YouTube users. Once created, a [LiveStreamItem] resource can be bound to one or more [LiveBroadcastItem] resources.
@RestApi(baseUrl: 'https://youtube.googleapis.com/youtube/v3')
abstract class StreamClient {
  factory StreamClient(Dio dio, {String baseUrl}) = _StreamClient;

  ///Returns a list of video streams that match the API request parameters.
  @GET('/liveStreams')
  Future<LiveStreamListResponse> list(
    // @Header('Authorization')
    //     String authorization,
    @Header('Accept') String accept,
    @Query('part') String parts, {
    @Query('id') String? id,
    @Query('mine') bool? mine,
    @Query('maxResults') int? maxResults,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('onBehalfOfContentOwnerChannel')
    String? onBehalfOfContentOwnerChannel,
    @Query('pageToken') String? pageToken,
  });

  ///Creates a video stream. The stream enables you to send your video to YouTube, which can then broadcast the video to your audience.
  @POST('/liveStreams')
  Future<LiveStreamItem> insert(
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

  ///Updates a video stream. If the properties that you want to change cannot be updated, then you need to create a new stream with the proper settings.
  @PUT('/liveStreams')
  Future<LiveStreamItem> update(
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

  ///Deletes a video stream.
  @DELETE('/liveStreams')
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
