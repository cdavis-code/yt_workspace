import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/i18n_regions.dart';

/// An [I18nRegion] resource identifies a geographic area that a YouTube user
/// can select as the preferred content region.
class I18nRegions extends YouTubeApiHelper {
  final I18nRegionsClient _rest;

  I18nRegions({required super.dio, super.apiKey})
    : _rest = I18nRegionsClient(dio);

  /// Returns a list of content regions that the YouTube website supports.
  Future<I18nRegionListResponse> list({
    String part = 'snippet',
    List<String> partList = const [],
    String? hl,
  }) async => _rest.list(apiKey, accept, buildParts(partList, part), hl: hl);
}
