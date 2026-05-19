import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';

import '../util/security_util.dart';
import 'youtube_helper_command.dart';

/// Command group for the playlistImages resource.
///
/// A playlistImage resource contains information about a custom playlist
/// image. The API supports the ability to create, read, update, and delete
/// these images.
class YoutubePlaylistImagesCommand extends Command<void> {
  @override
  String get description =>
      'A playlistImage resource contains information about a custom playlist image.';

  @override
  String get name => 'playlist-images';

  YoutubePlaylistImagesCommand() {
    addSubcommand(YoutubeListPlaylistImagesCommand());
    addSubcommand(YoutubeInsertPlaylistImagesCommand());
    addSubcommand(YoutubeUpdatePlaylistImagesCommand());
    addSubcommand(YoutubeDeletePlaylistImagesCommand());
  }
}

/// Returns a list of playlist images for the given playlist.
class YoutubeListPlaylistImagesCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of playlist images for the given playlist.';

  @override
  String get name => 'list';

  YoutubeListPlaylistImagesCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet',
        help:
            'The part parameter specifies the playlistImage resource properties that the API response will include.',
      )
      ..addOption(
        'parent',
        valueHelp: 'playlist id',
        mandatory: true,
        help:
            'The parent parameter specifies the playlist ID for which the playlist images should be returned.',
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
      final response = await playlistImages.list(
        parent: argResults!['parent'],
        part: argResults!['part'],
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

/// Uploads a custom playlist image and associates it with the given playlist.
class YoutubeInsertPlaylistImagesCommand extends YtHelperCommand {
  @override
  String get description =>
      'Uploads a custom playlist image and associates it with the given playlist.';

  @override
  String get name => 'insert';

  YoutubeInsertPlaylistImagesCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet',
        help:
            'The part parameter specifies the playlistImage resource parts that the API response will include.',
      )
      ..addOption(
        'parent',
        valueHelp: 'playlist id',
        mandatory: true,
        help:
            'The parent parameter specifies the playlist ID with which the new image will be associated.',
      )
      ..addOption(
        'file',
        valueHelp: 'file name',
        mandatory: true,
        help: 'The path to the playlist image to upload.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final imageFile = await SecurityUtil.validateInputFile(
        argResults!['file'] as String,
        argName: 'file',
      );

      final result = await playlistImages.insert(
        parent: argResults!['parent'],
        image: imageFile,
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

/// Replaces the image bytes for an existing playlist image.
class YoutubeUpdatePlaylistImagesCommand extends YtHelperCommand {
  @override
  String get description =>
      'Replaces the image bytes for an existing playlist image.';

  @override
  String get name => 'update';

  YoutubeUpdatePlaylistImagesCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'id,snippet',
        help:
            'The part parameter specifies the playlistImage resource parts that the API response will include.',
      )
      ..addOption(
        'file',
        valueHelp: 'file name',
        mandatory: true,
        help: 'The path to the updated playlist image.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final imageFile = await SecurityUtil.validateInputFile(
        argResults!['file'] as String,
        argName: 'file',
      );

      final result = await playlistImages.update(
        image: imageFile,
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

/// Deletes a playlist image.
class YoutubeDeletePlaylistImagesCommand extends YtHelperCommand {
  @override
  String get description => 'Deletes a playlist image.';

  @override
  String get name => 'delete';

  YoutubeDeletePlaylistImagesCommand() {
    argParser.addOption(
      'id',
      mandatory: true,
      valueHelp: 'id',
      help: 'The id parameter specifies the playlistImage ID to delete.',
    );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      await playlistImages.delete(id: argResults!['id']);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
