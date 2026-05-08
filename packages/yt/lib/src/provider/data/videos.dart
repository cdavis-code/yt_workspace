import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:universal_io/io.dart';
import 'package:yt/yt.dart';

part 'videos.g.dart';

/// A video resource represents a YouTube video.
@RestApi(baseUrl: 'https://www.googleapis.com')
abstract class VideoClient {
  factory VideoClient(Dio dio, {String baseUrl}) = _VideoClient;

  /// Returns a list of [VideoItem]s that match the API request parameters.
  @GET('/youtube/v3/videos')
  Future<VideoListResponse> list(
    @Header('Accept') String accept,
    @Query('part') String parts, {
    @Query('chart') String? chart,
    @Query('id') String? id,
    @Query('myRating') String? myRating,
    @Query('hl') bool? hl,
    @Query('maxHeight') int? maxHeight,
    @Query('maxResults') int? maxResults,
    @Query('maxWidth') int? maxWidth,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('pageToken') String? pageToken,
    @Query('regionCode') String? regionCode,
    @Query('videoCategoryId') String? videoCategoryId,
  });

  /// Uploads a video to YouTube.
  @POST('/upload/youtube/v3/videos')
  Future<VideoItem> upload(
    @Header('Accept') String accept,
    @Query('upload_id') String uploadId,
    @Query('part') String parts,
    @Body() File videoFile,
    @Query('uploadType') String uploadType, {
    @Query('notifySubscribers') bool? notifySubscribers,
  });

  /// Retrieve the url used to upload the thumbnail image
  @POST('/upload/youtube/v3/videos')
  Future<HttpResponse<dynamic>> location(
    @Header('Content-Type') String contentType,
    @Header('X-Upload-Content-Length') int xUploadContentLength,
    @Header('X-Upload-Content-Type') String xUploadContentType,
    @Body() Map<String, dynamic> body,
    @Query('part') String parts,
    @Query('uploadType') String uploadType, {
    @Query('notifySubscribers') bool? notifySubscribers,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('onBehalfOfContentOwnerChannel')
    String? onBehalfOfContentOwnerChannel,
  });

  /// Updates a [VideoItem]'s metadata.
  @PUT('/youtube/v3/videos')
  Future<VideoItem> update(
    @Header('Accept') String accept,
    @Query('part') String parts,
    @Body() Map<String, dynamic> body, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('onBehalfOfContentOwnerChannel')
    String? onBehalfOfContentOwnerChannel,
  });

  /// Add a like or dislike rating to a [VideoItem] or remove a rating from a [VideoItem].
  @POST('/youtube/v3/videos/rate')
  Future<void> rate(
    @Header('Accept') String accept,
    @Query('id') String id,
    @Query('rating') String rating,
  );

  /// Retrieves the ratings that the authorized user gave to a list of specified videos.
  @GET('/youtube/v3/videos/getRating')
  Future<VideoGetRatingResponse> getRating(
    @Header('Accept') String accept,
    @Query('id') String id, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });

  /// Report a video for containing abusive content.
  @POST('/youtube/v3/videos/reportAbuse')
  Future<void> reportAbuse(
    @Header('Accept') String accept,
    @Body() ReportAbuse body, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });

  /// Deletes a YouTube video.
  @DELETE('/youtube/v3/videos')
  Future<void> delete(
    @Header('Accept') String accept,
    @Query('id') String id, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });
}
