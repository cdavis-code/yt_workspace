import 'package:args/command_runner.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:universal_io/io.dart';
import 'package:yt/yt.dart';

import '../util/security_util.dart';

/// Generate a refresh token used to authenticate the command line API
/// requests.
///
/// Uses an OAuth 2.0 web flow that captures a permanent Refresh Token for
/// unattended server-side operation. See the setup guide for details on
/// obtaining a `client_secret.json` file from the Google Cloud Console.
class YoutubeAuthorizeCommand extends Command<void> {
  static const _guideUrl =
      'https://github.com/faithoflifedev/yt/blob/main/packages/yt_cli/authentication.md';

  static const _secretFilename = 'client_secrets.json';
  static const _tokenStorageFilename = 'access_tokens.json';

  @override
  String get description =>
      'Start the OAuth 2.0 web flow to authorize the CLI for YouTube API requests.';

  @override
  String get name => 'authorize';

  YoutubeAuthorizeCommand() {
    argParser
      ..addFlag(
        'overwrite-credentials',
        abbr: 'o',
        help: 'Overwrite the currently stored credentials and re-authorize.',
      )
      ..addOption(
        'credentials-file',
        abbr: 'c',
        defaultsTo: _secretFilename,
        help:
            'Path to the client_secret.json file downloaded from the Google '
            'Cloud Console. When omitted, the file is looked up via the '
            'YT_CLIENT_SECRETS_FILE environment variable (or .env), falling '
            'back to "$_secretFilename" in the current working directory.',
        valueHelp: 'path',
      )
      ..addOption(
        'tokens-file',
        abbr: 't',
        help:
            'Path where the OAuth tokens will be stored. When omitted, '
            'defaults to the value of YT_ACCESS_TOKENS_FILE (env var or .env), '
            'falling back to "$_tokenStorageFilename" in the current working directory.',
        valueHelp: 'path',
      );
  }

  @override
  void run() async {
    print('--- YouTube CLI Authorization ---');
    print('Setup guide: $_guideUrl');
    print('');

    final overwrite = argResults!['overwrite-credentials'] as bool;
    // If the user explicitly passed --credentials-file, honor that path
    // exactly. Otherwise resolve the client_secret.json location via
    // YT_CLIENT_SECRETS_FILE (env var or .env), falling back to the
    // current working directory.
    final credentialsFilePath = argResults!.wasParsed('credentials-file')
        ? argResults!['credentials-file'] as String
        : CredentialsPath.clientSecretsFile(defaultPath: _secretFilename);
    // If the user explicitly passed --tokens-file, honor that path exactly.
    // Otherwise resolve via YT_ACCESS_TOKENS_FILE (env var or .env), falling
    // back to the current working directory.
    final tokenStoragePath = argResults!.wasParsed('tokens-file')
        ? argResults!['tokens-file'] as String
        : CredentialsPath.accessTokensFile(defaultPath: _tokenStorageFilename);

    final File secretFile;
    try {
      secretFile = await SecurityUtil.validateInputFile(
        credentialsFilePath,
        argName: 'credentials-file',
      );
    } on FormatException catch (e) {
      print(
        'Error: ${e.message}\n'
        'Download client_secret.json from the Google Cloud Console Credentials page.\n'
        'See the setup guide above for step-by-step instructions.',
      );
      exit(1);
    }

    final tokenStorageFile = File(tokenStoragePath);

    if (await tokenStorageFile.exists() && !overwrite) {
      print('Already authorized ("$tokenStoragePath" exists).');
      print('Use --overwrite-credentials / -o to re-authorize.');
      return;
    }

    // Parse and validate the Google Cloud Console credentials JSON.
    final Map<String, dynamic> config;
    try {
      config = SecurityUtil.parseAndValidateClientSecret(
        await secretFile.readAsString(),
      );
    } on FormatException catch (e) {
      print('Error: ${e.message}');
      exit(1);
    }

    final clientId = config['client_id'] as String;
    final clientSecret = config['client_secret'] as String;
    final authEndpoint = Uri.parse(config['auth_uri'] as String);
    final tokenEndpoint = Uri.parse(config['token_uri'] as String);

    // Prefer the first redirect URI from the downloaded file.
    final List<dynamic> redirectUris =
        (config['redirect_uris'] as List<dynamic>?) ?? [];
    final redirectUrl = redirectUris.isNotEmpty
        ? Uri.parse(redirectUris.first as String)
        : Uri.parse('http://localhost:8080/callback');

    if (overwrite && await tokenStorageFile.exists()) {
      await tokenStorageFile.delete();
    }

    // --- One-time interactive OAuth 2.0 flow ---
    final scopes = ['https://www.googleapis.com/auth/youtube.force-ssl'];

    final grant = oauth2.AuthorizationCodeGrant(
      clientId,
      authEndpoint,
      tokenEndpoint,
      secret: clientSecret,
    );

    // Build the authorization URL.  getAuthorizationUrl may only be called
    // once per grant, so we add Google-specific query parameters afterward.
    final baseAuthUrl = grant.getAuthorizationUrl(redirectUrl, scopes: scopes);
    final authorizationUrl = baseAuthUrl.replace(
      queryParameters: {
        ...baseAuthUrl.queryParameters,
        'access_type': 'offline',
        'prompt': 'consent',
      },
    );

    print('Open this URL in your web browser to authorize:');
    print('  => $authorizationUrl');
    print('');

    // Start a temporary local HTTP server to catch the redirect.
    final port = redirectUrl.port != 0 ? redirectUrl.port : 8080;
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
    print('Waiting for authorization redirect on port $port...');

    final request = await server.first;
    final callbackUri = request.uri;

    // Validate the callback path matches the registered redirect URI and
    // that an authorization code was returned without an error.
    try {
      SecurityUtil.validateOAuthCallback(
        callback: callbackUri,
        expectedRedirect: redirectUrl,
      );
    } on FormatException catch (e) {
      request.response
        ..statusCode = HttpStatus.badRequest
        ..headers.contentType = ContentType.html
        ..write('<h1>Authorization failed</h1><p>${e.message}</p>');
      await request.response.close();
      await server.close();
      print('Error: ${e.message}');
      exit(1);
    }

    // Send a friendly success page back to the browser.
    request.response
      ..statusCode = HttpStatus.ok
      ..headers.contentType = ContentType.html
      ..write(
        '<h1>Authorization successful!</h1>'
        '<p>You can close this tab and return to your terminal.</p>',
      );
    await request.response.close();
    await server.close();

    // Exchange the authorization code for permanent tokens.
    final client = await grant.handleAuthorizationResponse(
      callbackUri.queryParameters,
    );

    // Persist credentials so subsequent runs are fully automatic, then
    // restrict the token file to owner read/write only on POSIX.
    await tokenStorageFile.writeAsString(client.credentials.toJson());
    await SecurityUtil.restrictFilePermissions(tokenStorageFile);

    print('');
    print('Authorization completed.');
    print('Tokens saved to "$tokenStoragePath". The CLI is now ready for use.');
  }
}
