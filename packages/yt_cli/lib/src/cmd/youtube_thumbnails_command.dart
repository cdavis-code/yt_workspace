import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';
import '../util/security_util.dart';
import 'youtube_helper_command.dart';

/// A thumbnail resource identifies different thumbnail image sizes associated
/// with a resource. Please note the following characteristics of thumbnail
/// images:
///
/// A resource's snippet.thumbnails property is an object that identifies the
/// thumbnail images available for that resource.
/// A thumbnail resource contains a series of objects. The name of each object
///
/// (default, medium, high, etc.) refers to the thumbnail image size.
/// Different types of resources may support different thumbnail image sizes.
/// Different types of resources may define different sizes for thumbnail images
/// with the same name. For example, the default thumbnail image for a video
/// resource is typically 120px by 90px, and the default thumbnail image for a
/// channel resource is typically 88px by 88px.
/// Resources of the same type may still have different thumbnail image sizes for
/// certain images depending on the resolution of the original image or content
/// uploaded to YouTube. For example, an HD video may support higher resolution
/// thumbnails than non-HD videos.
/// Each object that contains information about a thumbnail image size has a
/// width property and a height property. However, the width and height
/// properties may not be returned for that image.
/// If an uploaded thumbnail image does not match the required dimensions, the
/// image is resized to match the correct size without changing its aspect ratio.
/// The image is not cropped, but may include black bars so that the size is
/// correct.
class YoutubeThumbnailsCommand extends YtHelperCommand {
  @override
  String get description =>
      'A thumbnail resource identifies different thumbnail image sizes associated with a resource.';

  @override
  String get name => 'thumbnails';

  YoutubeThumbnailsCommand() {
    addSubcommand(YoutubeSetThumbnailsCommand());
  }
}

///Uploads a custom video thumbnail to YouTube and sets it for a video.
class YoutubeSetThumbnailsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Uploads a custom video thumbnail to YouTube and sets it for a video.';

  @override
  String get name => 'set';

  YoutubeSetThumbnailsCommand() {
    argParser
      ..addOption(
        'video-id',
        valueHelp: 'YouTube video id',
        mandatory: true,
        help:
            'The videoId parameter specifies a YouTube video ID for which the custom video thumbnail is being provided.',
      )
      ..addOption(
        'file',
        valueHelp: 'file name',
        mandatory: true,
        help:
            'The file name that contains the thumbnail image that you are uploading.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final thumbnailFile = await SecurityUtil.validateInputFile(
        argResults!['file'] as String,
        argName: 'file',
      );
      final thumbnailSetResponse = await thumbnails.set(
        videoId: argResults!['video-id'],
        thumbnail: thumbnailFile,
      );

      print(thumbnailSetResponse);

      close();
    } on FormatException catch (e) {
      throw UsageException(e.message, usage);
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
