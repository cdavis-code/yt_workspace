import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:universal_io/io.dart';
import 'package:yt/yt.dart';
import 'youtube_helper_command.dart';

/// A liveBroadcast resource represents an event that will be streamed, via live
/// video, on YouTube.
class YoutubeBroadcastCommand extends YtHelperCommand {
  @override
  String get description =>
      'A liveBroadcast resource represents an event that will be streamed, via live video, on YouTube.';

  @override
  String get name => 'broadcast';

  YoutubeBroadcastCommand() {
    addSubcommand(YoutubeTransitionBroadcastCommand());
    addSubcommand(YoutubeListBroadcastCommand());
    addSubcommand(YoutubeInsertBroadcastCommand());
    addSubcommand(YoutubeDeleteBroadcastCommand());
    addSubcommand(YoutubeBindBroadcastCommand());
    addSubcommand(YoutubeUpdateBroadcastCommand());
  }
}

/// Changes the status of a YouTube live broadcast and initiates any processes
/// associated with the new status. For example, when you transition a
/// broadcast's status to testing, YouTube starts to transmit video to that
/// broadcast's monitor stream. Before calling this method, you should confirm
/// that the value of the status.streamStatus property for the stream bound to
/// your broadcast is active.
class YoutubeTransitionBroadcastCommand extends YtHelperCommand {
  @override
  String get description =>
      'Changes the status of a YouTube live broadcast and initiates any processes associated with the new status.';

  @override
  String get name => 'transition';

  YoutubeTransitionBroadcastCommand() {
    argParser
      ..addOption(
        'broadcast-status',
        allowed: ['complete', 'live', 'testing'],
        valueHelp: 'status',
        mandatory: true,
        allowedHelp: {
          'complete':
              'The broadcast is over. YouTube stops transmitting video.',
          'live':
              'The broadcast is visible to its audience. YouTube transmits video to the broadcast\'s monitor stream and its broadcast stream.',
          'testing':
              'Start testing the broadcast. YouTube transmits video to the broadcast\'s monitor stream. Note that you can only transition a broadcast to the testing state if its contentDetails.monitorStream.enableMonitorStream property is set to true.',
        },
        help:
            'The broadcastStatus parameter identifies the state to which the broadcast is changing. Note that to transition a broadcast to either the testing or live state, the status.streamStatus must be active for the stream that the broadcast is bound to.',
      )
      ..addOption(
        'part',
        defaultsTo: 'id,snippet,contentDetails,status',
        help:
            'The part parameter specifies a comma-separated list of one or more liveBroadcast resource properties that the API response will include. The part names that you can include in the parameter value are id, snippet, contentDetails, and status.',
      )
      ..addOption(
        'id',
        mandatory: true,
        valueHelp: 'id',
        help:
            'The id parameter specifies the unique ID of the broadcast that is transitioning to another status.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final liveBroadcastItem = await broadcast.transition(
        part: argResults!['part'],
        broadcastStatus: argResults?['broadcast-status'],
        id: argResults?['id'],
      );

      print(liveBroadcastItem);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Returns a list of YouTube broadcasts that match the API request parameters.
class YoutubeListBroadcastCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of YouTube broadcasts that match the API request parameters.';

  @override
  String get name => 'list';

  YoutubeListBroadcastCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet,status,contentDetails',
        help: 'The type of a pre-built template for the broadcast to start',
      )
      ..addOption(
        'broadcast-status',
        // defaultsTo: 'all',
        allowed: ['active', 'all', 'completed', 'upcoming'],
        help:
            'The broadcastStatus parameter filters the API response to only include broadcasts with the specified status.',
        // valueHelp: 'status',
        allowedHelp: {
          'active': 'Return current live broadcasts.',
          'all': 'Return all broadcasts.',
          'completed': 'Return broadcasts that have already ended.',
          'upcoming': 'Return broadcasts that have not yet started.',
        },
      )
      ..addOption(
        'id',
        valueHelp: 'id',
        help:
            'The id parameter specifies a comma-separated list of YouTube broadcast IDs that identify the broadcasts being retrieved. In a liveBroadcast resource, the id property specifies the broadcast\'s ID.',
      )
      ..addOption(
        'broadcast-type',
        defaultsTo: 'event',
        allowed: ['all', 'event', 'persistent'],
        help:
            'The broadcastType parameter filters the API response to only include broadcasts with the specified type. The parameter should be used in requests that set the mine parameter to true or that use the broadcastStatus parameter. The default value is event.',
        allowedHelp: {
          'all': 'Return all broadcasts.',
          'event': 'Return only scheduled event broadcasts.',
          'persistent': 'Return only persistent broadcasts.',
        },
      )
      ..addOption(
        'max-results',
        defaultsTo: '5',
        valueHelp: 'number',
        help:
            'The maxResults parameter specifies the maximum number of items that should be returned in the result set. Acceptable values are 0 to 50, inclusive. The default value is 5.',
      )
      ..addOption(
        'pageToken',
        valueHelp: 'string',
        help:
            'The pageToken parameter identifies a specific page in the result set that should be returned. In an API response, the nextPageToken and prevPageToken properties identify other pages that could be retrieved.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      LiveBroadcastResponse liveBroadcastResponse = await broadcast.list(
        part: argResults!['part'],
        broadcastStatus: argResults!['broadcast-status'],
        broadcastType: argResults!['broadcast-type'],
        id: argResults?['id'],
        maxResults: int.parse(argResults!['max-results']),
      );

