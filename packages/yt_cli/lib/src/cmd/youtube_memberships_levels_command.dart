import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';

import 'youtube_helper_command.dart';

class YoutubeMembershipsLevelsCommand extends Command<void> {
  @override
  String get description =>
      'A membershipsLevel resource identifies a pricing level managed by the creator that authorized the API request.';

  @override
  String get name => 'memberships-levels';

  YoutubeMembershipsLevelsCommand() {
    addSubcommand(YoutubeListMembershipsLevelsCommand());
  }
}

class YoutubeListMembershipsLevelsCommand extends YtHelperCommand {
  @override
  String get description => 'Lists membership levels for the channel.';

  @override
  String get name => 'list';

  YoutubeListMembershipsLevelsCommand() {
    argParser.addOption(
      'part',
      defaultsTo: 'id,snippet',
      help:
          'The part parameter specifies the membershipsLevel resource parts that the API response will include.',
    );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final response = await membershipsLevels.list(part: argResults!['part']);

      print(response);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
