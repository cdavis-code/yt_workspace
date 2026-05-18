import 'package:json_annotation/json_annotation.dart';

part 'channel_section_content_details.g.dart';

/// The contentDetails object contains details about the channel section
/// content, such as a list of playlists or channels featured in the section.
@JsonSerializable()
class ChannelSectionContentDetails {
  /// A list of one or more playlist IDs that are featured in a channel
  /// section. You must specify a list of playlist IDs if the
  /// snippet.type property's value is `singlePlaylist` or
  /// `multiplePlaylists`, and the list must contain exactly one
  /// (`singlePlaylist`) or more (`multiplePlaylists`) playlist IDs.
  final List<String>? playlists;

  /// A list of one or more channel IDs that are featured in the section.
  /// You must specify a list of channel IDs if the snippet.type property's
  /// value is `multipleChannels`, and the list must contain at least one
  /// channel ID.
  final List<String>? channels;

  ChannelSectionContentDetails({this.playlists, this.channels});

  factory ChannelSectionContentDetails.fromJson(Map<String, dynamic> json) =>
      _$ChannelSectionContentDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelSectionContentDetailsToJson(this);
}
