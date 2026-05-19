import 'package:args/command_runner.dart';
import 'package:universal_io/io.dart';
import 'package:yt_cli/yt_cli.dart';

void main(List<String> arguments) async {
  CommandRunner<void>(
      'yt',
      'A command line interface for connecting to Youtube',
    )
    ..argParser.addOption(
      'log-level',
      allowed: ['all', 'debug', 'info', 'warning', 'error', 'off'],
      defaultsTo: 'off',
    )
    ..addCommand(YoutubeActivitiesCommand())
    ..addCommand(YoutubeAnalyticsCommand())
    ..addCommand(YoutubeAuthorizeCommand())
    ..addCommand(YoutubeBroadcastCommand())
    ..addCommand(YoutubeCaptionsCommand())
    ..addCommand(YoutubeChannelBannersCommand())
    ..addCommand(YoutubeChannelSectionsCommand())
    ..addCommand(YoutubeChannelsCommand())
    ..addCommand(YoutubeCommentsCommand())
    ..addCommand(YoutubeCommentThreadsCommand())
    ..addCommand(YoutubeI18nLanguagesCommand())
    ..addCommand(YoutubeI18nRegionsCommand())
    ..addCommand(YoutubeMembersCommand())
    ..addCommand(YoutubeMembershipsLevelsCommand())
    ..addCommand(YoutubePlaylistImagesCommand())
    ..addCommand(YoutubePlaylistItemsCommand())
    ..addCommand(YoutubePlaylistsCommand())
    ..addCommand(YoutubeSearchCommand())
    ..addCommand(YoutubeStreamCommand())
    ..addCommand(YoutubeSubscriptionsCommand())
    ..addCommand(YoutubeThirdPartyLinksCommand())
    ..addCommand(YoutubeThumbnailsCommand())
    ..addCommand(YoutubeVersionCommand())
    ..addCommand(YoutubeVideoAbuseReportReasonsCommand())
    ..addCommand(YoutubeVideoCategoriesCommand())
    ..addCommand(YoutubeVideosCommand())
    ..addCommand(YoutubeWatermarksCommand())
    ..run(arguments).catchError((Object error) {
      if (error is! UsageException) throw error;

      print(error);

      exit(64); // Exit code 64 indicates a usage error.
    });
}
