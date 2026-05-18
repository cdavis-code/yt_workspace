import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/third_party_links.dart';

/// A [ThirdPartyLink] resource represents a link between a YouTube channel
/// or video and an external resource, such as a merchandising store.
class ThirdPartyLinks extends YouTubeApiHelper {
  final ThirdPartyLinksClient _rest;

  ThirdPartyLinks({required super.dio}) : _rest = ThirdPartyLinksClient(dio);

  /// Returns a list of third-party links of the specified type that match
  /// the API request criteria.
  Future<ThirdPartyLinkListResponse> list({
    String part = 'snippet,status',
    List<String> partList = const [],
    String? externalChannelId,
    String? linkingToken,
    String? type,
  }) async => _rest.list(
    accept,
    buildParts(partList, part),
    externalChannelId: externalChannelId,
    linkingToken: linkingToken,
    type: type,
  );

  /// Posts a third-party link to a YouTube channel.
  Future<ThirdPartyLink> insert({
    String part = 'snippet,status',
    List<String> partList = const [],
    required Map<String, dynamic> body,
    String? externalChannelId,
  }) async => _rest.insert(
    accept,
    contentType,
    buildParts(partList, part),
    body,
    externalChannelId: externalChannelId,
  );

  /// Updates an existing third-party link.
  Future<ThirdPartyLink> update({
    String part = 'snippet,status',
    List<String> partList = const [],
    required Map<String, dynamic> body,
    String? externalChannelId,
  }) async => _rest.update(
    accept,
    contentType,
    buildParts(partList, part),
    body,
    externalChannelId: externalChannelId,
  );

  /// Deletes a third-party link.
  Future<void> delete({
    required String linkingToken,
    required String type,
    String? part,
    String? externalChannelId,
  }) async => _rest.delete(
    accept,
    linkingToken,
    type,
    part: part,
    externalChannelId: externalChannelId,
  );
}
