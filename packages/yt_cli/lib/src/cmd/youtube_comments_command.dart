import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';
import 'youtube_helper_command.dart';

/// A comment resource contains information about a single YouTube comment.
class YoutubeCommentsCommand extends YtHelperCommand {
  @override
  String get description =>
      'A comment resource contains information about a single YouTube comment.';

  @override
  String get name => 'comments';

  YoutubeCommentsCommand() {
    addSubcommand(YoutubeListCommentsCommand());
    addSubcommand(YoutubeListByIdsCommentsCommand());
    addSubcommand(YoutubeListByIdCommentsCommand());
    addSubcommand(YoutubeListByParentIdCommentsCommand());
    addSubcommand(YoutubeInsertCommentsCommand());
    addSubcommand(YoutubeAddCommentsCommand());
    addSubcommand(YoutubeUpdateCommentsCommand());
    addSubcommand(YoutubeChangeCommentsCommand());
    addSubcommand(YoutubeSetModerationStatusCommentsCommand());
    addSubcommand(YoutubeDeleteCommentsCommand());
  }
}

/// Returns a list of comments that match the API request parameters.
class YoutubeListCommentsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of comments that match the API request parameters.';
  @override
  String get name => 'list';

  YoutubeListCommentsCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'id,snippet',
        help:
            '''The part parameter specifies a comma-separated list of one or more comment resource properties that the API response will include.

The following list contains the part names that you can include in the parameter value:
id, snippet''',
      )
      ..addOption(
        'id',
        abbr: 'i',
        aliases: ['ID', 'Id'],
        valueHelp: 'string',
        help:
            'The id parameter specifies a comma-separated list of comment IDs for the resources that are being retrieved. In a comment resource, the id property specifies the comment\'s ID.',
      )
      ..addOption(
        'parent-id',
        valueHelp: 'string',
        help:
            'The parentId parameter specifies the ID of the comment for which replies should be retrieved.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final commentListResponse = await comments.list(
        part: argResults!['part'],
        id: argResults?['id'],
        parentId: argResults?['parent-id'],
      );

      print(commentListResponse);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

class YoutubeListByIdsCommentsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of comments that match the API request parameters.';
  @override
  String get name => 'listByIds';

  YoutubeListByIdsCommentsCommand() {
    argParser
      ..addOption(
        'ids',
        abbr: 'i',
        aliases: ['ID', 'Id', 'IDS', 'Ids'],
        valueHelp: 'string (comma-separated)',
        help:
            'The id parameter specifies a comma-separated list of comment IDs for the resources that are being retrieved. In a comment resource, the id property specifies the comment\'s ID.',
      )
      ..addOption(
        'max-results',
        valueHelp: 'number',
        defaultsTo: '5',
        help:
            '''The maxResults parameter specifies the maximum number of items that should be returned in the result set.

Note: This parameter is not supported for use in conjunction with the id parameter. Acceptable values are 1 to 100, inclusive. The default value is 20.''',
      )
      ..addOption(
        'page-token',
        valueHelp: 'string',
        help:
            '''The pageToken parameter identifies a specific page in the result set that should be returned. In an API response, the nextPageToken property identifies the next page of the result that can be retrieved.

Note: This parameter is not supported for use in conjunction with the id parameter.''',
      )
      ..addOption(
        'text-format',
        valueHelp: 'string',
        allowed: ['html', 'plainText'],
        help:
            'Set this parameter\'s value to html or plainText to instruct the API to return the comments left by users in html formatted or in plain text. The default value is html.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final commentListResponse = await comments.listByIds(
        ids: argResults!['ids'],
        maxResults: argResults?['max-results'],
        pageToken: argResults?['page-token'],
        textFormat: argResults?['text-format'],
      );

      print(commentListResponse);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

class YoutubeListByIdCommentsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of comments that match the API request parameters.';
  @override
  String get name => 'listById';

  YoutubeListByIdCommentsCommand() {
    argParser
      ..addOption(
        'id',
        abbr: 'i',
        aliases: ['ID', 'Id'],
        valueHelp: 'string',
        mandatory: true,
        help:
            'The id parameter specifies an ID for the resource that is to be retrieved. In a comment resource, the id property specifies the comment\'s ID.',
      )
      ..addOption(
        'max-results',
        valueHelp: 'number',
        defaultsTo: '5',
        help:
            '''The maxResults parameter specifies the maximum number of items that should be returned in the result set.

Note: This parameter is not supported for use in conjunction with the id parameter. Acceptable values are 1 to 100, inclusive. The default value is 20.''',
      )
      ..addOption(
        'page-token',
        valueHelp: 'string',
        help:
            '''The pageToken parameter identifies a specific page in the result set that should be returned. In an API response, the nextPageToken property identifies the next page of the result that can be retrieved.

Note: This parameter is not supported for use in conjunction with the id parameter.''',
      )
      ..addOption(
        'text-format',
        valueHelp: 'string',
        allowed: ['html', 'plainText'],
        help:
            'Set this parameter\'s value to html or plainText to instruct the API to return the comments left by users in html formatted or in plain text. The default value is html.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final commentListResponse = await comments.listById(
        id: argResults!['id'],
        textFormat: argResults?['text-format'],
      );

      print(commentListResponse.items.first);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

class YoutubeListByParentIdCommentsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of comments that match the API request parameters.';
  @override
  String get name => 'listByParentId';

  YoutubeListByParentIdCommentsCommand() {
    //noop
  }

  @override
  void run() => throw UnimplementedError();
}

class YoutubeInsertCommentsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of comments that match the API request parameters.';
  @override
  String get name => 'insert';

  YoutubeInsertCommentsCommand() {
    //noop
  }

  @override
  void run() => throw UnimplementedError();
}

class YoutubeAddCommentsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of comments that match the API request parameters.';
  @override
  String get name => 'listByParentId';

  YoutubeAddCommentsCommand() {
    //noop
  }

  @override
  void run() => throw UnimplementedError();
}

class YoutubeUpdateCommentsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of comments that match the API request parameters.';
  @override
  String get name => 'listByParentId';

  YoutubeUpdateCommentsCommand() {
    //noop
  }

  @override
  void run() => throw UnimplementedError();
}

class YoutubeChangeCommentsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of comments that match the API request parameters.';
  @override
  String get name => 'listByParentId';

  YoutubeChangeCommentsCommand() {
    //noop
  }

  @override
  void run() => throw UnimplementedError();
}

class YoutubeSetModerationStatusCommentsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of comments that match the API request parameters.';
  @override
  String get name => 'listByParentId';

  YoutubeSetModerationStatusCommentsCommand() {
    //noop
  }

  @override
  void run() => throw UnimplementedError();
}

class YoutubeDeleteCommentsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of comments that match the API request parameters.';
  @override
  String get name => 'listByParentId';

  YoutubeDeleteCommentsCommand() {
    //noop
  }

  @override
  void run() => throw UnimplementedError();
}
