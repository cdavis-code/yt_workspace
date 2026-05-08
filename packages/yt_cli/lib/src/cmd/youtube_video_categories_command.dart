import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';
import 'youtube_helper_command.dart';

/// A video resource represents a YouTube video.
class YoutubeVideoCategoriesCommand extends Command<void> {
  @override
  String get description =>
      'A videoCategory resource identifies a category that has been or could be associated with uploaded videos.';

  @override
  String get name => 'video-categories';

  YoutubeVideoCategoriesCommand() {
    addSubcommand(YoutubeListVideoCategoriesCommand());
  }
}

/// Returns a list of categories that can be associated with YouTube videos.
class YoutubeListVideoCategoriesCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of categories that can be associated with YouTube videos.';

  @override
  String get name => 'list';

  YoutubeListVideoCategoriesCommand() {
    argParser
      ..addOption(
        'id',
        valueHelp: 'id',
        help:
            'The id parameter specifies a comma-separated list of video category IDs for the resources that you are retrieving.',
      )
      ..addOption(
        'region-code',
        valueHelp: 'code',
        help:
            'The regionCode parameter instructs the API to return the list of video categories available in the specified country. The parameter value is an ISO 3166-1 alpha-2 country code.',
      )
      ..addOption(
        'hl',
        help:
            'The hl parameter instructs the API to retrieve localized resource metadata for a specific application language that the YouTube website supports. The parameter value must be a language code included in the list returned by the i18nLanguages.list method.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final videoCategoryListResponse = await videoCategories.list(
        id: argResults?['id'],
        regionCode: argResults?['region-code'],
        hl: argResults?['hl'],
      );

      print(videoCategoryListResponse);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
