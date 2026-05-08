import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';
import 'youtube_helper_command.dart';

/// A [Watermarks] resource identifies an image that displays during playbacks of
/// a specified channel's videos. You can also specify a target channel to which
/// the image will link as well as timing details that determine when the
/// watermark appears during video playbacks and the length of time it is
/// visible.
class YoutubeWatermarksCommand extends YtHelperCommand {
  @override
  String get description =>
      'A watermark resource identifies an image that displays during playbacks of a specified channel\'s videos.';

  @override
  String get name => 'watermarks';

  YoutubeWatermarksCommand() {
    addSubcommand(YoutubeSetWatermarksCommand());
    addSubcommand(YoutubeUnsetWatermarksCommand());
  }
}

/// Uploads a custom video thumbnail to YouTube and sets it for a video.
class YoutubeSetWatermarksCommand extends YtHelperCommand {
  @override
  String get description =>
      'Uploads a custom video thumbnail to YouTube and sets it for a video.';

  @override
  String get name => 'set';

  YoutubeSetWatermarksCommand() {
    argParser
      ..addOption(
        'timing-type',
        valueHelp: 'string',
        allowed: ['offsetFromStart', 'offsetFromEnd'],
        defaultsTo: 'offsetFromStart',
        help:
            'The timing method that determines when the watermark image is displayed during the video playback. If the value is offsetFromStart, then the offsetMs field represents an offset from the start of the video. If the value is offsetFromEnd, then the offsetMs field represents an offset from the end of the video.',
      )
      ..addOption(
        'offsetMs',
        valueHelp: 'int',
        defaultsTo: '0',
        help:
            'The time offset, specified in milliseconds, that determines when the promoted item appears during video playbacks. The type property\'s value determines whether the offset is measured from the start or end of the video.',
      )
      ..addOption(
        'durationMs',
        valueHelp: 'int',
        defaultsTo: '0',
        help:
            'The length of time, in milliseconds, that the watermark image should display.',
      )
      ..addOption(
        'cornerPosition',
        valueHelp: 'string',
        allowed: ['topRight', 'topLeft', 'bottomRight', 'bottomLeft'],
        defaultsTo: 'topRight',
        help:
            'The corner of the player where the promoted item will appear. The item always appears in the upper right corner of the player.',
      )
      ..addOption(
        'channel-id',
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
      final success = await watermarks.set(
        channelId: argResults!['channel-id'],
        watermarksResource: WatermarksResource.fromFilePath(
          timing: Timing(
            type: argResults!['timing-type'],
            offsetMs: int.parse(argResults!['offsetMs']),
            durationMs: int.parse(argResults!['durationMs']),
          ),
          position: Position(cornerPosition: argResults!['cornerPosition']),
          imageFileName: argResults!['file'],
          targetChannelId: argResults!['channel-id'],
        ),
      );

      print(success);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Deletes a channel's watermark image.
class YoutubeUnsetWatermarksCommand extends YtHelperCommand {
  @override
  String get description => 'Deletes a channel\'s watermark image.';

  @override
  String get name => 'unset';

  YoutubeUnsetWatermarksCommand() {
    argParser.addOption(
      'channel-id',
      valueHelp: 'YouTube video id',
      mandatory: true,
      help:
          'The channelId parameter specifies the YouTube channel ID for which the watermark is being unset.',
    );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final success = await watermarks.unset(
        channelId: argResults!['channel-id'],
      );

      print(success);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
