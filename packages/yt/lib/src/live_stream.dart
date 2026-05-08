import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/live/stream.dart';

///A liveStream resource contains information about the video stream that you are transmitting to YouTube. The stream provides the content that will be broadcast to YouTube users. Once created, a [LiveStreamItem] resource can be bound to one or more [LiveBroadcastItem] resources.
class LiveStream extends YouTubeApiHelper {
  final StreamClient _rest;

  LiveStream({required super.dio}) : _rest = StreamClient(dio);

  ///Returns a list of video streams that match the API request parameters.
  Future<LiveStreamListResponse> list({
    String part = 'snippet,status,contentDetails',
    List<String> partList = const [],
    String? id,
    bool? mine,
    int? maxResults,
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
    String? pageToken,
  }) {
    return _rest.list(
      // _authHeader,
      accept,
      buildParts(partList, part),
      id: id,
      mine: mine,
      maxResults: maxResults,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
      pageToken: pageToken,
    );
  }

  ///Creates a video stream. The stream enables you to send your video to YouTube, which can then broadcast the video to your audience.
  Future<LiveStreamItem> insert({
    String part = 'snippet,status,contentDetails',
    List<String> partList = const [],
    required Map<String, dynamic> body,
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
  }) => _rest.insert(
    // _authHeader,
    accept,
    contentType,
    buildParts(partList, part),
    body,
  );

  ///Updates a video stream. If the properties that you want to change cannot be updated, then you need to create a new stream with the proper settings.
  Future<LiveStreamItem> update({
    String part = 'snippet,status,contentDetails',
    List<String> partList = const [],
    required Map<String, dynamic> body,
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
  }) {
    return _rest.update(
      // _authHeader,
      accept,
      contentType,
      buildParts(partList, part),
      body,
    );
  }

  ///Deletes a video stream.
  Future<void> delete({
    required String id,
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
  }) {
    return _rest.delete(
      // _authHeader,
      accept,
      id,
    );
  }
}
