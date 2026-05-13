import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'reports.g.dart';

@RestApi(baseUrl: 'https://youtubeanalytics.googleapis.com/v2')
abstract class ReportsClient {
  factory ReportsClient(Dio dio, {String baseUrl}) = _ReportsClient;

  @GET('/reports')
  Future<AnalyticsReport> query(
    @Header('Accept') String accept,
    @Query('ids') String ids,
    @Query('startDate') String startDate,
    @Query('endDate') String endDate,
    @Query('metrics') String metrics, {
    @Query('dimensions') String? dimensions,
    @Query('filters') String? filters,
    @Query('maxResults') int? maxResults,
    @Query('sort') String? sort,
    @Query('startIndex') int? startIndex,
    @Query('currency') String? currency,
    @Query('includeHistoricalChannelData') bool? includeHistoricalChannelData,
  });
}
