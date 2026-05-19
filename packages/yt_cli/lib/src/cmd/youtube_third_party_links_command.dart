import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';

import 'youtube_helper_command.dart';

/// Command group for the thirdPartyLinks resource.
///
/// A thirdPartyLink resource represents a link between a YouTube channel
/// or video and an external resource, such as a merchandising store.
class YoutubeThirdPartyLinksCommand extends Command<void> {
  @override
  String get description =>
      'A thirdPartyLink resource represents a link between a YouTube channel or video and an external resource.';

  @override
  String get name => 'third-party-links';

  YoutubeThirdPartyLinksCommand() {
    addSubcommand(YoutubeListThirdPartyLinksCommand());
    addSubcommand(YoutubeInsertThirdPartyLinksCommand());
    addSubcommand(YoutubeUpdateThirdPartyLinksCommand());
    addSubcommand(YoutubeDeleteThirdPartyLinksCommand());
  }
}

/// Returns a list of third-party links of the specified type.
class YoutubeListThirdPartyLinksCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of third-party links of the specified type.';

  @override
  String get name => 'list';

  YoutubeListThirdPartyLinksCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet,status',
        help:
            'Comma-separated list of thirdPartyLink resource parts. Valid values: snippet, status.',
      )
      ..addOption(
        'external-channel-id',
        valueHelp: 'channel id',
        help:
            'The externalChannelId parameter specifies the YouTube channel ID of the channel that contains the third-party links.',
      )
      ..addOption(
        'linking-token',
        valueHelp: 'token',
        help:
            'The linkingToken parameter identifies a unique resource string created when a third-party link is established.',
      )
      ..addOption(
        'type',
        valueHelp: 'type',
        help: 'The type parameter specifies the type of link being retrieved.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final response = await thirdPartyLinks.list(
        part: argResults!['part'],
        externalChannelId: argResults?['external-channel-id'],
        linkingToken: argResults?['linking-token'],
        type: argResults?['type'],
      );

      print(response);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Posts a third-party link to a YouTube channel.
class YoutubeInsertThirdPartyLinksCommand extends YtHelperCommand {
  @override
  String get description => 'Posts a third-party link to a YouTube channel.';

  @override
  String get name => 'insert';

  YoutubeInsertThirdPartyLinksCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet,status',
        help:
            'The part parameter specifies the thirdPartyLink resource parts that the write operation will set.',
      )
      ..addOption(
        'body',
        mandatory: true,
        help: 'A thirdPartyLink resource as a JSON string.',
      )
      ..addOption(
        'external-channel-id',
        valueHelp: 'channel id',
        help:
            'The externalChannelId parameter specifies the YouTube channel ID of the channel for the linked resource.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final result = await thirdPartyLinks.insert(
        body: json.decode(argResults!['body']),
        part: argResults!['part'],
        externalChannelId: argResults?['external-channel-id'],
      );

      print(result);

      close();
    } on FormatException catch (e) {
      throw UsageException(e.message, usage);
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Updates an existing third-party link.
class YoutubeUpdateThirdPartyLinksCommand extends YtHelperCommand {
  @override
  String get description => 'Updates an existing third-party link.';

  @override
  String get name => 'update';

  YoutubeUpdateThirdPartyLinksCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet,status',
        help:
            'The part parameter specifies the thirdPartyLink resource parts that the write operation will set.',
      )
      ..addOption(
        'body',
        mandatory: true,
        help: 'A thirdPartyLink resource as a JSON string.',
      )
      ..addOption(
        'external-channel-id',
        valueHelp: 'channel id',
        help:
            'The externalChannelId parameter specifies the YouTube channel ID of the channel for the linked resource.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final result = await thirdPartyLinks.update(
        body: json.decode(argResults!['body']),
        part: argResults!['part'],
        externalChannelId: argResults?['external-channel-id'],
      );

      print(result);

      close();
    } on FormatException catch (e) {
      throw UsageException(e.message, usage);
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Deletes a third-party link.
class YoutubeDeleteThirdPartyLinksCommand extends YtHelperCommand {
  @override
  String get description => 'Deletes a third-party link.';

  @override
  String get name => 'delete';

  YoutubeDeleteThirdPartyLinksCommand() {
    argParser
      ..addOption(
        'linking-token',
        mandatory: true,
        valueHelp: 'token',
        help:
            'The linkingToken parameter identifies the third-party link being deleted.',
      )
      ..addOption(
        'type',
        mandatory: true,
        valueHelp: 'type',
        help: 'The type parameter specifies the type of link being deleted.',
      )
      ..addOption(
        'part',
        help: 'Optional. The thirdPartyLink resource parts to include.',
      )
      ..addOption(
        'external-channel-id',
        valueHelp: 'channel id',
        help:
            'The externalChannelId parameter specifies the YouTube channel ID for the linked resource.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      await thirdPartyLinks.delete(
        linkingToken: argResults!['linking-token'],
        type: argResults!['type'],
        part: argResults?['part'],
        externalChannelId: argResults?['external-channel-id'],
      );

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
