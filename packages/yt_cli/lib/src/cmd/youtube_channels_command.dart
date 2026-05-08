import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';
import 'youtube_helper_command.dart';

///A channel resource contains information about a YouTube channel.
class YoutubeChannelsCommand extends YtHelperCommand {
  @override
  String get description =>
      'A channel resource contains information about a YouTube channel.';

  @override
  String get name => 'channels';

  YoutubeChannelsCommand() {
    addSubcommand(YoutubeListChannelsCommand());
    addSubcommand(YoutubeUpdateChannelsCommand());
  }
}

///Returns a collection of zero or more channel resources that match the request
///criteria.
class YoutubeListChannelsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a collection of zero or more channel resources that match the request criteria.';

  @override
  String get name => 'list';

  YoutubeListChannelsCommand() {
    argParser
      ..addOption(
        'part',
        mandatory: true,
        help:
            '''The part parameter specifies a comma-separated list of one or more channel resource properties that the API response will include.

If the parameter identifies a property that contains child properties, the child properties will be included in the response. For example, in a channel resource, the contentDetails property contains other properties, such as the uploads properties. As such, if you set part=contentDetails, the API response will also contain all of those nested properties.

The following list contains the part names that you can include in the parameter value:
auditDetails, brandingSettings, contentDetails, contentOwnerDetails, id, localizations, snippet, statistics, status, topicDetails''',
      )
      ..addOption(
        'for-username',
        help:
            'The forUsername parameter specifies a YouTube username, thereby requesting the channel associated with that username.',
        valueHelp: 'YouTube username',
      )
      ..addOption(
        'id',
        valueHelp: 'id',
        help:
            'The id parameter specifies a comma-separated list of the YouTube channel ID(s) for the resource(s) that are being retrieved. In a channel resource, the id property specifies the channel\'s YouTube channel ID.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final channelResponse = await channels.list(
        part: argResults!['part'],
        forUsername: argResults?['for-username'],
        id: argResults?['id'],
      );

      print(channelResponse);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

///Updates a channel's metadata. Note that this method currently only supports
///updates to the channel resource's brandingSettings, invideoPromotion, and
///localizations objects and their child properties.
class YoutubeUpdateChannelsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Updates a channel\'s metadata. Note that this method currently only supports updates to the channel resource\'s brandingSettings, invideoPromotion, and localizations objects and their child properties.';

  @override
  String get name => 'update';

  YoutubeUpdateChannelsCommand() {
    argParser
      ..addOption(
        'part',
        mandatory: true,
        help:
            '''The part parameter serves two purposes in this operation. It identifies the properties that the write operation will set as well as the properties that the API response will include.

The API currently only allows the parameter value to be set to either brandingSettings, invideoPromotion, or localizations. (You can only update any one of those parts with a single request.)

Note that this method overrides the existing values for all of the mutable properties that are contained in the part that the parameter value specifies.''',
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
      final channelItem = await channels.update(
        body: json.decode(argResults!['body']),
        part: argResults!['part'],
      );

      print(channelItem);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
