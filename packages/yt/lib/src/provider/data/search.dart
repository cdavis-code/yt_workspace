import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'search.g.dart';

///A search result contains information about a YouTube video, channel, or playlist that matches the search parameters specified in an API request. While a search result points to a uniquely identifiable resource, like a video, it does not have its own persistent data.
@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class SearchClient {
  factory SearchClient(Dio dio, {String baseUrl}) = _SearchClient;

  ///Returns a collection of search results that match the query parameters specified in the API request. By default, a search result set identifies matching video, channel, and [Playlist] resources, but you can also configure queries to only retrieve a specific type of resource.
  @GET('/search')
  Future<SearchListResponse> list(
    @Query('key') String? apiKey,
    @Header('Accept') String accept,
    @Query('part') String? parts, {
    @Query('channelId') String? channelId,
    @Query('channelType') String? channelType,
    @Query('eventType') String? eventType,
    @Query('forContentOwner') bool? forContentOwner,
    @Query('forDeveloper') bool? forDeveloper,
    @Query('forMine') bool? forMine,
    @Query('location') String? location,
    @Query('locationRadius') String? locationRadius,
    @Query('maxResults') int? maxResults,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('order') String? order,
    @Query('pageToken') String? pageToken,
    @Query('publishedAfter') String? publishedAfter,
    @Query('publishedBefore') String? publishedBefore,
    @Query('q') String? q,
    @Query('regionCode') String? regionCode,
    @Query('relevanceLanguage') String? relevanceLanguage,
    @Query('safeSearch') String? safeSearch,
    @Query('topicId') String? topicId,
    @Query('type') String? type,
    @Query('videoCaption') String? videoCaption,
    @Query('videoCategoryId') String? videoCategoryId,
    @Query('videoDefinition') String? videoDefinition,
    @Query('videoDimension') String? videoDimension,
    @Query('videoDuration') String? videoDuration,
    @Query('videoEmbeddable') String? videoEmbeddable,
    @Query('videoLicense') String? videoLicense,
    @Query('videoSyndicated') String? videoSyndicated,
    @Query('videoType') String? videoType,
  });
}
