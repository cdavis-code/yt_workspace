import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';

import 'youtube_helper_command.dart';

/// Command group for the i18nLanguages resource.
///
/// An i18nLanguage resource identifies an application language that the
/// YouTube website supports.
class YoutubeI18nLanguagesCommand extends Command<void> {
  @override
  String get description =>
      'An i18nLanguage resource identifies an application language that the YouTube website supports.';

  @override
  String get name => 'i18n-languages';

  YoutubeI18nLanguagesCommand() {
    addSubcommand(YoutubeListI18nLanguagesCommand());
  }
}

/// Returns a list of application languages that the YouTube website supports.
class YoutubeListI18nLanguagesCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of application languages that the YouTube website supports.';

  @override
  String get name => 'list';

  YoutubeListI18nLanguagesCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet',
        help:
            'The part parameter specifies the i18nLanguage resource properties that the API response will include. Valid value: snippet.',
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
      final response = await i18nLanguages.list(
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
