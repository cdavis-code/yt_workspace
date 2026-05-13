import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'video_abuse_report_reasons.g.dart';

@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class VideoAbuseReportReasonsClient {
  factory VideoAbuseReportReasonsClient(Dio dio, {String baseUrl}) =
      _VideoAbuseReportReasonsClient;

  @GET('/videoAbuseReportReasons')
  Future<VideoAbuseReportReasonListResponse> list(
    @Header('Accept') String accept,
    @Query('part') String part, {
    @Query('hl') String? hl,
  });
}
