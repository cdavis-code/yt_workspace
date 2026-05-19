import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';

import 'youtube_helper_command.dart';

/// Command group for the i18nRegions resource.
///
/// An i18nRegion resource identifies a geographic area that a YouTube user
/// can select as the preferred content region.
class YoutubeI18nRegionsCommand extends Command<void> {
  @override
  String get description =>
      'An i18nRegion resource identifies a geographic area that a YouTube user can select as the preferred content region.';

  @override
  String get name => 'i18n-regions';

  YoutubeI18nRegionsCommand() {
    addSubcommand(YoutubeListI18nRegionsCommand());
  }
}

/// Returns a list of content regions that the YouTube website supports.
class YoutubeListI18nRegionsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of content regions that the YouTube website supports.';

  @override
  String get name => 'list';

  YoutubeListI18nRegionsCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet',
        help:
            'The part parameter specifies the i18nRegion resource properties that the API response will include. Valid value: snippet.',
      )
      ..addOption(
        'hl',
        valueHelp: 'language',
        help:
            'The hl parameter specifies the language that should be used for text values in the API response.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final response = await i18nRegions.list(
        part: argResults!['part'],
        hl: argResults?['hl'],
      );

      print(response);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
