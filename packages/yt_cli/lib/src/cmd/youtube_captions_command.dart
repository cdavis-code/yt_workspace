import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:universal_io/io.dart';
import 'package:yt/yt.dart';

import '../util/security_util.dart';
import 'youtube_helper_command.dart';

/// Command group for the captions resource.
///
/// A caption resource contains information about a YouTube video caption track.
class YoutubeCaptionsCommand extends Command<void> {
  @override
  String get description =>
      'A caption resource contains information about a YouTube video caption track.';

  @override
  String get name => 'captions';

  YoutubeCaptionsCommand() {
    addSubcommand(YoutubeListCaptionsCommand());
    addSubcommand(YoutubeInsertCaptionsCommand());
    addSubcommand(YoutubeUpdateCaptionsCommand());
    addSubcommand(YoutubeDeleteCaptionsCommand());
    addSubcommand(YoutubeDownloadCaptionsCommand());
  }
}

/// Returns a list of caption tracks that are associated with a specified
/// video.
class YoutubeListCaptionsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a list of caption tracks that are associated with a specified video.';

  @override
  String get name => 'list';

  YoutubeListCaptionsCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'id,snippet',
        help:
            'Comma-separated list of caption resource parts. Valid values: id, snippet.',
      )
      ..addOption(
        'video-id',
        valueHelp: 'video id',
        mandatory: true,
        help:
            'The videoId parameter specifies the YouTube video ID of the video for which the API should return caption tracks.',
      )
      ..addOption(
        'id',
        valueHelp: 'id',
        help:
            'The id parameter specifies a comma-separated list of IDs that identify the caption resources to retrieve.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final response = await captions.list(
        part: argResults!['part'],
        videoId: argResults!['video-id'],
        id: argResults?['id'],
      );

      print(response);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Uploads a caption track.
class YoutubeInsertCaptionsCommand extends YtHelperCommand {
  @override
  String get description => 'Uploads a caption track.';

  @override
  String get name => 'insert';

  YoutubeInsertCaptionsCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet',
        help:
            'The part parameter specifies the caption resource parts that the API response will include. Set to snippet.',
      )
      ..addOption(
        'body',
        mandatory: true,
        help:
            'A caption resource snippet (https://developers.google.com/youtube/v3/docs/captions#resource) as a JSON string.',
      )
      ..addOption(
        'file',
        valueHelp: 'file name',
        mandatory: true,
        help:
            'The path to the caption file (.srt, .vtt, .ass, etc.) to upload.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final captionFile = await SecurityUtil.validateInputFile(
        argResults!['file'] as String,
        argName: 'file',
      );

      final result = await captions.insert(
        body: json.decode(argResults!['body']),
        captionFile: captionFile,
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

/// Updates a caption track.
class YoutubeUpdateCaptionsCommand extends YtHelperCommand {
  @override
  String get description => 'Updates a caption track.';

  @override
  String get name => 'update';

  YoutubeUpdateCaptionsCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet',
        help:
            'The part parameter specifies the caption resource parts that the API response will include.',
      )
      ..addOption(
        'body',
        mandatory: true,
        help: 'A caption resource (with id and snippet) as a JSON string.',
      )
      ..addOption(
        'file',
        valueHelp: 'file name',
        mandatory: true,
        help: 'The path to the updated caption file.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final captionFile = await SecurityUtil.validateInputFile(
        argResults!['file'] as String,
        argName: 'file',
      );

      final result = await captions.update(
        body: json.decode(argResults!['body']),
        captionFile: captionFile,
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

/// Deletes a caption track.
class YoutubeDeleteCaptionsCommand extends YtHelperCommand {
  @override
  String get description => 'Deletes a caption track.';

  @override
  String get name => 'delete';

  YoutubeDeleteCaptionsCommand() {
    argParser.addOption(
      'id',
      mandatory: true,
      valueHelp: 'id',
      help:
          'The id parameter identifies the caption track that is being deleted.',
    );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      await captions.delete(id: argResults!['id']);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

/// Downloads a caption track.
class YoutubeDownloadCaptionsCommand extends YtHelperCommand {
  @override
  String get description => 'Downloads a caption track.';

  @override
  String get name => 'download';

  YoutubeDownloadCaptionsCommand() {
    argParser
      ..addOption(
        'id',
        mandatory: true,
        valueHelp: 'id',
        help:
            'The id parameter identifies the caption track that is being retrieved.',
      )
      ..addOption(
        'tfmt',
        valueHelp: 'format',
        help:
            'The tfmt parameter specifies the caption track output format (e.g. srt, vtt, sbv).',
      )
      ..addOption(
        'tlang',
        valueHelp: 'BCP-47 language code',
        help:
            'The tlang parameter specifies a BCP-47 language code for an auto-translated caption track.',
      )
      ..addOption(
        'out',
        valueHelp: 'file name',
        help:
            'Optional path to write the downloaded caption content. When omitted, the content is printed to stdout.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final content = await captions.download(
        id: argResults!['id'],
        tfmt: argResults?['tfmt'],
        tlang: argResults?['tlang'],
      );

      final outPath = argResults?['out'] as String?;
      if (outPath != null && outPath.isNotEmpty) {
        await File(outPath).writeAsString(content);
        print('Wrote caption content to $outPath');
      } else {
        print(content);
      }

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
