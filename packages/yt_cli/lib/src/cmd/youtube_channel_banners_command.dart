import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';

import '../util/security_util.dart';
import 'youtube_helper_command.dart';

/// Command group for the channelBanners resource.
///
/// A channelBanner resource contains the URL that you would use to set a
/// newly uploaded image as the banner image for a channel.
class YoutubeChannelBannersCommand extends Command<void> {
  @override
  String get description =>
      'A channelBanner resource contains the URL that you would use to set a newly uploaded image as the banner image for a channel.';

  @override
  String get name => 'channel-banners';

  YoutubeChannelBannersCommand() {
    addSubcommand(YoutubeInsertChannelBannersCommand());
  }
}

/// Uploads a channel banner image to YouTube.
class YoutubeInsertChannelBannersCommand extends YtHelperCommand {
  @override
  String get description => 'Uploads a channel banner image to YouTube.';

  @override
  String get name => 'insert';

  YoutubeInsertChannelBannersCommand() {
    argParser
      ..addOption(
        'file',
        valueHelp: 'file name',
        mandatory: true,
        help: 'The file name that contains the banner image to upload.',
      )
      ..addOption(
        'channel-id',
        valueHelp: 'channel id',
        help:
            'The channelId parameter identifies the channel to which the banner is being uploaded.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final imageFile = await SecurityUtil.validateInputFile(
        argResults!['file'] as String,
        argName: 'file',
      );

      final result = await channelBanners.insert(
        image: imageFile,
        channelId: argResults?['channel-id'],
      );

      print(result);

      close();
    } on FormatException catch (e) {
      throw UsageException(e.message, usage);
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
