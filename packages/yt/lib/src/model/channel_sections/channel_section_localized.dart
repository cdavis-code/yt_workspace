import 'package:json_annotation/json_annotation.dart';

part 'channel_section_localized.g.dart';

/// The localized object contains a localized title for the channel section
/// in the language that is associated with the snippet.defaultLanguage value.
@JsonSerializable()
class ChannelSectionLocalized {
  /// The localized title of the channel section.
  final String? title;

  ChannelSectionLocalized({this.title});

  factory ChannelSectionLocalized.fromJson(Map<String, dynamic> json) =>
      _$ChannelSectionLocalizedFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelSectionLocalizedToJson(this);
}
