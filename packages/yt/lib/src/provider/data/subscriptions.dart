import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'subscriptions.g.dart';

/// A subscription resource contains information about a YouTube user
/// subscription. A subscription notifies a user when new videos are added to a
/// channel or when another user takes one of several actions on YouTube, such as
/// uploading a video, rating a video, or commenting on a video.
@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class SubscriptionsClient {
  factory SubscriptionsClient(Dio dio, {String baseUrl}) = _SubscriptionsClient;

  /// Returns subscription resources that match the API request criteria.
  @GET('/subscriptions')
  Future<SubscriptionListResponse> list(
    @Header('Accept') String accept,
    @Query('part') String parts, {
    @Query('channelId') String? channelId,
    @Query('id') String? id,
    @Query('mine') bool? mine,
    @Query('myRecentSubscribers') bool? myRecentSubscribers,
    @Query('mySubscribers') bool? mySubscribers,
    @Query('forChannelId') String? forChannelId,
    @Query('maxResults') int? maxResults,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('onBehalfOfContentOwnerChannel')
    String? onBehalfOfContentOwnerChannel,
    @Query('order') String? order,
    @Query('pageToken') String? pageToken,
  });

  /// Adds a subscription for the authenticated user's channel.
  @POST('/subscriptions')
  Future<Subscription> insert(
    @Header('Accept') String accept,
    @Header('Content-Type') String contentType,
    @Query('part') String part,
    @Body() Map<String, dynamic> body, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('onBehalfOfContentOwnerChannel')
    String? onBehalfOfContentOwnerChannel,
  });

  /// Deletes a subscription.
  @DELETE('/subscriptions')
  Future<void> delete(
    @Header('Accept') String accept,
    @Query('id') String id, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });
}
