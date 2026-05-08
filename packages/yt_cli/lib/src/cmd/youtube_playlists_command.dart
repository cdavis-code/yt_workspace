import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';
import 'youtube_helper_command.dart';

///A playlist resource represents a YouTube playlist. A playlist is a collection of videos that can be viewed sequentially and shared with other users. By default, playlists are publicly visible to other users, but playlists can be public or private.
///
///YouTube also uses playlists to identify special collections of videos for a channel, such as:
///
///uploaded videos
///positively rated (liked) videos
///To be more specific, these lists are associated with a channel, which is a collection of a person, group, or company's videos, playlists, and other YouTube information. You can retrieve the playlist IDs for each of these lists from the channel resource for a given channel.
///
///You can then use the playlistItems.list method to retrieve any of those lists. You can also add or remove items from those lists by calling the playlistItems.insert and playlistItems.delete methods.
class YoutubePlaylistsCommand extends YtHelperCommand {
  @override
  String get description =>
      'A playlist resource represents a YouTube playlist. A playlist is a collection of videos that can be viewed sequentially and shared with other users. By default, playlists are publicly visible to other users, but playlists can be public or private.';

  @override
  String get name => 'playlists';

  YoutubePlaylistsCommand() {
    addSubcommand(YoutubeListPlaylistsCommand());
    addSubcommand(YoutubeInsertPlaylistsCommand());
    addSubcommand(YoutubeUpdatePlaylistsCommand());
    addSubcommand(YoutubeDeletePlaylistsCommand());
  }
}

///Returns a collection of playlists that match the API request parameters. For
///example, you can retrieve all playlists that the authenticated user owns, or
///you can retrieve one or more playlists by their unique IDs.
class YoutubeListPlaylistsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Returns a collection of playlists that match the API request parameters. For example, you can retrieve all playlists that the authenticated user owns, or you can retrieve one or more playlists by their unique IDs.';

  @override
  String get name => 'list';

  YoutubeListPlaylistsCommand() {
    argParser
      ..addOption(
        'part',
        mandatory: true,
        help:
            '''The part parameter specifies a comma-separated list of one or more playlist resource properties that the API response will include.

If the parameter identifies a property that contains child properties, the child properties will be included in the response. For example, in a playlist resource, the snippet property contains properties like author, title, description, and timeCreated. As such, if you set part=snippet, the API response will contain all of those properties.

The following list contains the part names that you can include in the parameter value:
contentDetails, id, localizations, player, snippet, status''',
      )
      ..addOption(
        'channel-id',
        help:
            'This value indicates that the API should only return the specified channel\'s playlists.',
        valueHelp: 'YouTube username',
      )
      ..addOption(
        'id',
        valueHelp: 'id',
        help:
            'The id parameter specifies a comma-separated list of the YouTube playlist ID(s) for the resource(s) that are being retrieved. In a playlist resource, the id property specifies the playlist\'s YouTube playlist ID.',
      )
      ..addOption(
        'mine',
        help:
            'This parameter can only be used in a properly authorized request. Set this parameter\'s value to true to instruct the API to only return playlists owned by the authenticated user.',
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
      final playlistResponse = await playlists.list(
        part: argResults!['part'],
        channelId: argResults?['channel-id'],
        id: argResults?['id'],
        mine: argResults?['mine'] != null && argResults!['mine'] != "false"
            ? true
            : null,
        maxResults: int.parse(argResults!['max-results']),
        pageToken: argResults?['page-token'],
      );

      print(playlistResponse);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

///Creates a broadcast.
class YoutubeInsertPlaylistsCommand extends YtHelperCommand {
  @override
  String get description => 'Creates a playlist.';

  @override
  String get name => 'insert';

  YoutubeInsertPlaylistsCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet,contentDetails,status',
        help:
            '''The part parameter serves two purposes in this operation. It identifies the properties that the write operation will set as well as the properties that the API response will include.
              
              The part properties that you can include in the parameter value are id, snippet, contentDetails, and status.''',
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
      final playlist = await playlists.insert(
        body: json.decode(argResults!['body']),
        part: argResults!['part'],
      );

      print(playlist);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

///Modifies a playlist. For example, you could change a playlist's title,
///description, or privacy status.
class YoutubeUpdatePlaylistsCommand extends YtHelperCommand {
  @override
  String get description =>
      'Modifies a playlist. For example, you could change a playlist\'s title, description, or privacy status.';

  @override
  String get name => 'update';

  YoutubeUpdatePlaylistsCommand() {
    argParser
      ..addOption(
        'part',
        mandatory: true,
        help:
            '''The part parameter serves two purposes in this operation. It identifies the properties that the write operation will set as well as the properties that the API response will include.

Note that this method will override the existing values for mutable properties that are contained in any parts that the request body specifies. For example, a playlist's description is contained in the snippet part, which must be included in the request body. If the request does not specify a value for the snippet.description property, the playlist's existing description will be deleted.

The following list contains the part names that you can include in the parameter value:
contentDetails, id, localizations, player, snippet, status''',
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
      final playlist = await playlists.update(
        body: json.decode(argResults!['body']),
        part: argResults!['part'],
      );

      print(playlist);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}

///Deletes a playlist.
class YoutubeDeletePlaylistsCommand extends YtHelperCommand {
  @override
  String get description => 'Deletes a playlist.';

  @override
  String get name => 'delete';

  YoutubeDeletePlaylistsCommand() {
    argParser.addOption(
      'id',
      mandatory: true,
      valueHelp: 'id',
      help:
          'The id parameter specifies the YouTube playlist ID for the playlist that is being deleted. In a playlist resource, the id property specifies the playlist\'s ID.',
    );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      await playlists.delete(id: argResults!['id']);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
