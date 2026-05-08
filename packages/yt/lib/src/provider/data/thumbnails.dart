import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:universal_io/io.dart' show File;
import 'package:yt/yt.dart';

part 'thumbnails.g.dart';

///A [Thumbnail] resource identifies different thumbnail image sizes associated with a resource. Please note the following characteristics of thumbnail images:
///
///- A resource's Snippet.thumbnails property is an object that identifies the thumbnail images available for that resource.
///- A thumbnail resource contains a series of objects. The name of each object (default, medium, high, etc.) refers to the thumbnail image size.
/// - Different types of resources may support different thumbnail image sizes.
///- Different types of resources may define different sizes for thumbnail images with the same name. For example, the default thumbnail image for a video resource is typically 120px by 90px, and the default thumbnail image for a channel resource is typically 88px by 88px.
///- Resources of the same type may still have different thumbnail image sizes for certain images depending on the resolution of the original image or content uploaded to YouTube. For example, an HD video may support higher resolution thumbnails than non-HD videos.
///- Each object that contains information about a thumbnail image size has a width property and a height property. However, the width and height properties may not be returned for that image.
///- If an uploaded thumbnail image does not match the required dimensions, the image is resized to match the correct size without changing its aspect ratio. The image is not cropped, but may include black bars so that the size is correct.
@RestApi(baseUrl: 'https://www.googleapis.com/upload/youtube/v3/thumbnails')
abstract class ThumbnailsClient {
  factory ThumbnailsClient(Dio dio, {String baseUrl}) = _ThumbnailsClient;

  ///Supply the [videoId] and retrieve the url used to upload the thumbnail image
  @POST('/set')
  Future<HttpResponse<dynamic>> location(
    @Header('Accept') String accept,
    @Query('videoId') String videoId,
    @Query('uploadType') String uploadType,
  );

  ///Uploads a custom video thumbnail to YouTube and sets it for a video.
  @POST('/set')
  Future<ThumbnailsSetResponse> upload(
    @Header('Content-Type') String contentType,
    @Query('videoId') String videoId,
    @Query('upload_id') String uploadId,
    @Body() File image,
    @Query('uploadType') String uploadType,
  );
}
