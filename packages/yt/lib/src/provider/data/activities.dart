import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'activities.g.dart';

/// An activity resource contains information about an action that a particular channel, or user, has taken on YouTube.
@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class ActivitiesClient {
  factory ActivitiesClient(Dio dio, {String baseUrl}) = _ActivitiesClient;

  /// Returns a list of channel activity events that match the request criteria.
  @GET('/activities')
  Future<ActivityListResponse> list(
    @Query('key') String? apiKey,
    @Header('Accept') String accept,
    @Query('part') String parts, {
    @Query('channelId') String? channelId,
    @Query('mine') bool? mine,
    @Query('maxResults') int? maxResults,
    @Query('pageToken') String? pageToken,
    @Query('publishedAfter') String? publishedAfter,
    @Query('publishedBefore') String? publishedBefore,
    @Query('regionCode') String? regionCode,
  });
}
