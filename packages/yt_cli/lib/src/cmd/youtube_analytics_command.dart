import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';

import 'youtube_helper_command.dart';

class YoutubeAnalyticsCommand extends Command<void> {
  @override
  String get description =>
      'Access YouTube Analytics reports, groups, and group items.';

  @override
  String get name => 'analytics';

  YoutubeAnalyticsCommand() {
    addSubcommand(YoutubeAnalyticsReportsCommand());
    addSubcommand(YoutubeAnalyticsGroupsCommand());
    addSubcommand(YoutubeAnalyticsGroupItemsCommand());
  }
}

// -- Reports --

class YoutubeAnalyticsReportsCommand extends Command<void> {
  @override
  String get description => 'Query YouTube Analytics reports for a channel.';

  @override
  String get name => 'reports';

  YoutubeAnalyticsReportsCommand() {
    addSubcommand(AnalyticsReportsQueryCommand());
  }
}

class AnalyticsReportsQueryCommand extends YtHelperCommand {
  @override
  String get description =>
      'Retrieve analytics data for a YouTube channel or content owner.';

  @override
  String get name => 'query';

  AnalyticsReportsQueryCommand() {
    argParser
      ..addOption(
        'ids',
        mandatory: true,
        valueHelp: 'channel==MINE',
        help:
            'Identifies the YouTube channel or content owner for which to retrieve analytics.',
      )
      ..addOption(
        'start-date',
        mandatory: true,
        valueHelp: 'YYYY-MM-DD',
        help: 'The start date for fetching analytics data.',
      )
      ..addOption(
        'end-date',
        mandatory: true,
        valueHelp: 'YYYY-MM-DD',
        help: 'The end date for fetching analytics data.',
      )
      ..addOption(
        'metrics',
        mandatory: true,
        valueHelp: 'views,estimatedMinutesWatched',
        help:
            'A comma-separated list of YouTube Analytics metrics, such as views or likes,dislikes.',
      )
      ..addOption(
        'dimensions',
        valueHelp: 'video,country',
        help:
            'A comma-separated list of YouTube Analytics dimensions, such as video or ageGroup,gender.',
      )
      ..addOption(
        'filters',
        valueHelp: 'video==dQw4w9WgXcQ',
        help: 'A list of filters to apply when retrieving analytics data.',
      )
      ..addOption(
        'sort',
        valueHelp: 'views',
        help:
            'A comma-separated list of dimensions or metrics that determine the sort order for analytics data.',
      )
      ..addOption(
        'max-results',
        valueHelp: 'number',
        help: 'The maximum number of rows to include in the response.',
      )
      ..addOption(
        'start-index',
        valueHelp: 'number',
        help:
            'An index of the first entity to retrieve. Use this parameter as a pagination mechanism along with the max-results parameter.',
      )
      ..addOption(
        'currency',
        valueHelp: 'USD',
        help: 'The currency to which financial metrics should be converted.',
      )
      ..addFlag(
        'include-historical-channel-data',
        help:
            'Whether historical channel data should be included in the response.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final response = await analytics.query(
        ids: argResults!['ids'],
        startDate: argResults!['start-date'],
        endDate: argResults!['end-date'],
        metrics: argResults!['metrics'],
        dimensions: argResults?['dimensions'],
        filters: argResults?['filters'],
        sort: argResults?['sort'],
        maxResults: int.tryParse(argResults?['max-results'] ?? ''),
        startIndex: int.tryParse(argResults?['start-index'] ?? ''),
        currency: argResults?['currency'],
        includeHistoricalChannelData:
            argResults?['include-historical-channel-data'],
      );

      print(response);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

// -- Groups --

class YoutubeAnalyticsGroupsCommand extends Command<void> {
  @override
  String get description =>
      'Manage YouTube Analytics groups for organizing channels, videos, playlists, or assets.';

  @override
  String get name => 'groups';

  YoutubeAnalyticsGroupsCommand() {
    addSubcommand(GroupsListCommand());
    addSubcommand(GroupsInsertCommand());
    addSubcommand(GroupsUpdateCommand());
    addSubcommand(GroupsDeleteCommand());
  }
}

class GroupsListCommand extends YtHelperCommand {
  @override
  String get description =>
      'Retrieves a list of analytics groups for the authenticated user.';

  @override
  String get name => 'list';

  GroupsListCommand() {
    argParser
      ..addOption(
        'id',
        valueHelp: 'group-id',
        help: 'The ID of a specific group to retrieve.',
      )
      ..addFlag(
        'mine',
        help:
            'Set this to true to retrieve only groups owned by the authenticated user.',
      )
      ..addOption(
        'page-token',
        valueHelp: 'token',
        help: 'The pageToken parameter identifies a specific page of results.',
      )
      ..addOption(
        'on-behalf-of-content-owner',
        valueHelp: 'content-owner-id',
        help: 'ID of the content owner for whom the API request is being made.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final response = await analytics.groupsList(
        id: argResults?['id'],
        mine: argResults?['mine'],
        pageToken: argResults?['page-token'],
        onBehalfOfContentOwner: argResults?['on-behalf-of-content-owner'],
      );

      print(response);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

class GroupsInsertCommand extends YtHelperCommand {
  @override
  String get description => 'Creates a new analytics group.';

  @override
  String get name => 'insert';

  GroupsInsertCommand() {
    argParser
      ..addOption(
        'body',
        mandatory: true,
        valueHelp: 'json',
        help:
            'The group resource body as a JSON string. Example: \'{"snippet": {"title": "My Group"}}\'',
      )
      ..addOption(
        'on-behalf-of-content-owner',
        valueHelp: 'content-owner-id',
        help: 'ID of the content owner for whom the API request is being made.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final body = jsonDecode(argResults!['body']) as Map<String, dynamic>;
      final response = await analytics.groupsInsert(
        body: body,
        onBehalfOfContentOwner: argResults?['on-behalf-of-content-owner'],
      );

      print(response);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

class GroupsUpdateCommand extends YtHelperCommand {
  @override
  String get description => 'Updates an existing analytics group.';

  @override
  String get name => 'update';

  GroupsUpdateCommand() {
    argParser
      ..addOption(
        'body',
        mandatory: true,
        valueHelp: 'json',
        help:
            'The group resource body as a JSON string. Must include the group id. Example: \'{"id": "abc", "snippet": {"title": "Updated Group"}}\'',
      )
      ..addOption(
        'on-behalf-of-content-owner',
        valueHelp: 'content-owner-id',
        help: 'ID of the content owner for whom the API request is being made.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final body = jsonDecode(argResults!['body']) as Map<String, dynamic>;
      final response = await analytics.groupsUpdate(
        body: body,
        onBehalfOfContentOwner: argResults?['on-behalf-of-content-owner'],
      );

      print(response);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

class GroupsDeleteCommand extends YtHelperCommand {
  @override
  String get description => 'Deletes an analytics group.';

  @override
  String get name => 'delete';

  GroupsDeleteCommand() {
    argParser
      ..addOption(
        'id',
        mandatory: true,
        valueHelp: 'group-id',
        help: 'The ID of the group to delete.',
      )
      ..addOption(
        'on-behalf-of-content-owner',
        valueHelp: 'content-owner-id',
        help: 'ID of the content owner for whom the API request is being made.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      await analytics.groupsDelete(
        id: argResults!['id'],
        onBehalfOfContentOwner: argResults?['on-behalf-of-content-owner'],
      );

      print('Group deleted successfully.');

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

// -- Group Items --

class YoutubeAnalyticsGroupItemsCommand extends Command<void> {
  @override
  String get description => 'Manage items within a YouTube Analytics group.';

  @override
  String get name => 'group-items';

  YoutubeAnalyticsGroupItemsCommand() {
    addSubcommand(GroupItemsListCommand());
    addSubcommand(GroupItemsInsertCommand());
    addSubcommand(GroupItemsDeleteCommand());
  }
}

class GroupItemsListCommand extends YtHelperCommand {
  @override
  String get description => 'Retrieves a list of items in a group.';

  @override
  String get name => 'list';

  GroupItemsListCommand() {
    argParser
      ..addOption(
        'group-id',
        valueHelp: 'group-id',
        help: 'The group ID for which to retrieve items.',
      )
      ..addOption(
        'id',
        valueHelp: 'item-id',
        help: 'The ID of a specific group item to retrieve.',
      )
      ..addOption(
        'page-token',
        valueHelp: 'token',
        help: 'The pageToken parameter identifies a specific page of results.',
      )
      ..addOption(
        'on-behalf-of-content-owner',
        valueHelp: 'content-owner-id',
        help: 'ID of the content owner for whom the API request is being made.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final response = await analytics.groupItemsList(
        groupId: argResults?['group-id'],
        id: argResults?['id'],
        pageToken: argResults?['page-token'],
        onBehalfOfContentOwner: argResults?['on-behalf-of-content-owner'],
      );

      print(response);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

class GroupItemsInsertCommand extends YtHelperCommand {
  @override
  String get description => 'Inserts an item into a group.';

  @override
  String get name => 'insert';

  GroupItemsInsertCommand() {
    argParser
      ..addOption(
        'body',
        mandatory: true,
        valueHelp: 'json',
        help:
            'The group item resource body as a JSON string. Example: \'{"groupId": "abc", "resource": {"id": "dQw4w9WgXcQ", "kind": "youtube#video"}}\'',
      )
      ..addOption(
        'on-behalf-of-content-owner',
        valueHelp: 'content-owner-id',
        help: 'ID of the content owner for whom the API request is being made.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final body = jsonDecode(argResults!['body']) as Map<String, dynamic>;
      final response = await analytics.groupItemsInsert(
        body: body,
        onBehalfOfContentOwner: argResults?['on-behalf-of-content-owner'],
      );

      print(response);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

class GroupItemsDeleteCommand extends YtHelperCommand {
  @override
  String get description => 'Deletes an item from a group.';

  @override
  String get name => 'delete';

  GroupItemsDeleteCommand() {
    argParser
      ..addOption(
        'id',
        mandatory: true,
        valueHelp: 'item-id',
        help: 'The ID of the group item to delete.',
      )
      ..addOption(
        'on-behalf-of-content-owner',
        valueHelp: 'content-owner-id',
        help: 'ID of the content owner for whom the API request is being made.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      await analytics.groupItemsDelete(
        id: argResults!['id'],
        onBehalfOfContentOwner: argResults?['on-behalf-of-content-owner'],
      );

      print('Group item deleted successfully.');

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
