import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/channels.dart';

class Channels extends YouTubeApiHelper {
  final ChannelClient _rest;

  Channels({required super.dio, super.token, super.apiKey})
    : _rest = ChannelClient(dio);

  /// Returns a collection of zero or more channel resources that match the request criteria.
  Future<ChannelResponse> list({
    String part =
        'contentDetails,id,localizations,snippet,status,brandingSettings',
    List<String> partList = const [],
    String? categoryId,
    String? forUsername,
    String? id,
    bool? managedByMe,
    bool? mine,
    String? hl,
    int? maxResults,
    String? onBehalfOfContentOwner,
    String? pageToken,
  }) async {
    return _rest.list(
      apiKey,
      accept,
      buildParts(partList, part),
      categoryId: categoryId,
      forUsername: forUsername,
      id: id,
      managedByMe: managedByMe,
      mine: mine,
      hl: hl,
      maxResults: maxResults,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      pageToken: pageToken,
    );
  }

  /// Modifies a Channels For example, you could change a Channels title, description, or privacy status.
  Future<ChannelItem> update({
    String part = 'contentDetails,id,localizations,player,snippet,status',
    List<String> partList = const [],
    required Map<String, dynamic> body,
    String? onBehalfOfContentOwner,
  }) async {
    return await _rest.update(
      accept,
      contentType,
      buildParts(partList, part),
      body,
    );
  }
}
