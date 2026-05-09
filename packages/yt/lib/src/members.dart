import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/members.dart';

class Members extends YouTubeApiHelper {
  final MembersClient _rest;

  Members({required super.dio}) : _rest = MembersClient(dio);

  Future<MemberListResponse> list({
    String part = 'snippet',
    String? mode,
    int? maxResults,
    String? pageToken,
  }) async => _rest.list(
    accept,
    buildParts([], part),
    mode: mode,
    maxResults: maxResults,
    pageToken: pageToken,
  );
}