import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'comment_threads.g.dart';

/// A commentThread resource contains information about a YouTube comment thread, which comprises a top-level comment and replies, if any exist, to that comment. A commentThread resource can represent comments about either a video or a channel.
@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class CommentThreadsClient {
  factory CommentThreadsClient(Dio dio, {String baseUrl}) =
      _CommentThreadsClient;

  /// Returns a list of comment threads that match the API request parameters.
  @GET('/commentThreads')
  Future<CommentThreadListResponse> list(
    @Query('key') String? apiKey,
    @Header('Accept') String accept,
    @Query('part') String parts, {
    @Query('allThreadsRelatedToChannelId') String? allThreadsRelatedToChannelId,
    @Query('channelId') String? channelId,
    @Query('id') String? id,
    @Query('videoId') String? videoId,
    @Query('maxResults') int? maxResults,
    @Query('moderationStatus') String? moderationStatus,
    @Query('order') String? order,
    @Query('pageToken') String? pageToken,
    @Query('searchTerms') String? searchTerms,
    @Query('textFormat') String? textFormat,
  });

  @POST('/commentThreads')
  Future<CommentThread> insert(
    @Header('Accept') String accept,
    @Header('Content-Type') String contentType,
    @Query('part') String parts,
    @Body() Map<String, dynamic> body,
  );
}
