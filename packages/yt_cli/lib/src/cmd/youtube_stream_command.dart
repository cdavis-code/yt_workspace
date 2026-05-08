import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';
import 'youtube_helper_command.dart';

///A liveStream resource contains information about the video stream that you
///are transmitting to YouTube. The stream provides the content that will be
///broadcast to YouTube users. Once created, a liveStream resource can be bound
///to one or more liveBroadcast resources.
class YoutubeStreamCommand extends YtHelperCommand {
  @override
  String get description =>
      'A liveStream resource contains information about the video stream that you are transmitting to YouTube. The stream provides the content that will be broadcast to YouTube users. Once created, a liveStream resource can be bound to one or more liveBroadcast resources.';

  @override
  String get name => 'stream';

  YoutubeStreamCommand() {
    addSubcommand(YoutubeListStreamCommand());
    addSubcommand(YoutubeInsertStreamCommand());
    addSubcommand(YoutubeDeleteStreamCommand());
    addSubcommand(YoutubeUpdateStreamCommand());
  }
}

///Returns a list of video streams that match the API request parameters.
class YoutubeListStreamCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of video streams that match the API request parameters.';

  @override
  String get name => 'list';

  YoutubeListStreamCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'id,snippet,cdn,status',
        help:
            'The part parameter specifies a comma-separated list of one or more liveStream resource properties that the API response will include. The part names that you can include in the parameter value are id, snippet, cdn, and status.',
      )
      ..addOption(
        'id',
        valueHelp: 'id',
        help:
            'The id parameter specifies a comma-separated list of YouTube stream IDs that identify the streams being retrieved. In a liveStream resource, the id property specifies the stream\'s ID.',
      )
      ..addFlag(
        'mine',
        help:
            'This parameter can only be used in a properly authorized request. The mine parameter can be used to instruct the API to only return streams owned by the authenticated user. Set the parameter value to true to only retrieve your own streams.',
      )
      ..addOption(
        'max-results',
        defaultsTo: '5',
        valueHelp: 'number',
        help:
            'The maxResults parameter specifies the maximum number of items that should be returned in the result set. Acceptable values are 0 to 50, inclusive. The default value is 5.',
      )
      ..addOption(
        'page-token',
        valueHelp: 'token',
        help:
            'The pageToken parameter identifies a specific page in the result set that should be returned. In an API response, the nextPageToken and prevPageToken properties identify other pages that could be retrieved.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      LiveStreamListResponse liveStreamListResponse = await liveStream.list(
        part: argResults!['part'],
        id: argResults?['id'],
        mine: argResults?['mine'] ? true : null,
        maxResults: int.parse(argResults!['max-results']),
      );

      print(liveStreamListResponse);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

///Creates a video stream. The stream enables you to send your video to YouTube,
///which can then broadcast the video to your audience.
class YoutubeInsertStreamCommand extends YtHelperCommand {
  @override
  String get description =>
      'Creates a video stream. The stream enables you to send your video to YouTube, which can then broadcast the video to your audience.';

  @override
  String get name => 'insert';

  YoutubeInsertStreamCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'id,snippet,cdn,contentDetails,status',
        help:
            '''The part parameter serves two purposes in this operation. It identifies the properties that the write operation will set as well as the properties that the API response will include.''',
      )
      ..addOption(
        'body',
        mandatory: true,
        help:
            'Provide a liveBroadcast resource [https://developers.google.com/youtube/v3/live/docs/liveBroadcasts#resource] in the request body',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      LiveStreamItem liveStreamItem = await liveStream.insert(
        part: argResults!['part'],
        body: json.decode(argResults!['body']),
      );

      print(liveStreamItem);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

///Updates a video stream. If the properties that you want to change cannot be
///updated, then you need to create a new stream with the proper settings.
class YoutubeUpdateStreamCommand extends YtHelperCommand {
  @override
  String get description =>
      'Updates a video stream. If the properties that you want to change cannot be updated, then you need to create a new stream with the proper settings.';

  @override
  String get name => 'update';

  YoutubeUpdateStreamCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'id,snippet,cdn,status',
        help:
            '''The part parameter serves two purposes in this operation. It identifies the properties that the write operation will set as well as the properties that the API response will include.

The part properties that you can include in the parameter value are id, snippet, cdn, and status.

Note that this method will override the existing values for all of the mutable properties that are contained in any parts that the parameter value specifies. If the request body does not specify a value for a mutable property, the existing value for that property will be removed.''',
      )
      ..addOption(
        'body',
        mandatory: true,
        help:
            'Provide a liveBroadcast resource [https://developers.google.com/youtube/v3/live/docs/liveBroadcasts#resource] in the request body.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      LiveStreamItem liveStreamItem = await liveStream.insert(
        part: argResults!['part'],
        body: json.decode(argResults!['body']),
      );

      print(liveStreamItem);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

///Deletes a video stream.
class YoutubeDeleteStreamCommand extends YtHelperCommand {
  @override
  String get description => 'Deletes a video stream.';

  @override
  String get name => 'delete';

  YoutubeDeleteStreamCommand() {
    argParser.addOption(
      'id',
      mandatory: true,
      valueHelp: 'id',
      help:
          'The id parameter specifies the YouTube live stream ID for the resource that is being deleted.',
    );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      await liveStream.delete(id: argResults!['id']);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
