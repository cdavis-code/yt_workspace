import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/subscriptions.dart';

/// A subscription resource contains information about a YouTube user
/// subscription. A subscription notifies a user when new videos are added to a
/// channel or when another user takes one of several actions on YouTube, such
/// as uploading a video, rating a video, or commenting on a video.
class Subscriptions extends YouTubeApiHelper {
  final SubscriptionsClient _rest;

  Subscriptions({required super.dio}) : _rest = SubscriptionsClient(dio);

  /// Returns subscription resources that match the API request criteria.
  Future<SubscriptionListResponse> list({
    String part = 'contentDetails,id,snippet,subscriberSnippet',
    List<String> partList = const [],
    String? channelId,
    String? id,
    bool? mine,
    bool? myRecentSubscribers,
    bool? mySubscribers,
    String? forChannelId,
    int? maxResults,
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
    String? order,
    String? pageToken,
  }) async => _rest.list(
    // _authHeader,
    accept,
    buildParts(partList, part),
    channelId: channelId,
    id: id,
    mine: mine,
    myRecentSubscribers: myRecentSubscribers,
    mySubscribers: mySubscribers,
    forChannelId: forChannelId,
    maxResults: maxResults,
    onBehalfOfContentOwner: onBehalfOfContentOwner,
    onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    pageToken: pageToken,
  );

  /// Adds a subscription for the authenticated user's channel.
  Future<Subscription> insert({
    String part = 'contentDetails,id,snippet,subscriberSnippet',
    List<String> partList = const [],
    required Map<String, dynamic> body,
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
  }) async {
    return await _rest.insert(
      // _authHeader,
      accept,
      contentType,
      buildParts(partList, part),
      body,
    );
  }

  /// Deletes a subscription.
  Future<void> delete({
    required String id,
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
  }) async {
    return await _rest.delete(
      // _authHeader,
      accept,
      id,
    );
  }
}
