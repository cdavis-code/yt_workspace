import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';

import 'youtube_helper_command.dart';

/// Command group for video abuse report reasons.
///
/// A videoAbuseReportReason resource contains information about reasons
/// that a video would be flagged for containing abusive content.
class YoutubeVideoAbuseReportReasonsCommand extends Command<void> {
  @override
  String get description =>
      'A videoAbuseReportReason resource contains information about a reason that a video would be flagged for containing abusive content.';

  @override
  String get name => 'video-abuse-report-reasons';

  YoutubeVideoAbuseReportReasonsCommand() {
    addSubcommand(YoutubeListVideoAbuseReportReasonsCommand());
  }
}

/// Retrieve a list of reasons for reporting abusive videos.
///
/// Returns reasons that can be used when reporting videos for abuse,
/// with localized text support via the hl parameter.
class YoutubeListVideoAbuseReportReasonsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Retrieves a list of reasons that can be used to report abusive videos.';

  @override
  String get name => 'list';

  YoutubeListVideoAbuseReportReasonsCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'id,snippet',
        help:
            'The part parameter specifies the videoAbuseReportReason resource parts that the API response will include.',
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
      final response = await videoAbuseReportReasons.list(
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
