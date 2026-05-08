import 'package:universal_io/io.dart';
import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/thumbnails.dart';

/// A [Thumbnail] resource identifies different thumbnail image sizes associated with a resource. Please note the following characteristics of thumbnail images:
///
/// - A resource's Snippet.thumbnails property is an object that identifies the thumbnail images available for that resource.
/// - A thumbnail resource contains a series of objects. The name of each object (default, medium, high, etc.) refers to the thumbnail image size.
/// - Different types of resources may support different thumbnail image sizes.
/// - Different types of resources may define different sizes for thumbnail images with the same name. For example, the default thumbnail image for a video resource is typically 120px by 90px, and the default thumbnail image for a channel resource is typically 88px by 88px.
/// - Resources of the same type may still have different thumbnail image sizes for certain images depending on the resolution of the original image or content uploaded to YouTube. For example, an HD video may support higher resolution thumbnails than non-HD videos.
/// - Each object that contains information about a thumbnail image size has a width property and a height property. However, the width and height properties may not be returned for that image.
/// - If an uploaded thumbnail image does not match the required dimensions, the image is resized to match the correct size without changing its aspect ratio. The image is not cropped, but may include black bars so that the size is correct.
class Thumbnails extends YouTubeApiHelper {
  final ThumbnailsClient _rest;

  Thumbnails({required super.dio}) : _rest = ThumbnailsClient(dio);

  ///Supply the [videoId] and retrieve the url used to upload the thumbnail image
  Future<ThumbnailsSetResponse> set({
    required String videoId,
    required File thumbnail,
  }) async {
    final String uploadType = 'resumable';

    final httpResponse = await _rest.location(accept, videoId, uploadType);

    if (!httpResponse.response.headers.map.containsKey('location')) {
      throw Exception(
        'Upload location for the thumbnail could not be determined',
      );
    }

    final uploadUri = Uri.parse(
      httpResponse.response.headers.value('location')!,
    );

    if (!uploadUri.queryParameters.containsKey('upload_id')) {
      throw Exception('Upload Id for the thumbnail could not be determined');
    }

    return await _rest.upload(
      'application/x-www-form-urlencoded',
      videoId,
      uploadUri.queryParameters['upload_id']!,
      thumbnail,
      uploadType,
    );
  }
}
