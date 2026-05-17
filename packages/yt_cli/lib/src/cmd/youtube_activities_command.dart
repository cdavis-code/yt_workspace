import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';

import 'youtube_helper_command.dart';

/// An activity resource contains information about an action that a particular
/// channel, or user, has taken on YouTube.
class YoutubeActivitiesCommand extends Command<void> {
  @override
  String get description =>
      'An activity resource contains information about an action that a particular channel, or user, has taken on YouTube.';

  @override
  String get name => 'activities';

  YoutubeActivitiesCommand() {
    addSubcommand(YoutubeListActivitiesCommand());
  }
}

/// Returns a list of channel activity events that match the request criteria.
class YoutubeListActivitiesCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of channel activity events that match the request criteria.';

  @override
  String get name => 'list';

  YoutubeListActivitiesCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet,contentDetails',
        help:
            'The part parameter specifies the activity resource parts that the API response will include.',
      )
      ..addOption(
        'channel-id',
        valueHelp: 'YouTube channel id',
        help:
            'The channelId parameter specifies a unique YouTube channel ID. The API will then return a list of that channel\'s activities.',
      )
      ..addFlag(
        'mine',
        defaultsTo: false,
        negatable: false,
        help:
            'This parameter can only be used in a properly authorized request. Set this parameter\'s value to true to retrieve a feed of the authenticated user\'s activities.',
      )
      ..addOption(
        'max-results',
        defaultsTo: '5',
        valueHelp: 'number',
        help:
            'The maxResults parameter specifies the maximum number of items that should be returned in the result set. Acceptable values are 1 to 50, inclusive. The default value is 5.',
      )
      ..addOption(
        'page-token',
        valueHelp: 'token',
        help:
            'The pageToken parameter identifies a specific page in the result set that should be returned.',
      )
      ..addOption(
        'published-after',
        valueHelp: 'date',
        help:
            'The publishedAfter parameter specifies the earliest date and time that an activity could have occurred for that activity to be included in the API response. The value is an RFC 3339 formatted date-time value (1970-01-01T00:00:00Z).',
      )
      ..addOption(
        'published-before',
        valueHelp: 'date',
        help:
            'The publishedBefore parameter specifies the date and time before which an activity must have occurred for that activity to be included in the API response. The value is an RFC 3339 formatted date-time value (1970-01-01T00:00:00Z).',
      )
      ..addOption(
        'region-code',
        valueHelp: 'code',
        help:
            'The regionCode parameter instructs the API to return results for the specified country. The parameter value is an ISO 3166-1 alpha-2 country code.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final response = await activities.list(
        part: argResults!['part'],
        channelId: argResults?['channel-id'],
        mine: argResults?.flag('mine') == true ? true : null,
        maxResults: int.tryParse(argResults?['max-results'] ?? ''),
        pageToken: argResults?['page-token'],
        publishedAfter: argResults?['published-after'],
        publishedBefore: argResults?['published-before'],
        regionCode: argResults?['region-code'],
      );

      print(response);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
