import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'chat.g.dart';

///A liveChatMessage resource represents a chat message in a YouTube live chat. The resource can contain details about several types of messages, including a newly posted text message or fan funding event.
///
///The live chat feature is enabled by default for live broadcasts and is available while the live event is active. (After the event ends, live chat is no longer available for that event.)
@RestApi(baseUrl: 'https://youtube.googleapis.com/youtube/v3')
abstract class ChatClient {
  factory ChatClient(Dio dio, {String baseUrl}) = _ChatClient;

  ///Lists live chat messages for a specific chat.
  @GET('/liveChat/messages')
  Future<LiveChatMessageListResponse> list(
    // @Header('Authorization') String authorization,
    @Header('Accept') String accept,
    @Query('part') String parts,
    @Query('liveChatId') String liveChatId, {
    @Query('hl') String? hl,
    @Query('maxResults') int? maxResults,
    @Query('pageToken') String? pageToken,
    @Query('profileImageSize') int? profileImageSize,
  });

  ///Adds a message to a live chat.
  @POST('/liveChat/messages')
  Future<LiveChatMessage> insert(
    // @Header('Authorization') String authorization,
    @Header('Accept') String accept,
    @Header('Content-Type') String contentType,
    @Query('part') String part,
    @Body() Map<String, dynamic> data,
  );

  ///Deletes a chat message. The API request must be authorized by the channel owner or a moderator of the live chat.
  @DELETE('/liveChat/messages')
  Future<void> delete(
    // @Header('Authorization') String authorization,
    @Header('Accept') String accept,
    @Query('id') String id,
  );
}
