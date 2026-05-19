import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';

import 'youtube_helper_command.dart';

/// Command group for the channelSections resource.
///
/// A channelSection resource represents a section of a channel's main page.
/// Channel owners can use channel sections to spotlight specific playlists,
/// videos, or channels.
class YoutubeChannelSectionsCommand extends Command<void> {
  @override
  String get description =>
      'A channelSection resource represents a section of a channel\'s main page that spotlights specific playlists, videos, or channels.';

  @override
  String get name => 'channel-sections';

  YoutubeChannelSectionsCommand() {
    addSubcommand(YoutubeListChannelSectionsCommand());
    addSubcommand(YoutubeInsertChannelSectionsCommand());
    addSubcommand(YoutubeUpdateChannelSectionsCommand());
    addSubcommand(YoutubeDeleteChannelSectionsCommand());
  }
}

/// Returns a list of channelSection resources that match the API request
/// criteria.
class YoutubeListChannelSectionsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of channelSection resources that match the API request criteria.';

  @override
  String get name => 'list';

  YoutubeListChannelSectionsCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet',
        help:
            'Comma-separated list of channelSection resource properties: contentDetails, id, localizations, snippet.',
      )
      ..addOption(
        'channel-id',
        valueHelp: 'channel id',
        help:
            'The channelId parameter specifies a YouTube channel ID. The API will only return that channel\'s sections.',
      )
      ..addOption(
        'id',
        valueHelp: 'id',
        help:
            'The id parameter specifies a comma-separated list of IDs that uniquely identify the channelSection resources being retrieved.',
      )
      ..addFlag(
        'mine',
        negatable: false,
        help:
            'Set this parameter to true to retrieve a feed of the authenticated user\'s channel sections.',
      )
      ..addOption(
        'hl',
        valueHelp: 'language',
        help:
            'The hl parameter instructs the API to retrieve localized resource metadata.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final response = await channelSections.list(
        part: argResults!['part'],
        channelId: argResults?['channel-id'],
        id: argResults?['id'],
        mine: (argResults?['mine'] as bool? ?? false) ? true : null,
        hl: argResults?['hl'],
      );

      print(response);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Adds a channel section to the authenticated user's channel.
class YoutubeInsertChannelSectionsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Adds a channel section to the authenticated user\'s channel.';

  @override
  String get name => 'insert';

  YoutubeInsertChannelSectionsCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet',
        help:
            'The part parameter identifies the channelSection resource properties that the write operation will set.',
      )
      ..addOption(
        'body',
        mandatory: true,
        help: 'A channelSection resource as a JSON string.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final result = await channelSections.insert(
        body: json.decode(argResults!['body']),
        part: argResults!['part'],
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

/// Updates a channel section.
class YoutubeUpdateChannelSectionsCommand extends YtHelperCommand {
  @override
  String get description => 'Updates a channel section.';

  @override
  String get name => 'update';

  YoutubeUpdateChannelSectionsCommand() {
    argParser
      ..addOption(
        'part',
        mandatory: true,
        help:
            'The part parameter identifies the channelSection resource properties that the write operation will set.',
      )
      ..addOption(
        'body',
        mandatory: true,
        help: 'A channelSection resource as a JSON string.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final result = await channelSections.update(
        body: json.decode(argResults!['body']),
        part: argResults!['part'],
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

/// Deletes a channel section.
class YoutubeDeleteChannelSectionsCommand extends YtHelperCommand {
  @override
  String get description => 'Deletes a channel section.';

  @override
  String get name => 'delete';

  YoutubeDeleteChannelSectionsCommand() {
    argParser.addOption(
      'id',
      mandatory: true,
      valueHelp: 'id',
      help:
          'The id parameter specifies the YouTube channelSection ID of the section being deleted.',
    );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      await channelSections.delete(id: argResults!['id']);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
