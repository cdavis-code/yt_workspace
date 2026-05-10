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
    ..addCommand(YoutubeAuthorizeCommand())
    ..addCommand(YoutubeBroadcastCommand())
    ..addCommand(YoutubeChannelsCommand())
    ..addCommand(YoutubeCommentsCommand())
    ..addCommand(YoutubeCommentThreadsCommand())
    ..addCommand(YoutubeMembersCommand())
    ..addCommand(YoutubeMembershipsLevelsCommand())
    ..addCommand(YoutubeVideoAbuseReportReasonsCommand())
    ..addCommand(YoutubePlaylistsCommand())
    ..addCommand(YoutubeSearchCommand())
    ..addCommand(YoutubeStreamCommand())
    ..addCommand(YoutubeSubscriptionsCommand())
    ..addCommand(YoutubeThumbnailsCommand())
    ..addCommand(YoutubeVersionCommand())
    ..addCommand(YoutubeVideosCommand())
    ..addCommand(YoutubeVideoCategoriesCommand())
    ..addCommand(YoutubeWatermarksCommand())
    ..run(arguments).catchError((Object error) {
      if (error is! UsageException) throw error;

      print(error);

      exit(64); // Exit code 64 indicates a usage error.
    });
}
