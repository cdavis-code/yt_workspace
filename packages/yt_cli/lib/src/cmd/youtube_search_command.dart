import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';
import 'youtube_helper_command.dart';

///A search result contains information about a YouTube video, channel, or
///playlist that matches the search parameters specified in an API request.
///While a search result points to a uniquely identifiable resource, like a
///video, it does not have its own persistent data.
class YoutubeSearchCommand extends YtHelperCommand {
  @override
  String get description =>
      'A search result contains information about a YouTube video, channel, or playlist that matches the search parameters specified in an API request. While a search result points to a uniquely identifiable resource, like a video, it does not have its own persistent data.';

  @override
  String get name => 'search';

  YoutubeSearchCommand() {
    addSubcommand(YoutubeListSearchCommand());
  }
}

///Returns a collection of search results that match the query parameters
///specified in the API request. By default, a search result set identifies
///matching video, channel, and playlist resources, but you can also configure
///queries to only retrieve a specific type of resource.
class YoutubeListSearchCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a collection of search results that match the query parameters specified in the API request. By default, a search result set identifies matching video, channel, and playlist resources, but you can also configure queries to only retrieve a specific type of resource.';

  @override
  String get name => 'list';

  YoutubeListSearchCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet',
        help:
            'The part parameter specifies a comma-separated list of one or more search resource properties that the API response will include. Set the parameter value to snippet.',
      )
      ..addOption(
        'for-mine',
        help:
            'This parameter can only be used in a properly authorized request. The forMine parameter restricts the search to only retrieve videos owned by the authenticated user. If you set this parameter to true, then the type parameter\'s value must also be set to video. In addition, none of the following other parameters can be set in the same request: videoDefinition, videoDimension, videoDuration, videoLicense, videoEmbeddable, videoSyndicated, videoType.',
      )
      ..addOption(
        'related-to-video-id',
        valueHelp: 'YouTube video id',
        help:
            '''The relatedToVideoId parameter retrieves a list of videos that are related to the video that the parameter value identifies. The parameter value must be set to a YouTube video ID and, if you are using this parameter, the type parameter must be set to video.

Note that if the relatedToVideoId parameter is set, the only other supported parameters are part, maxResults, pageToken, regionCode, relevanceLanguage, safeSearch, type (which must be set to video), and fields.''',
      )
      ..addOption(
        'channel-id',
        help:
            '''The channelId parameter indicates that the API response should only contain resources created by the channel.

Note: Search results are constrained to a maximum of 500 videos if your request specifies a value for the channelId parameter and sets the type parameter value to video, but it does not also set one of the forContentOwner, forDeveloper, or forMine filters.''',
        valueHelp: 'YouTube channel id',
      )
      ..addOption(
        'channel-type',
        valueHelp: 'Channel type',
        allowed: ['any', 'show'],
        allowedHelp: {
          'any': 'Return all channels.',
          'show': 'Only retrieve shows.',
        },
        help:
            'The channelType parameter lets you restrict a search to a particular type of channel.',
      )
      ..addOption(
        'event-type',
        valueHelp: 'Event type',
        allowed: ['completed', 'live', 'upcoming'],
        allowedHelp: {
          'completed': 'Only include completed broadcasts.',
          'live': 'Only include active broadcasts.',
          'upcoming': 'Only include upcoming broadcasts.',
        },
        help:
            'The eventType parameter restricts a search to broadcast events. If you specify a value for this parameter, you must also set the type parameter\'s value to video.',
      )
      ..addOption(
        'max-results',
        defaultsTo: '5',
        valueHelp: 'number',
        help:
            'The maxResults parameter specifies the maximum number of items that should be returned in the result set. Acceptable values are 0 to 50, inclusive. The default value is 5.',
      )
      ..addOption(
        'order',
        allowed: [
          'date',
          'rating',
          'relevance',
          'title',
          'videoCount',
          'viewCount',
        ],
        allowedHelp: {
          'date':
              'Resources are sorted in reverse chronological order based on the date they were created.',
          'rating': 'Resources are sorted from highest to lowest rating.',
          'relevance':
              'Resources are sorted based on their relevance to the search query. This is the default value for this parameter.',
          'title': 'Resources are sorted alphabetically by title.',
          'videoCount':
              'Channels are sorted in descending order of their number of uploaded videos.',
          'viewCount':
              'Resources are sorted from highest to lowest number of views. For live broadcasts, videos are sorted by number of concurrent viewers while the broadcasts are ongoing.',
        },
      )
      ..addOption(
        'page-token',
        valueHelp: 'token',
        help:
            'The pageToken parameter identifies a specific page in the result set that should be returned. In an API response, the nextPageToken and prevPageToken properties identify other pages that could be retrieved.',
      )
      ..addOption(
        'published-after',
        valueHelp: 'date',
        help:
            'The publishedAfter parameter indicates that the API response should only contain resources created at or after the specified time. The value is an RFC 3339 formatted date-time value (1970-01-01T00:00:00Z).',
      )
      ..addOption(
        'published-before',
        valueHelp: 'date',
        help:
            'The publishedBefore parameter indicates that the API response should only contain resources created before or at the specified time. The value is an RFC 3339 formatted date-time value (1970-01-01T00:00:00Z).',
      )
      ..addOption(
        'q',
        valueHelp: 'search term',
        help: '''The q parameter specifies the query term to search for.

Your request can also use the Boolean NOT (-) and OR (|) operators to exclude videos or to find videos that are associated with one of several search terms. For example, to search for videos matching either "boating" or "sailing", set the q parameter value to boating|sailing. Similarly, to search for videos matching either "boating" or "sailing" but not "fishing", set the q parameter value to boating|sailing -fishing. Note that the pipe character must be URL-escaped when it is sent in your API request. The URL-escaped value for the pipe character is %7C.''',
      )
      ..addOption(
        'safe-search',
        help:
            'The safeSearch parameter indicates whether the search results should include restricted content as well as standard content.',
        allowed: ['moderate', 'none', 'strict'],
        allowedHelp: {
          'moderate':
              'YouTube will filter some content from search results and, at the least, will filter content that is restricted in your locale. Based on their content, search results could be removed from search results or demoted in search results. This is the default parameter value.',
          'none': 'YouTube will not filter the search result set.',
          'strict':
              'YouTube will try to exclude all restricted content from the search result set. Based on their content, search results could be removed from search results or demoted in search results.',
        },
      )
      ..addOption(
        'type',
        defaultsTo: 'video',
        help:
            'The type parameter restricts a search query to only retrieve a particular type of resource. The value is a comma-separated list of resource types. The default value is video,channel,playlist.',
      )
      ..addOption(
        'video-caption',
        help:
            'The videoCaption parameter indicates whether the API should filter video search results based on whether they have captions. If you specify a value for this parameter, you must also set the type parameter\'s value to video.',
        allowed: ['any', 'closedCaption', 'none'],
        allowedHelp: {
          'any': 'Do not filter results based on caption availability.',
          'closedCaption': 'Only include videos that have captions.',
          'none': 'Only include videos that do not have captions.',
        },
      )
      ..addOption(
        'video-category-id',
        help:
            'The videoCategoryId parameter filters video search results based on their category. If you specify a value for this parameter, you must also set the type parameter\'s value to video.',
      )
      ..addOption(
        'video-definition',
        help:
            'The videoDefinition parameter lets you restrict a search to only include either high definition (HD) or standard definition (SD) videos. HD videos are available for playback in at least 720p, though higher resolutions, like 1080p, might also be available. If you specify a value for this parameter, you must also set the type parameter\'s value to video.',
        allowed: ['any', 'high', 'standard'],
        allowedHelp: {
          'any': 'Return all videos, regardless of their resolution.',
          'high': 'Only retrieve HD videos.',
          'standard': 'Only retrieve videos in standard definition.',
        },
      )
      ..addOption(
        'video-dimension',
        help:
            'The videoDimension parameter lets you restrict a search to only retrieve 2D or 3D videos. If you specify a value for this parameter, you must also set the type parameter\'s value to video.',
        allowed: ['2d', '3d', 'any'],
        allowedHelp: {
          '2d': 'Restrict search results to exclude 3D videos.',
          '3d': 'Restrict search results to only include 3D videos.',
          'any':
              'Include both 3D and non-3D videos in returned results. This is the default value.',
        },
      )
      ..addOption(
        'video-duration',
        help:
            'The videoDuration parameter filters video search results based on their duration. If you specify a value for this parameter, you must also set the type parameter\'s value to video.',
        allowed: ['any', 'long', 'medium', 'short'],
        allowedHelp: {
          'any':
              'Do not filter video search results based on their duration. This is the default value.',
          'long': 'Only include videos longer than 20 minutes.',
          'medium':
              'Only include videos that are between four and 20 minutes long (inclusive).',
          'short': 'Only include videos that are less than four minutes long.',
        },
      )
      ..addOption(
        'video-embeddable',
        help:
            'The videoEmbeddable parameter lets you to restrict a search to only videos that can be embedded into a webpage. If you specify a value for this parameter, you must also set the type parameter\'s value to video.',
        allowed: ['any', 'true'],
        allowedHelp: {
          'any': 'Return all videos, embeddable or not.',
          'true': 'Only retrieve embeddable videos.',
        },
      )
      ..addOption(
        'video-license',
        help:
            'The videoLicense parameter filters search results to only include videos with a particular license. YouTube lets video uploaders choose to attach either the Creative Commons license or the standard YouTube license to each of their videos. If you specify a value for this parameter, you must also set the type parameter\'s value to video.',
        allowed: ['any', 'creativeCommon', 'youtube'],
        allowedHelp: {
          'any':
              'Return all videos, regardless of which license they have, that match the query parameters.',
          'creativeCommon':
              'Only return videos that have a Creative Commons license. Users can reuse videos with this license in other videos that they create.',
          'youtube':
              'Only return videos that have the standard YouTube license.',
        },
      )
      ..addOption(
        'video-syndicated',
        help:
            'The videoSyndicated parameter lets you to restrict a search to only videos that can be played outside youtube.com. If you specify a value for this parameter, you must also set the type parameter\'s value to video.',
        allowed: ['any', 'true'],
        allowedHelp: {
          'any': 'Return all videos, syndicated or not.',
          'true': 'Only retrieve syndicated videos.',
        },
      )
      ..addOption(
        'video-type',
        valueHelp: 'type',
        help:
            'The videoType parameter lets you restrict a search to a particular type of videos. If you specify a value for this parameter, you must also set the type parameter\'s value to video.',
        allowed: ['any', 'episode', 'movie'],
        allowedHelp: {
          'any': 'Return all videos.',
          'episode': 'Only retrieve episodes of shows.',
          'movie': 'Only retrieve movies.',
        },
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final searchListResponse = await search.list(
        part: argResults!['part'],
        channelId: argResults?['channel-id'],
        channelType: argResults?['channel-type'],
        eventType: argResults?['event-type'],
        forMine:
            argResults?['for-mine'] != null && argResults?['for-mine'] == 'true'
            ? true
            : null,
        maxResults: int.parse(argResults!['max-results']),
        order: argResults?['order'],
        pageToken: argResults?['page-token'],
        publishedAfter: argResults?['published-after'],
        publishedBefore: argResults?['published-before'],
        q: argResults?['q'],
        safeSearch: argResults?['safe-search'],
        type: argResults!['type'],
        videoCaption: argResults?['video-caption'],
        videoCategoryId: argResults?['video-category-id'],
        videoDefinition: argResults?['video-definition'],
        videoDimension: argResults?['video-dimension'],
        videoDuration: argResults?['video-duration'],
        videoEmbeddable: argResults?['video-embeddable'],
        videoLicense: argResults?['video-license'],
        videoSyndicated: argResults?['video-syndicated'],
        videoType: argResults?['video-type'],
      );

      print(searchListResponse);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
