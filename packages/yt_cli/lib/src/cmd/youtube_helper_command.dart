import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:universal_io/io.dart';
import 'package:yt/oauth.dart';
import 'package:yt/yt.dart';

abstract class YtHelperCommand extends Command<void> {
  late final Yt _yt;

  Broadcast get broadcast => _yt.broadcast;

  Chat get chat => _yt.chat;

  LiveStream get liveStream => _yt.liveStream;

  Channels get channels => _yt.channels;

  Comments get comments => _yt.comments;

  CommentThreads get commentThreads => _yt.commentThreads;

  Playlists get playlists => _yt.playlists;

  Search get search => _yt.search;

  Subscriptions get subscriptions => _yt.subscriptions;

  Thumbnails get thumbnails => _yt.thumbnails;

  Videos get videos => _yt.videos;

  VideoCategories get videoCategories => _yt.videoCategories;

  Watermarks get watermarks => _yt.watermarks;

  Members get members => _yt.members;

  MembershipsLevels get membershipsLevels => _yt.membershipsLevels;

  VideoAbuseReportReasons get videoAbuseReportReasons =>
      _yt.videoAbuseReportReasons;

  Analytics get analytics => _yt.analytics;

  Future<void> initializeYt() async {
    const secretFilename = 'client_secret.json';
    const tokenFilename = 'youtube_server_tokens.json';

    final secretFile = File(secretFilename);
    final tokenFile = File(tokenFilename);

    if (!await secretFile.exists() || !await tokenFile.exists()) {
      print(
        'Not authorized.  Run "yt authorize" to set up OAuth 2.0 credentials.',
      );
      exit(1);
    }

    // Parse client_secret.json.
    final secretJson =
        jsonDecode(await secretFile.readAsString()) as Map<String, dynamic>;
    final rootKey = secretJson.containsKey('web') ? 'web' : 'installed';
    final config = secretJson[rootKey] as Map<String, dynamic>;
    final clientId = config['client_id'] as String;
    final clientSecret = config['client_secret'] as String;

    // Load stored OAuth 2.0 credentials with automatic refresh.
    final credentialsJson = await tokenFile.readAsString();
    final credentials = oauth2.Credentials.fromJson(credentialsJson);
    final oauthClient = oauth2.Client(
      credentials,
      identifier: clientId,
      secret: clientSecret,
    );

    // Initialize the yt client with a token generator.
    _yt = await Yt.withGenerator(
      _ServerTokenGenerator(oauthClient),
      logOptions: Util.convertToLogOptions(globalResults!['log-level']),
    );

    // Add an interceptor that refreshes the token on every request.
    // The oauth2.Client.credentials getter triggers automatic refresh
    // when the access token is expired.
    Yt.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Authorization'] =
              'Bearer ${oauthClient.credentials.accessToken}';
          return handler.next(options);
        },
      ),
    );
  }

  void close() {
    _yt.close();

    exit(0);
  }
}

/// Bridges an [oauth2.Client] to the yt package's [RefreshTokenGenerator]
/// interface.
class _ServerTokenGenerator implements RefreshTokenGenerator {
  final oauth2.Client _client;

  _ServerTokenGenerator(this._client);

  @override
  Future<Token> generate() async {
    final credentials = _client.credentials;
    return Token(
      accessToken: credentials.accessToken,
      expiresIn:
          credentials.expiration?.difference(DateTime.now()).inSeconds ?? 3599,
      scope: credentials.scopes?.join(' '),
      tokenType: 'Bearer',
    );
  }
}
