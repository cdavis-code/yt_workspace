import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';

import 'youtube_helper_command.dart';

class YoutubeMembersCommand extends Command<void> {
  @override
  String get description =
      'A member resource represents a YouTube channel member who provides recurring monetary support to a creator and receives special benefits.';

  @override
  String get name => 'members';

  YoutubeMembersCommand() {
    addSubcommand(YoutubeListMembersCommand());
  }
}

class YoutubeListMembersCommand extends YtHelperCommand {
  @override
  String get description => 'Lists members for a channel.';

  @override
  String get name => 'list';

  YoutubeListMembersCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet',
        help:
            'The part parameter specifies the member resource parts that the API response will include.',
      )
      ..addOption(
        'mode',
        defaultsTo: 'allCurrentMembers',
        valueHelp: 'mode',
        help:
            'The mode parameter indicates which members to return. Valid values: allCurrentMembers, updatesSince.',
      )
      ..addOption(
        'max-results',
        defaultsTo: '1000',
        valueHelp: 'number',
        help:
            'The maxResults parameter specifies the maximum number of items to return.',
      )
      ..addOption(
        'page-token',
        valueHelp: 'token',
        help: 'The pageToken parameter identifies a specific page of results.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final response = await members.list(
        part: argResults!['part'],
        mode: argResults?['mode'],
        maxResults: int.tryParse(argResults?['max-results'] ?? ''),
        pageToken: argResults?['page-token'],
      );

      print(response);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}