import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/comment_threads.dart';

class CommentThreads extends YouTubeApiHelper {
  final CommentThreadsClient _rest;

  CommentThreads({required super.dio, super.token, super.apiKey})
    : _rest = CommentThreadsClient(dio);

  /// Returns a list of comment threads that match the API request parameters.
  Future<CommentThreadListResponse> list({
    String part = 'id,replies,snippet',
    List<String> partList = const [],
    String? allThreadsRelatedToChannelId,
    String? channelId,
    String? id,
    String? videoId,
    int? maxResults,
    ModerationStatus? moderationStatus,
    String? order,
    String? pageToken,
    String? searchTerms,
    String? textFormat,
  }) async => _rest.list(
    apiKey,
    accept,
    buildParts(partList, part),
    allThreadsRelatedToChannelId: allThreadsRelatedToChannelId,
    channelId: channelId,
    id: id,
    videoId: videoId,
    maxResults: Util.maxResults(maxResults),
    moderationStatus: moderationStatus?.name,
    order: order,
    pageToken: pageToken,
    searchTerms: searchTerms,
    textFormat: textFormat,
  );

  /// Returns a list of comment threads for the provided videoID.
  Future<CommentThreadListResponse> listByVideoId({
    required String videoId,
    int? maxResults,
    ModerationStatus? moderationStatus,
    String? order,
    String? pageToken,
    String? searchTerms,
    String? textFormat,
  }) => _rest.list(
    apiKey,
    accept,
    'id,replies,snippet',
    videoId: videoId,
    maxResults: Util.maxResults(maxResults),
    moderationStatus: moderationStatus?.name,
    order: order,
    pageToken: pageToken,
    searchTerms: searchTerms,
    textFormat: textFormat,
  );

  /// The [ids] parameter specifies a list of comment thread IDs for the
  /// resources that should be retrieved.
  Future<CommentThreadListResponse> listByIds({
    required List<String> ids,
    int? maxResults,
    ModerationStatus? moderationStatus,
    String? order,
    String? pageToken,
    String? searchTerms,
    String? textFormat,
  }) => _rest.list(
    apiKey,
    accept,
    'id,replies,snippet',
    id: ids.join(','),
    maxResults: Util.maxResults(maxResults),
    moderationStatus: moderationStatus?.name,
    order: order,
    pageToken: pageToken,
    searchTerms: searchTerms,
    textFormat: textFormat,
  );

  /// The [id] parameter specifies a comment thread ID for the resource that
  /// should be retrieved.
  Future<CommentThreadListResponse> listById({
    required String id,
    ModerationStatus? moderationStatus,
    String? searchTerms,
    String? textFormat,
  }) => _rest.list(
    apiKey,
    accept,
    'id,replies,snippet',
    id: id,
    moderationStatus: moderationStatus?.name,
    searchTerms: searchTerms,
    textFormat: textFormat,
  );

  /// The [channelId] parameter instructs the API to return all
  /// comment threads associated with the specified channel.
  Future<CommentThreadListResponse> listByChannelId({
    required String channelId,
    int? maxResults,
    ModerationStatus? moderationStatus,
    String? order,
    String? pageToken,
    String? searchTerms,
    String? textFormat,
  }) => _rest.list(
    apiKey,
    accept,
    'id, replies, snippet',
    allThreadsRelatedToChannelId: channelId,
    maxResults: Util.maxResults(maxResults),
    moderationStatus: moderationStatus?.name,
    order: order,
    pageToken: pageToken,
    searchTerms: searchTerms,
    textFormat: textFormat,
  );

  /// Creates a new top-level comment. To add a reply to an existing comment,
  /// use the comments.insert method instead.
  Future<CommentThread> insert({
    String part = 'snippet',
    List<String> partList = const [],
    required Map<String, dynamic> body,
  }) async =>
      await _rest.insert(accept, contentType, buildParts(partList, part), body);

  /// Helper method that creates a new top-level comment thread.
  Future<CommentThread> add({
    required String videoId,
    required String textOriginal,
  }) => insert(
    body: {
      'snippet': {
        'videoId': videoId,
        'topLevelComment': {
          'snippet': {'textOriginal': textOriginal},
        },
      },
    },
  );
}
