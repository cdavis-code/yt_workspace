import 'package:args/command_runner.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:universal_io/io.dart';
import 'package:yt/yt.dart';

import '../util/security_util.dart';

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

  Activities get activities => _yt.activities;

  Analytics get analytics => _yt.analytics;

  Future<void> initializeYt() async {
    const secretFilename = 'client_secret.json';
    const tokenFilename = 'youtube_server_tokens.json';

    // Resolve each credential file location independently via
    // YT_CLIENT_SECRETS_FILE and YT_ACCESS_TOKENS_FILE (env var or .env in
    // the current working directory). When neither is set, fall back to the
    // default filenames in the current working directory.
    final secretPath = CredentialsPath.clientSecretsFile(
      defaultPath: secretFilename,
    );
    final tokenPath = CredentialsPath.accessTokensFile(
      defaultPath: tokenFilename,
    );

    final secretFile = File(secretPath);
    final tokenFile = File(tokenPath);

    if (!await secretFile.exists() || !await tokenFile.exists()) {
      print(
        'Not authorized.  Run "yt authorize" to set up OAuth 2.0 credentials.',
      );
      exit(1);
    }

    // Parse and validate client_secret.json.
    final Map<String, dynamic> config;
    try {
      config = SecurityUtil.parseAndValidateClientSecret(
        await secretFile.readAsString(),
      );
    } on FormatException catch (e) {
      print('Error: ${e.message}');
      print('Re-run "yt authorize" with a valid client_secret.json.');
      exit(1);
    }
    final clientId = config['client_id'] as String;
    final clientSecret = config['client_secret'] as String;

    // Load stored OAuth 2.0 credentials. oauth2.Client transparently
    // refreshes them when expired.
    final credentialsJson = await tokenFile.readAsString();
    final credentials = oauth2.Credentials.fromJson(credentialsJson);
    final oauthClient = oauth2.Client(
      credentials,
      identifier: clientId,
      secret: clientSecret,
    );

    _yt = Yt.withOAuth(
      oauthClient: oauthClient,
      logOptions: Util.convertToLogOptions(globalResults!['log-level']),
    );
  }

  void close() {
    _yt.close();

    exit(0);
  }
}
