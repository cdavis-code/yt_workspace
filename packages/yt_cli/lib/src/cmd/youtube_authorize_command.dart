import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:universal_io/io.dart';
import 'package:yt/oauth.dart';
import 'package:yt/yt.dart';

/// Generate a refresh token used to authenticate the command line API requests
class YoutubeAuthorizeCommand extends Command<void> {
  static String? get userHome =>
      Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];

  static File get defaultCredentialsFile =>
      File('$userHome/${Util.defaultCredentialsFilePath}');

  static final accessCredentialsFile = File(
    '$userHome/${Util.accessCredentialsFilePath}',
  );

  @override
  String get description =>
      'Generate a refresh token used to authenticate the command line API requests';

  @override
  String get name => 'authorize';

  YoutubeAuthorizeCommand() {
    argParser.addFlag(
      'overwrite-credentials',
      abbr: 'o',
      help:
          'use this flag if you need to overwrite the currently stored credentials.',
    );
  }

  @override
  void run() async {
    final overwrite = argResults!['overwrite-credentials'];

    final hasCred = overwrite && defaultCredentialsFile.existsSync();

    final httpClient = HttpClient();

    final credentials = <String, dynamic>{};

    ClientId? oAuthClientId;

    if (overwrite && accessCredentialsFile.existsSync()) {
      accessCredentialsFile.deleteSync();
    }

    if (!hasCred) {
      print('Enter clientId:');

      credentials['identifier'] = stdin.readLineSync(
        encoding: Util.defaultEncoding(),
      );

      if (credentials['identifier'] == null) {
        throw Exception('Client Identifier not supplied');
      }

      print('Enter clientSecret:');

      credentials['secret'] = stdin.readLineSync(
        encoding: Util.defaultEncoding(),
      );

      oAuthClientId = ClientId(
        credentials['identifier'],
        credentials['secret'],
      );

      defaultCredentialsFile.createSync(recursive: true);

      defaultCredentialsFile.writeAsStringSync(json.encode(credentials));
    }

    final accessControl = OAuthAccessControl(oAuthClientId);

    await accessControl.init();

    httpClient.close();

    print('Authorization completed.');
  }
}
