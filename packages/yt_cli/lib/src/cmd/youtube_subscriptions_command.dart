import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';
import 'youtube_helper_command.dart';

/// A [Subscription] resource contains information about a YouTube user
/// subscription. A subscription notifies a user when new videos are added to a
/// channel or when another user takes one of several actions on YouTube, such
/// as uploading a video, rating a video, or commenting on a video.
class YoutubeSubscriptionsCommand extends YtHelperCommand {
  @override
  String get description =>
      'A subscription resource contains information about a YouTube user subscription. A subscription notifies a user when new videos are added to a channel or when another user takes one of several actions on YouTube, such as uploading a video, rating a video, or commenting on a video.';

  @override
  String get name => 'subscriptions';

  YoutubeSubscriptionsCommand() {
    addSubcommand(YoutubeListSubscriptionsCommand());
    addSubcommand(YoutubeInsertSubscriptionsCommand());
    addSubcommand(YoutubeDeleteSubscriptionsCommand());
  }
}

/// Returns subscription resources that match the API request criteria.
class YoutubeListSubscriptionsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns subscription resources that match the API request criteria.';

  @override
  String get name => 'list';

  YoutubeListSubscriptionsCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'id,snippet,contentDetails,subscriberSnippet',
        help:
            '''The part parameter specifies a comma-separated list of one or more subscription resource properties that the API response will include.

If the parameter identifies a property that contains child properties, the child properties will be included in the response. For example, in a subscription resource, the snippet property contains other properties, such as a display title for the subscription. If you set part=snippet, the API response will also contain all of those nested properties.

The following list contains the part names that you can include in the parameter value:
- contentDetails
- id
- snippet
- subscriberSnippet''',
      )
      ..addOption(
        'channel-id',
        help:
            'The channelId parameter specifies a YouTube channel ID. The API will only return that channel\'s subscriptions.',
        valueHelp: 'YouTube username',
      )
      ..addOption(
        'id',
        valueHelp: 'id',
        help:
            'The id parameter specifies a comma-separated list of the YouTube subscription ID(s) for the resource(s) that are being retrieved. In a subscription resource, the id property specifies the YouTube subscription ID.',
      )
      ..addFlag(
        'mine',
        defaultsTo: null,
        help:
            'This parameter can only be used in a properly authorized request. Set this parameter\'s value to true to retrieve a feed of the authenticated user\'s subscriptions.',
      )
      ..addFlag(
        'my-recent-subscribers',
        defaultsTo: null,
        help:
            '''This parameter can only be used in a properly authorized request. Set this parameter's value to true to retrieve a feed of the subscribers of the authenticated user in reverse chronological order (newest first).

Note that the maximum number of subscribers returned through this API might be limited.''',
      )
      ..addFlag(
        'my-subscribers',
        defaultsTo: null,
        help:
            '''This parameter can only be used in a properly authorized request. Set this parameter's value to true to retrieve a feed of the subscribers of the authenticated user in no particular order. Note that the maximum number of subscribers returned through this API might be limited.''',
      )
      ..addOption(
        'for-channel-id',
        help:
            'The forChannelId parameter specifies a comma-separated list of channel IDs. The API response will then only contain subscriptions matching those channels.',
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
        defaultsTo: 'relevance',
        allowed: ['alphabetical', 'relevance', 'unread'],
        help:
            'The order parameter specifies the method that will be used to sort resources in the API response. The default value is SUBSCRIPTION_ORDER_RELEVANCE.',
        allowedHelp: {
          'alphabetical': 'Sort alphabetically.',
          'relevance': 'Sort by relevance.',
          'unread': 'Sort by order of activity.',
        },
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final subscriptionsResponse = await subscriptions.list(
        part: argResults!['part'],
        channelId: argResults?['channel-id'],
        id: argResults?['id'],
        mine: argResults?['mine'] != null ? argResults!['mine'] : null,
        myRecentSubscribers: argResults?['my-recent-subscribers'] != null
            ? argResults!['my-recent-subscribers']
            : null,
        mySubscribers: argResults?['my-subscribers'] != null
            ? argResults!['my-subscribers']
            : null,
        forChannelId: argResults?['for-channel-id'],
        maxResults: int.parse(argResults!['max-results']),
        order: argResults!['order'],
      );

      print(subscriptionsResponse);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Adds a subscription for the authenticated user's channel.
class YoutubeInsertSubscriptionsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Adds a subscription for the authenticated user\'s channel.';

  @override
  String get name => 'insert';

  YoutubeInsertSubscriptionsCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet',
        help:
            '''The part parameter specifies a comma-separated list of one or more subscription resource properties that the API response will include.

If the parameter identifies a property that contains child properties, the child properties will be included in the response. For example, in a subscription resource, the snippet property contains other properties, such as a display title for the subscription. If you set part=snippet, the API response will also contain all of those nested properties.

The following list contains the part names that you can include in the parameter value:
- contentDetails
- id
- snippet
- subscriberSnippet''',
      )
      ..addOption(
        'kind',
        defaultsTo: 'youtube#channel',
        valueHelp: 'string',
        help: 'The type of the API resource.',
      )
      ..addOption(
        'channel-id',
        mandatory: true,
        valueHelp: 'string',
        help:
            'The value that YouTube uses to uniquely identify the channel that the user subscribed to.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final subscription = await subscriptions.insert(
        part: argResults!['part'],
        body: <String, dynamic>{
          'snippet': {
            'resourceId': {
              'kind': argResults!['kind'],
              'channelId': argResults!['channel-id'],
            },
          },
        },
      );

      print(subscription);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Deletes a subscription.
class YoutubeDeleteSubscriptionsCommand extends YtHelperCommand {
  @override
  String get description => 'Deletes a subscription.';

  @override
  String get name => 'delete';

  YoutubeDeleteSubscriptionsCommand() {
    argParser.addOption(
      'id',
      mandatory: true,
      valueHelp: 'resource id',
      help:
          'The id parameter specifies the YouTube subscription ID for the resource that is being deleted. In a subscription resource, the id property specifies the YouTube subscription ID.',
    );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      await subscriptions.delete(id: argResults!['id']);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
