import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';

import 'youtube_helper_command.dart';

/// Command group for the playlistItems resource.
///
/// A playlistItem resource identifies another resource, such as a video, that
/// is included in a playlist.
class YoutubePlaylistItemsCommand extends Command<void> {
  @override
  String get description =>
      'A playlistItem resource identifies another resource, such as a video, that is included in a playlist.';

  @override
  String get name => 'playlist-items';

  YoutubePlaylistItemsCommand() {
    addSubcommand(YoutubeListPlaylistItemsCommand());
    addSubcommand(YoutubeInsertPlaylistItemsCommand());
    addSubcommand(YoutubeUpdatePlaylistItemsCommand());
    addSubcommand(YoutubeDeletePlaylistItemsCommand());
  }
}

/// Returns a collection of playlist items that match the API request
/// parameters.
class YoutubeListPlaylistItemsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a collection of playlist items that match the API request parameters.';

  @override
  String get name => 'list';

  YoutubeListPlaylistItemsCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet,contentDetails',
        help:
            'Comma-separated list of one or more playlistItem resource properties: contentDetails, id, snippet, status.',
      )
      ..addOption(
        'playlist-id',
        valueHelp: 'playlist id',
        help:
            'The playlistId parameter specifies the unique ID of the playlist for which you want to retrieve playlist items.',
      )
      ..addOption(
        'id',
        valueHelp: 'id',
        help:
            'The id parameter specifies a comma-separated list of one or more unique playlist item IDs.',
      )
      ..addOption(
        'video-id',
        valueHelp: 'video id',
        help:
            'The videoId parameter specifies that the request should return only the playlist items that contain the specified video.',
      )
      ..addOption(
        'max-results',
        defaultsTo: '5',
        valueHelp: 'number',
        help: 'Maximum number of items returned (0-50, default 5).',
      )
      ..addOption(
        'page-token',
        valueHelp: 'token',
        help:
            'The pageToken parameter identifies a specific page in the result set.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final response = await playlistItems.list(
        part: argResults!['part'],
        playlistId: argResults?['playlist-id'],
        id: argResults?['id'],
        videoId: argResults?['video-id'],
        maxResults: int.tryParse(argResults?['max-results'] ?? ''),
        pageToken: argResults?['page-token'],
      );

      print(response);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Adds a resource to a playlist.
class YoutubeInsertPlaylistItemsCommand extends YtHelperCommand {
  @override
  String get description => 'Adds a resource to a playlist.';

  @override
  String get name => 'insert';

  YoutubeInsertPlaylistItemsCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet',
        help:
            'The part parameter identifies the playlistItem resource properties that the write operation will set and that the API response will include.',
      )
      ..addOption(
        'body',
        mandatory: true,
        help:
            'A playlistItem resource (https://developers.google.com/youtube/v3/docs/playlistItems#resource) as a JSON string.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final result = await playlistItems.insert(
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

/// Modifies a playlist item.
class YoutubeUpdatePlaylistItemsCommand extends YtHelperCommand {
  @override
  String get description => 'Modifies a playlist item.';

  @override
  String get name => 'update';

  YoutubeUpdatePlaylistItemsCommand() {
    argParser
      ..addOption(
        'part',
        mandatory: true,
        help:
            'The part parameter identifies the playlistItem resource properties that the write operation will set.',
      )
      ..addOption(
        'body',
        mandatory: true,
        help: 'A playlistItem resource as a JSON string.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final result = await playlistItems.update(
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

/// Deletes a playlist item.
class YoutubeDeletePlaylistItemsCommand extends YtHelperCommand {
  @override
  String get description => 'Deletes a playlist item.';

  @override
  String get name => 'delete';

  YoutubeDeletePlaylistItemsCommand() {
    argParser.addOption(
      'id',
      mandatory: true,
      valueHelp: 'id',
      help:
          'The id parameter specifies the YouTube playlist item ID for the playlist item that is being deleted.',
    );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      await playlistItems.delete(id: argResults!['id']);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
