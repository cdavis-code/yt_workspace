import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/live/chat.dart';

/// A liveChatMessage resource represents a chat message in a YouTube live chat. The resource can contain details about several types of messages, including a newly posted text message or fan funding event.
///
/// The live chat feature is enabled by default for live broadcasts and is available while the live event is active. (After the event ends, live chat is no longer available for that event.)
class Chat extends YouTubeApiHelper {
  final ChatClient _rest;

  Chat({required super.dio}) : _rest = ChatClient(dio);

  ///Lists live chat messages for a specific chat.
  Future<LiveChatMessageListResponse> list({
    required String liveChatId,
    String part = 'snippet,authorDetails',
    List<String> partList = const [],
    String? hl,
    int? maxResults,
    String? pageToken,
    int? profileImageSize,
  }) async => await _rest.list(
    // _authHeader,
    accept,
    buildParts(partList, part),
    liveChatId,
    hl: hl,
    maxResults: maxResults,
    pageToken: pageToken,
    profileImageSize: profileImageSize,
  );

  ///Adds a message to a live chat.
  Future<LiveChatMessage> insert({
    required Map<String, dynamic> body,
    String part = 'snippet,status,contentDetails',
    List<String> partList = const [],
  }) async {
    String part = 'snippet';

    if (body['snippet']['textMessageDetails']['messageText'] == '') {
      throw ArgumentError.value(
        body,
        'body',
        'snippet.textMessageDetails.messageText cannot be empty.',
      );
    }

    return await _rest.insert(
      // _authHeader,
      accept,
      contentType,
      buildParts(partList, part),
      body,
    );
  }

  ///Deletes a chat message. The API request must be authorized by the channel owner or a moderator of the live chat.
  Future<void> delete({required String id}) async {
    return _rest.delete(
      // _authHeader,
      accept,
      id,
    );
  }
}
