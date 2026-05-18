import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'i18n_languages.g.dart';

@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class I18nLanguagesClient {
  factory I18nLanguagesClient(Dio dio, {String baseUrl}) = _I18nLanguagesClient;

  /// Returns a list of application languages that the YouTube website supports.
  @GET('/i18nLanguages')
  Future<I18nLanguageListResponse> list(
    @Query('key') String? apiKey,
    @Header('Accept') String accept,
    @Query('part') String part, {
    @Query('hl') String? hl,
  });
}
