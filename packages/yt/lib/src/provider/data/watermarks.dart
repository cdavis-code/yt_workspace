import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'watermarks.g.dart';

/// A [Watermark] resource identifies an image that displays during playbacks of
/// a specified channel's videos. You can also specify a target channel to which
/// the image will link as well as timing details that determine when the
/// watermark appears during video playbacks and the length of time it is
/// visible.
@RestApi(baseUrl: 'https://www.googleapis.com/upload/youtube/v3/watermarks')
abstract class WatermarksClient {
  factory WatermarksClient(Dio dio, {String baseUrl}) = _WatermarksClient;

  ///Supply the [channelId] and retrieve the url used to upload the thumbnail image
  @POST('/set')
  Future<HttpResponse<dynamic>> location(
    @Header('Authorization') String authorization,
    @Header('Accept') String accept,
    @Query('videoId') String channelId,
    @Query('uploadType') String uploadType,
  );

  /// Uploads a watermark image to YouTube and sets it for a channel.
  ///
  /// This method supports media upload. Uploaded files must conform to these constraints:
  ///
  /// - Maximum file size: 10MB
  /// - Accepted Media MIME types: image/jpeg, image/png, application/octet-stream

  // @POST('/set')
  // Future<HttpResponse<dynamic>> set(
  //     @Header('Authorization') String authorization,
  //     @Header('Accept') String accept,
  //     @Query('channelId') String channelId,
  //     @Body() File image,
  //     {@Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner});

  ///Uploads a custom video thumbnail to YouTube and sets it for a video.
  @POST('/set')
  Future<HttpResponse<dynamic>> set(
    @Header('Content-Type') String contentType,
    @Query('channelId') String channelId,
    @Body() WatermarksResource watermarksResource,
  );

  ///Uploads a custom video thumbnail to YouTube and sets it for a video.
  @POST('/unset')
  Future<HttpResponse<dynamic>> unset(@Query('channelId') String channelId);
}
