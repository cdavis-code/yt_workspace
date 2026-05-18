import 'package:json_annotation/json_annotation.dart';

import 'channel_section_localized.dart';

part 'channel_section_snippet.g.dart';

/// The snippet object contains basic details about the channel section,
/// such as its type, style and title.
@JsonSerializable()
class ChannelSectionSnippet {
  /// The type of the channel section. Valid values include
  /// `singlePlaylist`, `multiplePlaylists`, `popularUploads`,
  /// `recentUploads`, `likes`, `allPlaylists`, `likedPlaylists`,
  /// `recentPosts`, `recentActivity`, `liveEvents`, `upcomingEvents`,
  /// `completedEvents`, `multipleChannels`, `postedVideos`,
  /// `postedPlaylists`, `subscriptions`.
  final String? type;

  /// The style of the channel section. Valid values include `horizontalRow`
  /// and `verticalList`.
  final String? style;

  /// The ID that YouTube uses to uniquely identify the channel that
  /// published the channel section.
  final String? channelId;

  /// The channel section's title. The property's value is only
  /// available for channel sections of `singlePlaylist` or `multiplePlaylists` type.
  final String? title;

  /// The position of the channel section on the channel's brand view page.
  final int? position;

  /// The default_language property's value is the language of the
  /// channel section's default snippet.
  final String? defaultLanguage;

  /// The localized object contains a localized title for the channel section.
  final ChannelSectionLocalized? localized;

  ChannelSectionSnippet({
    this.type,
    this.style,
    this.channelId,
    this.title,
    this.position,
    this.defaultLanguage,
    this.localized,
  });

  factory ChannelSectionSnippet.fromJson(Map<String, dynamic> json) =>
      _$ChannelSectionSnippetFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelSectionSnippetToJson(this);
}
