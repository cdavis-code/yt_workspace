import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:universal_io/io.dart';
import 'package:yt/yt.dart';
import 'youtube_helper_command.dart';

/// A video resource represents a YouTube video.
class YoutubeVideosCommand extends YtHelperCommand {
  @override
  String get description => 'A video resource represents a YouTube video.';

  @override
  String get name => 'videos';

  YoutubeVideosCommand() {
    addSubcommand(YoutubeRateVideosCommand());
    addSubcommand(YoutubeListVideosCommand());
    addSubcommand(YoutubeInsertVideosCommand());
    addSubcommand(YoutubeDeleteVideosCommand());
    addSubcommand(YoutubeUpdateVideosCommand());
  }
}

/// Add a like or dislike rating to a video or remove a rating from a video.
class YoutubeRateVideosCommand extends YtHelperCommand {
  @override
  String get description =>
      'Add a like or dislike rating to a video or remove a rating from a video.';

  @override
  String get name => 'rate';

  YoutubeRateVideosCommand() {
    argParser
      ..addOption(
        'id',
        mandatory: true,
        valueHelp: 'id',
        help:
            'The id parameter specifies the YouTube video ID of the video that is being rated or having its rating removed.',
      )
      ..addOption(
        'rating',
        mandatory: true,
        valueHelp: 'rating',
        allowed: ['dislike', 'like', 'none'],
        allowedHelp: {
          'dislike': 'Records that the authenticated user disliked the video.',
          'like': 'Records that the authenticated user liked the video.',
          'none':
              'Removes any rating that the authenticated user had previously set for the video.',
        },
        help: 'Specifies the rating to record.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      await videos.rate(id: argResults!['id'], rating: argResults!['rating']);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Returns a list of videos that match the API request parameters.
class YoutubeListVideosCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of videos that match the API request parameters.';

  @override
  String get name => 'list';

  YoutubeListVideosCommand() {
    argParser
      ..addOption(
        'part',
        valueHelp: 'list of parts',
        defaultsTo: 'snippet',
        help:
            '''The part parameter specifies a comma-separated list of one or more video resource properties that the API response will include.

If the parameter identifies a property that contains child properties, the child properties will be included in the response. For example, in a video resource, the snippet property contains the channelId, title, description, tags, and categoryId properties. As such, if you set part=snippet, the API response will contain all of those properties.

The following list contains the part names that you can include in the parameter value:
contentDetails, fileDetails, id, liveStreamingDetails, localizations, player, processingDetails, recordingDetails, snippet, statistics, status, suggestions, topicDetails''',
      )
      ..addOption(
        'chart',
        allowed: ['mostPopular'],
        help:
            'The chart parameter identifies the chart that you want to retrieve.',
        allowedHelp: {
          'mostPopular':
              'Return the most popular videos for the specified content region and video category.',
        },
      )
      ..addOption(
        'id',
        valueHelp: 'id',
        help:
            'The id parameter specifies a comma-separated list of the YouTube video ID(s) for the resource(s) that are being retrieved. In a video resource, the id property specifies the video\'s ID.',
      )
      ..addOption(
        'my-rating',
        allowed: ['dislike', 'like'],
        help:
            'This parameter can only be used in a properly authorized request. Set this parameter\'s value to like or dislike to instruct the API to only return videos liked or disliked by the authenticated user.',
        allowedHelp: {
          'dislike': 'Returns only videos disliked by the authenticated user.',
          'like': 'Returns only video liked by the authenticated user.',
        },
      )
      ..addOption(
        'hl',
        help:
            '''The hl parameter instructs the API to retrieve localized resource metadata for a specific application language that the YouTube website supports. The parameter value must be a language code included in the list returned by the i18nLanguages.list method.

If localized resource details are available in that language, the resource's snippet.localized object will contain the localized values. However, if localized details are not available, the snippet.localized object will contain resource details in the resource's default language.''',
      )
      ..addOption(
        'max-height',
        valueHelp: 'number',
        help:
            'The maxHeight parameter specifies the maximum height of the embedded player returned in the player.embedHtml property. You can use this parameter to specify that instead of the default dimensions, the embed code should use a height appropriate for your application layout. If the maxWidth parameter is also provided, the player may be shorter than the maxHeight in order to not violate the maximum width. Acceptable values are 72 to 8192, inclusive.',
      )
      ..addOption(
        'max-results',
        defaultsTo: '5',
        valueHelp: 'number',
        help:
            '''The maxResults parameter specifies the maximum number of items that should be returned in the result set.

Note: This parameter is supported for use in conjunction with the myRating parameter, but it is not supported for use in conjunction with the id parameter. Acceptable values are 1 to 50, inclusive. The default value is 5.''',
      )
      ..addOption(
        'max-width',
        valueHelp: 'number',
        help:
            'The maxWidth parameter specifies the maximum width of the embedded player returned in the player.embedHtml property. You can use this parameter to specify that instead of the default dimensions, the embed code should use a width appropriate for your application layout.  If the maxHeight parameter is also provided, the player may be narrower than maxWidth in order to not violate the maximum height. Acceptable values are 72 to 8192, inclusive.',
      )
      ..addOption(
        'page-token',
        valueHelp: 'token',
        help:
            '''The pageToken parameter identifies a specific page in the result set that should be returned. In an API response, the nextPageToken and prevPageToken properties identify other pages that could be retrieved.

Note: This parameter is supported for use in conjunction with the myRating parameter, but it is not supported for use in conjunction with the id parameter.''',
      )
      ..addOption(
        'region-code',
        valueHelp: 'code',
        help:
            'The regionCode parameter instructs the API to select a video chart available in the specified region. This parameter can only be used in conjunction with the chart parameter. The parameter value is an ISO 3166-1 alpha-2 country code.',
      )
      ..addOption(
        'video-category-id',
        defaultsTo: '0',
        help:
            'The videoCategoryId parameter identifies the video category for which the chart should be retrieved. This parameter can only be used in conjunction with the chart parameter. By default, charts are not restricted to a particular category.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    int? maxHeight;
    int? maxWidth;

    if (argResults?['max-height'] != null) {
      maxHeight = int.parse(argResults!['max-height']);
    }

    if (argResults?['max-width'] != null) {
      maxWidth = int.parse(argResults!['max-width']);
    }

    try {
      final videoListResponse = await videos.list(
        part: argResults!['part'],
        chart: argResults?['chart'],
        id: argResults?['id'],
        myRating: argResults?['my-rating'],
        hl: argResults?['hl'],
        maxHeight: maxHeight,
        maxResults: int.parse(argResults!['max-results']),
        maxWidth: maxWidth,
        pageToken: argResults?['page-token'],
        regionCode: argResults?['region-code'],
        videoCategoryId: argResults?['video-category-id'],
      );

      print(videoListResponse);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Uploads a video to YouTube and optionally sets the video's metadata.
class YoutubeInsertVideosCommand extends YtHelperCommand {
  @override
  String get description =>
      'Uploads a video to YouTube and optionally sets the video\'s metadata.';

  @override
  String get name => 'insert';

  YoutubeInsertVideosCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet,contentDetails,status',
        help:
            '''The part parameter serves two purposes in this operation. It identifies the properties that the write operation will set as well as the properties that the API response will include.

Note that not all parts contain properties that can be set when inserting or updating a video. For example, the statistics object encapsulates statistics that YouTube calculates for a video and does not contain values that you can set or modify. If the parameter value specifies a part that does not contain mutable values, that part will still be included in the API response.

The following list contains the part names that you can include in the parameter value:
contentDetails, fileDetails, id, liveStreamingDetails, localizations, player, processingDetails, recordingDetails, snippet, statistics, status, suggestions, topicDetails''',
      )
      ..addOption(
        'notify-subscribers',
        mandatory: true,
        valueHelp: 'bool',
        help:
            'The notifySubscribers parameter indicates whether YouTube should send a notification about the new video to users who subscribe to the video\'s channel. A parameter value of True indicates that subscribers will be notified of newly uploaded videos. However, a channel owner who is uploading many videos might prefer to set the value to False to avoid sending a notification about each new video to the channel\'s subscribers. The default value is True.',
      )
      ..addOption(
        'video-file',
        mandatory: true,
        help: '''Uploaded files must conform to these constraints:

Maximum file size: 128GB
Accepted Media MIME types: video/*, application/octet-stream''',
      )
      ..addOption(
        'body',
        mandatory: true,
        help:
            'Provide a video resource [https://developers.google.com/youtube/v3/docs/videos#resource] in the request body.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final liveBroadcastItem = await videos.insert(
        videoFile: File(argResults!['video-file']),
        body: json.decode(argResults!['body']),
        part: argResults!['part'],
      );

      print(liveBroadcastItem);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Deletes a YouTube video.
class YoutubeDeleteVideosCommand extends YtHelperCommand {
  @override
  String get description => 'Deletes a YouTube video.';

  @override
  String get name => 'delete';

  YoutubeDeleteVideosCommand() {
    argParser.addOption(
      'id',
      mandatory: true,
      valueHelp: 'id',
      help:
          'The id parameter specifies the YouTube video ID for the resource that is being deleted. In a video resource, the id property specifies the video\'s ID.',
    );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      await videos.delete(id: argResults!['id']);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Updates a video's metadata.
class YoutubeUpdateVideosCommand extends YtHelperCommand {
  @override
  String get description => 'Updates a video\'s metadata.';

  @override
  String get name => 'update';

  YoutubeUpdateVideosCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet,contentDetails,status',
        help:
            '''The part parameter serves two purposes in this operation. It identifies the properties that the write operation will set as well as the properties that the API response will include.

Note that this method will override the existing values for all of the mutable properties that are contained in any parts that the parameter value specifies. For example, a video's privacy setting is contained in the status part. As such, if your request is updating a private video, and the request's part parameter value includes the status part, the video's privacy setting will be updated to whatever value the request body specifies. If the request body does not specify a value, the existing privacy setting will be removed and the video will revert to the default privacy setting.

In addition, not all parts contain properties that can be set when inserting or updating a video. For example, the statistics object encapsulates statistics that YouTube calculates for a video and does not contain values that you can set or modify. If the parameter value specifies a part that does not contain mutable values, that part will still be included in the API response.

The following list contains the part names that you can include in the parameter value:
contentDetails, fileDetails, id, liveStreamingDetails, localizations, player, processingDetails, recordingDetails, snippet, statistics, status, suggestions, topicDetails''',
      )
      ..addOption(
        'body',
        mandatory: true,
        help:
            'Provide a video resource [https://developers.google.com/youtube/v3/docs/videos#resource] in the request body.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final videoItem = await videos.update(
        body: json.decode(argResults!['body']),
        part: argResults!['part'],
      );

      print(videoItem);
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Binds a YouTube broadcast to a stream or removes an existing binding between
/// a broadcast and a stream. A broadcast can only be bound to one video stream,
/// though a video stream may be bound to more than one broadcast.
class YoutubeGetRatingVideosCommand extends YtHelperCommand {
  @override
  String get description =>
      'Binds a YouTube broadcast to a stream or removes an existing binding between a broadcast and a stream. A broadcast can only be bound to one video stream, though a video stream may be bound to more than one broadcast.';

  @override
  String get name => 'bind';

  YoutubeGetRatingVideosCommand() {
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
