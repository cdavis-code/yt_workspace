import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/live/broadcast.dart';

///A liveBroadcast resource represents an event that will be streamed, via live video, on YouTube.
class Broadcast extends YouTubeApiHelper {
  final BroadcastClient _rest;

  Broadcast({required super.dio}) : _rest = BroadcastClient(dio);

  ///Returns a list of YouTube broadcasts that match the API request parameters.
  Future<LiveBroadcastResponse> list({
    String part = 'snippet,status,contentDetails',
    List<String> partList = const [],
    String? broadcastStatus,
    String? broadcastType,
    String? id,
    int? maxResults,
    bool? mine,
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
    String? pageToken,
  }) {
    return _rest.list(
      accept,
      buildParts(partList, part),
      broadcastStatus: broadcastStatus,
      broadcastType: broadcastType,
      id: id,
      maxResults: maxResults,
      mine: mine,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
      pageToken: pageToken,
    );
  }

  ///Creates a broadcast.
  Future<LiveBroadcastItem> insert({
    required Map<String, dynamic> body,
    String part = 'snippet,status,contentDetails',
    List<String> partList = const [],
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
  }) {
    return _rest.insert(
      // _authHeader,
      accept,
      contentType,
      buildParts(partList, part),
      body,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
  }

  ///Updates a broadcast. For example, you could modify the broadcast settings defined in the [LiveBroadcastItem] resource's [LiveBroadcastItem.contentDetails] object.
  Future<LiveBroadcastItem> update({
    required Map<String, dynamic> body,
    String part = 'snippet,status,contentDetails',
    List<String> partList = const [],
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
  }) {
    return _rest.update(
      // _authHeader,
      accept,
      contentType,
      buildParts(partList, part),
      body,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
  }

  ///Changes the status of a YouTube live broadcast and initiates any processes associated with the new status. For example, when you transition a broadcast's status to testing, YouTube starts to transmit video to that broadcast's monitor stream. Before calling this method, you should confirm that the value of the [LiveBroadcastItem.status] property for the stream bound to your broadcast is active.
  Future<LiveBroadcastItem> transition({
    required String id,
    String? broadcastStatus,
    String part = 'snippet,status,contentDetails',
    List<String> partList = const [],
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
  }) {
    return _rest.transition(
      // _authHeader,
      accept,
      id,
      buildParts(partList, part),
      broadcastStatus: broadcastStatus,
    );
  }

  ///Binds a YouTube broadcast to a stream or removes an existing binding between a broadcast and a stream. A broadcast can only be bound to one video stream, though a video stream may be bound to more than one broadcast.
  Future<LiveBroadcastItem> bind({
    required String id,
    String part = 'snippet,status,contentDetails',
    List<String> partList = const [],
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
    String? streamId,
  }) {
    return _rest.bind(
      // _authHeader,
      accept,
      id,
      streamId,
      buildParts(partList, part),
    );
  }

  ///Deletes a broadcast.
  Future<void> delete({
    required String id,
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
  }) {
    return _rest.delete(
      // _authHeader,
      accept,
      id,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
  }

  Future<LiveBroadcastItem> getActiveBroadcast() async {
    final liveBroadcastResponse = await list(broadcastStatus: 'active');

    if (liveBroadcastResponse.items.isEmpty) {
      throw Exception('No existing broadcast found.');
    }

    return liveBroadcastResponse.items.first;
  }

  Future<LiveBroadcastItem> getUpcomingAndActiveBroadcast() async {
    final List<LiveBroadcastItem> liveBroadcastList = [];

    LiveBroadcastResponse liveBroadcastResponse;

    liveBroadcastResponse = await list(
      broadcastStatus: 'upcoming',
      maxResults: 50,
    );

    liveBroadcastList.addAll(liveBroadcastResponse.items);

    liveBroadcastResponse = await list(
      broadcastStatus: 'active',
      maxResults: 50,
    );

    liveBroadcastList.addAll(liveBroadcastResponse.items);

    if (liveBroadcastList.isEmpty) {
      throw Exception('No existing broadcast found.');
    }

    liveBroadcastList.sort();

    return liveBroadcastList.length == 1
        ? liveBroadcastList.first
        : LiveBroadcastResponse.closestTo(liveBroadcastList);
  }
}
