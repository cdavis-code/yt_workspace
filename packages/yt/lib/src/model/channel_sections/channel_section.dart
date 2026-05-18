import 'package:json_annotation/json_annotation.dart';

import 'channel_section_content_details.dart';
import 'channel_section_localized.dart';
import 'channel_section_snippet.dart';

part 'channel_section.g.dart';

/// A channelSection resource represents a section of a channel's main page.
/// Channel owners can use channel sections to spotlight specific playlists,
/// videos, or channels.
@JsonSerializable()
class ChannelSection {
  final String kind;
  final String etag;
  final String? id;
  final ChannelSectionSnippet? snippet;
  final ChannelSectionContentDetails? contentDetails;
  final Map<String, ChannelSectionLocalized>? localizations;

  ChannelSection({
    this.kind = 'youtube#channelSection',
    required this.etag,
    this.id,
    this.snippet,
    this.contentDetails,
    this.localizations,
  });

  factory ChannelSection.fromJson(Map<String, dynamic> json) =>
      _$ChannelSectionFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelSectionToJson(this);
}
