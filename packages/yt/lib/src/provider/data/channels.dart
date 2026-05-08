import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'channels.g.dart';

///A channel resource contains information about a YouTube channel.
@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class ChannelClient {
  factory ChannelClient(Dio dio, {String baseUrl}) = _ChannelClient;

  ///Returns a collection of zero or more channel resources that match the request criteria.
  @GET('/channels')
  Future<ChannelResponse> list(
    @Query('key') String? apiKey,
    @Header('Accept') String accept,
    @Query('part') String parts, {
    @Query('categoryId') String? categoryId,
    @Query('forUsername') String? forUsername,
    @Query('id') String? id,
    @Query('managedByMe') bool? managedByMe,
    @Query('mine') bool? mine,
    @Query('hl') String? hl,
    @Query('maxResults') int? maxResults,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('pageToken') String? pageToken,
  });

  @PUT('/channels')
  Future<ChannelItem> update(
    @Header('Accept') String accept,
    @Header('Content-Type') String contentType,
    @Query('part') String parts,
    @Body() Map<String, dynamic> body, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });
}
