import 'dart:convert';

import 'package:loggy/loggy.dart';

class Util {
  /// the default maxResults for API responses from the YouTube Data API
  static const responseMaxResults = 20;

  static LogOptions convertToLogOptions(String logLevel) {
    var logOptions = const LogOptions(LogLevel.off);

    switch (logLevel) {
      case 'all':
        logOptions = const LogOptions(LogLevel.all);
        break;

      case 'debug':
        logOptions = const LogOptions(LogLevel.debug);
        break;

      case 'info':
        logOptions = const LogOptions(LogLevel.info);
        break;

      case 'warning':
        logOptions = const LogOptions(LogLevel.warning);
        break;

      case 'error':
        logOptions = const LogOptions(LogLevel.error);
        break;
    }

    return logOptions;
  }

  static Encoding defaultEncoding() => Encoding.getByName('utf-8')!;

  static String base64GCloudString(String data) =>
      Util.base64GCloudList(utf8.encode(data));

  static String base64GCloudList(List<int> data) => base64
      .encode(data)
      .replaceAll('/', '_')
      .replaceAll('+', '-')
      .replaceAll('=', '');

  static int unixTimeStamp(DateTime dt) =>
      dt.toUtc().millisecondsSinceEpoch ~/ 1000;

  static T cast<T>(dynamic x, {required T fallback}) => x is T ? x : fallback;

  static String getUploadIdFromUrl(String locationUrl) {
    final locationUri = Uri.parse(locationUrl);

    if (!locationUri.queryParameters.containsKey('upload_id')) {
      throw Exception('The upload ID has not been found.');
    }

    return locationUri.queryParameters['upload_id']!;
  }

  static final String defaultCredentialsFilePath = '.yt/credentials.json';

  static final String accessCredentialsFilePath = '.yt/access_credentials.json';

  static int maxResults(
    int? maxResults, {
    int defaultValue = responseMaxResults,
  }) => (maxResults != null && (maxResults < 1 || maxResults > 100))
      ? defaultValue
      : maxResults!;

  // static ClientId defaultClientId() =>
  //     clientIdFromFileSpec(defaultCredentialsFileSpec);

  // static ClientId clientIdFromFileSpec(String fileSpec) =>

  //     ClientId.fromJson(json.decode(File(fileSpec).readAsStringSync()));

  // static String? get userHome =>
  //     Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];

  // static String get defaultCredentialsFileSpec =>
  //     '${Util.userHome}/.yt/credentials.json';

  // static String get defaultCredentialsKey => 'credentials';

  // static File get accessCredentialsFile =>
  //     File('${Util.userHome}/.yt/access_credentials.json');
}

enum ListPosition { start, end }

/// This parameter indicates whether the API should return comments formatted as
/// HTML or as plain text. The default value is html.
enum TextFormat {
  /// Returns the comments in HTML format. This is the default value.
  html,

  /// Returns the comments in plain text format.
  plainText,
}
