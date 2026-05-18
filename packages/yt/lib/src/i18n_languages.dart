import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/i18n_languages.dart';

/// An [I18nLanguage] resource identifies an application language that the
/// YouTube website supports. The application language can also be referred
/// to as a UI language.
class I18nLanguages extends YouTubeApiHelper {
  final I18nLanguagesClient _rest;

  I18nLanguages({required super.dio, super.apiKey})
    : _rest = I18nLanguagesClient(dio);

  /// Returns a list of application languages that the YouTube website supports.
  Future<I18nLanguageListResponse> list({
    String part = 'snippet',
    List<String> partList = const [],
    String? hl,
  }) async => _rest.list(apiKey, accept, buildParts(partList, part), hl: hl);
}
