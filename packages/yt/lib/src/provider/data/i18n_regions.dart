import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'i18n_regions.g.dart';

@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class I18nRegionsClient {
  factory I18nRegionsClient(Dio dio, {String baseUrl}) = _I18nRegionsClient;

  /// Returns a list of content regions that the YouTube website supports.
  @GET('/i18nRegions')
  Future<I18nRegionListResponse> list(
    @Query('key') String? apiKey,
    @Header('Accept') String accept,
    @Query('part') String part, {
    @Query('hl') String? hl,
  });
}
