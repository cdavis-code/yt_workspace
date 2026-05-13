import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/video_abuse_report_reasons.dart';

class VideoAbuseReportReasons extends YouTubeApiHelper {
  final VideoAbuseReportReasonsClient _rest;

  VideoAbuseReportReasons({required super.dio})
    : _rest = VideoAbuseReportReasonsClient(dio);

  Future<VideoAbuseReportReasonListResponse> list({
    String part = 'id,snippet',
    String? hl,
  }) async => _rest.list(accept, buildParts([], part), hl: hl);
}
