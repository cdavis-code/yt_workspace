import 'package:yt/src/youtube_api_helper.dart';

import 'model/watermark/watermarks_resource.dart';
import 'provider/data/watermarks.dart';

/// A [Watermarks] resource identifies an image that displays during playbacks of
/// a specified channel's videos. You can also specify a target channel to which
/// the image will link as well as timing details that determine when the
/// watermark appears during video playbacks and the length of time it is
/// visible.
class Watermarks extends YouTubeApiHelper {
  final WatermarksClient _rest;

  Watermarks({required super.dio}) : _rest = WatermarksClient(dio);

  /// Uploads a watermark image to YouTube and sets it for a channel.
  ///
  /// This method supports media upload. Uploaded files must conform to these constraints:
  ///
  /// - Maximum file size: 10MB
  /// - Accepted Media MIME types: image/jpeg, image/png, application/octet-stream
  ///
  Future<bool> set({
    required String channelId,
    required WatermarksResource watermarksResource,
  }) async {
    final httpResponse = await _rest.set(
      'application/json',
      channelId,
      watermarksResource,
    );

    if (httpResponse.response.statusCode == null) {
      throw Exception('Error unset watermark');
    }

    return httpResponse.response.statusCode! == 204;
  }

  Future<bool> unset({required String channelId}) async {
    final httpResponse = await _rest.unset(channelId);

    if (httpResponse.response.statusCode == null) {
      throw Exception('Error unset watermark');
    }

    return httpResponse.response.statusCode! == 204;
  }
}
