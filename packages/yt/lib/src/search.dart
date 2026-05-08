import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/search.dart';

///A search result contains information about a YouTube video, channel, or playlist that matches the search parameters specified in an API request. While a search result points to a uniquely identifiable resource, like a video, it does not have its own persistent data.
class Search extends YouTubeApiHelper {
  final SearchClient _rest;

  Search({required super.dio, super.token, super.apiKey})
    : _rest = SearchClient(dio);

  ///Returns a collection of search results that match the query parameters specified in the API request. By default, a search result set identifies matching video, channel, and [Playlist] resources, but you can also configure queries to only retrieve a specific type of resource.
  Future<SearchListResponse> list({
    String part = 'snippet',
    List<String> partList = const [],
    String? channelId,
    String? channelType,
    String? eventType,
    bool? forContentOwner,
    bool? forDeveloper,
    bool? forMine,
    String? location,
    String? locationRadius,
    int? maxResults,
    String? onBehalfOfContentOwner,
    String? order,
    String? pageToken,
    String? publishedAfter,
    String? publishedBefore,
    String? q,
    String? regionCode,
    String? relevanceLanguage,
    String? safeSearch,
    String? topicId,
    String? type,
    String? videoCaption,
    String? videoCategoryId,
    String? videoDefinition,
    String? videoDimension,
    String? videoDuration,
    String? videoEmbeddable,
    String? videoLicense,
    String? videoSyndicated,
    String? videoType,
  }) async => _rest.list(
    apiKey,
    accept,
    buildParts(partList, part),
    channelId: channelId,
    channelType: channelType,
    eventType: eventType,
    forContentOwner: forContentOwner,
    forDeveloper: forDeveloper,
    forMine: forMine,
    location: location,
    locationRadius: locationRadius,
    maxResults: maxResults,
    onBehalfOfContentOwner: onBehalfOfContentOwner,
    order: order,
    pageToken: pageToken,
    publishedAfter: publishedAfter,
    publishedBefore: publishedBefore,
    q: q,
    regionCode: regionCode,
    relevanceLanguage: relevanceLanguage,
    safeSearch: safeSearch,
    topicId: topicId,
    type: type,
    videoCaption: videoCaption,
    videoCategoryId: videoCategoryId,
    videoDefinition: videoDefinition,
    videoDimension: videoDimension,
    videoDuration: videoDuration,
    videoEmbeddable: videoEmbeddable,
    videoLicense: videoLicense,
    videoSyndicated: videoSyndicated,
    videoType: videoType,
  );
}
