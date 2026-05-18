import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/channel_sections.dart';

/// A [ChannelSection] resource represents a section of a channel's main page.
/// Channel owners can use channel sections to spotlight specific playlists,
/// videos, or channels.
class ChannelSections extends YouTubeApiHelper {
  final ChannelSectionsClient _rest;

  ChannelSections({required super.dio, super.apiKey})
    : _rest = ChannelSectionsClient(dio);

  /// Returns a list of channelSection resources that match the API request criteria.
  Future<ChannelSectionListResponse> list({
    String part = 'contentDetails,id,localizations,snippet',
    List<String> partList = const [],
    String? channelId,
    String? id,
    bool? mine,
    String? hl,
    String? onBehalfOfContentOwner,
  }) async => _rest.list(
    apiKey,
    accept,
    buildParts(partList, part),
    channelId: channelId,
    id: id,
    mine: mine,
    hl: hl,
    onBehalfOfContentOwner: onBehalfOfContentOwner,
  );

  /// Adds a channel section to the authenticated user's channel.
  Future<ChannelSection> insert({
    String part = 'contentDetails,id,localizations,snippet',
    List<String> partList = const [],
    required Map<String, dynamic> body,
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
  }) async => _rest.insert(
    accept,
    contentType,
    buildParts(partList, part),
    body,
    onBehalfOfContentOwner: onBehalfOfContentOwner,
    onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
  );

  /// Updates a channel section.
  Future<ChannelSection> update({
    String part = 'contentDetails,id,localizations,snippet',
    List<String> partList = const [],
    required Map<String, dynamic> body,
    String? onBehalfOfContentOwner,
  }) async => _rest.update(
    accept,
    contentType,
    buildParts(partList, part),
    body,
    onBehalfOfContentOwner: onBehalfOfContentOwner,
  );

  /// Deletes a channel section.
  Future<void> delete({
    required String id,
    String? onBehalfOfContentOwner,
  }) async =>
      _rest.delete(accept, id, onBehalfOfContentOwner: onBehalfOfContentOwner);
}
