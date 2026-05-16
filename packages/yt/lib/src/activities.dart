import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/activities.dart';

/// An activity resource contains information about an action that a particular channel, or user, has taken on YouTube.
class Activities extends YouTubeApiHelper {
  final ActivitiesClient _rest;

  /// Returns a list of channel activity events that match the request criteria.
  Activities({required super.dio, super.token, super.apiKey})
    : _rest = ActivitiesClient(dio);

  /// Returns a list of channel activity events that match the request criteria.
  /// For a channel, the API returns a list of that channel's recent activities.
  Future<ActivityListResponse> list({
    String part = 'snippet,contentDetails',
    List<String> partList = const [],
    String? channelId,
    bool? mine,
    int? maxResults,
    String? pageToken,
    String? publishedAfter,
    String? publishedBefore,
    String? regionCode,
  }) async => _rest.list(
    apiKey,
    accept,
    buildParts(partList, part),
    channelId: channelId,
    mine: mine,
    maxResults: maxResults,
    pageToken: pageToken,
    publishedAfter: publishedAfter,
    publishedBefore: publishedBefore,
    regionCode: regionCode,
  );
}