      print(liveBroadcastResponse);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Creates a broadcast.
class YoutubeInsertBroadcastCommand extends YtHelperCommand {
  @override
  String get description => 'Creates a broadcast.';

  @override
  String get name => 'insert';

  YoutubeInsertBroadcastCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet,contentDetails,status',
        help:
            '''The part parameter serves two purposes in this operation. It identifies the properties that the write operation will set as well as the properties that the API response will include.
              
              The part properties that you can include in the parameter value are id, snippet, contentDetails, and status.''',
      )
      ..addOption(
        'body',
        mandatory: true,
        help:
            'Provide a json formatted `liveBroadcast` resource [https://developers.google.com/youtube/v3/live/docs/liveBroadcasts#resource] in the request body or provide the `file name` of a json file that contains the `liveBroadcast` resource.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    final content = argResults!['body'] as String;

    // won't work with a file name that starts with the '{' character
    final isJson = content.trimLeft().startsWith('{');

    final body = isJson ? content : File(content).readAsStringSync();

    try {
      final liveBroadcastItem = await broadcast.insert(
        body: json.decode(body),
        part: argResults!['part'],
      );

      print(liveBroadcastItem);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Deletes a broadcast.
class YoutubeDeleteBroadcastCommand extends YtHelperCommand {
  @override
  String get description => 'Deletes a broadcast.';

  @override
  String get name => 'delete';

  YoutubeDeleteBroadcastCommand() {
    argParser.addOption(
      'id',
      mandatory: true,
      valueHelp: 'id',
      help:
          'The id parameter specifies the YouTube live broadcast ID for the resource that is being deleted.',
    );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      await broadcast.delete(id: argResults!['id']);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Updates a broadcast. For example, you could modify the broadcast settings
/// defined in the liveBroadcast resource's contentDetails object.
class YoutubeUpdateBroadcastCommand extends YtHelperCommand {
  @override
  String get description =>
      'Updates a broadcast. For example, you could modify the broadcast settings defined in the liveBroadcast resource\'s contentDetails object.';

  @override
  String get name => 'update';

  YoutubeUpdateBroadcastCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet,contentDetails,status',
        help:
            '''The part parameter serves two purposes in this operation. It identifies the properties that the write operation will set as well as the properties that the API response will include.

The part properties that you can include in the parameter value are id, snippet, contentDetails, and status.

Note that this method will override the existing values for all of the mutable properties that are contained in any parts that the parameter value specifies. For example, a broadcast's privacy status is defined in the status part. As such, if your request is updating a private or unlisted broadcast, and the request's part parameter value includes the status part, the broadcast's privacy setting will be updated to whatever value the request body specifies. If the request body does not specify a value, the existing privacy setting will be removed and the broadcast will revert to the default privacy setting.''',
      )
      ..addOption(
        'body',
        mandatory: true,
        help:
            'Provide a json formatted `liveBroadcast` resource [https://developers.google.com/youtube/v3/live/docs/liveBroadcasts#resource] in the request body or provide the `file name` of a json file that contains the `liveBroadcast` resource.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    final content = argResults!['body'] as String;

    // won't work with a file name that starts with the '{' character
    final isJson = content.trimLeft().startsWith('{');

    final body = isJson ? content : File(content).readAsStringSync();

    try {
      final liveBroadcastItem = await broadcast.update(
        body: json.decode(body),
        part: argResults!['part'],
      );

      print(liveBroadcastItem);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Binds a YouTube broadcast to a stream or removes an existing binding between
/// a broadcast and a stream. A broadcast can only be bound to one video stream,
/// though a video stream may be bound to more than one broadcast.
class YoutubeBindBroadcastCommand extends YtHelperCommand {
  @override
  String get description =>
      'Binds a YouTube broadcast to a stream or removes an existing binding between a broadcast and a stream. A broadcast can only be bound to one video stream, though a video stream may be bound to more than one broadcast.';

  @override
  String get name => 'bind';

  YoutubeBindBroadcastCommand() {
    argParser
      ..addOption(
        'id',
        mandatory: true,
        valueHelp: 'id',
        help:
            'The id parameter specifies the unique ID of the broadcast that is being bound to a video stream.',
      )
      ..addOption(
        'part',
        defaultsTo: 'id,snippet,contentDetails,status',
        help:
            'The part parameter specifies a comma-separated list of one or more liveBroadcast resource properties that the API response will include. The part names that you can include in the parameter value are id, snippet, contentDetails, and status.',
      )
      ..addOption(
        'stream-id',
        valueHelp: 'stream-id',
        help:
            'The streamId parameter specifies the unique ID of the video stream that is being bound to a broadcast. If this parameter is omitted, the API will remove any existing binding between the broadcast and a video stream.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final liveBroadcastItem = await broadcast.bind(
        id: argResults!['id'],
        part: argResults!['part'],
        streamId: argResults!['stream-id'],
      );

      print(liveBroadcastItem);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
