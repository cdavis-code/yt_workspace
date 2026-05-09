import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/memberships_levels.dart';

class MembershipsLevels extends YouTubeApiHelper {
  final MembershipsLevelsClient _rest;

  MembershipsLevels({required super.dio})
    : _rest = MembershipsLevelsClient(dio);

  Future<MembershipsLevelListResponse> list({
    String part = 'id,snippet',
  }) async => _rest.list(accept, buildParts([], part));
}
