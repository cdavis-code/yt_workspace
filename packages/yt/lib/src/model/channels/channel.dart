import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'channel.g.dart';

///The channel object encapsulates branding properties of the channel page.
@JsonSerializable()
class Channel {
  ///The channel's title. The title has a maximum length of 30 characters.
  final String title;

  ///The channel description, which appears in the channel information box on your channel page. The property's value has a maximum length of 1000 characters.
  final String description;

  ///Keywords associated with your channel. The value is a space-separated list of strings. Channel keywords might be truncated if they exceed the maximum allowed length of 500 characters or if they contained unescaped quotation marks ("). Note that the 500 character limit is not a per-keyword limit but rather a limit on the total length of all keywords.
  final String? keywords;

  ///The ID for a [Google Analytics account](https://marketingplatform.google.com/about/analytics/) that you want to use to track and measure traffic to your channel.
  final String? trackingAnalyticsAccountId;

  ///This setting determines whether user-submitted comments left on the channel page need to be approved by the channel owner to be publicly visible. The default value is false.
  final bool? moderateComments;

  ///The video that should play in the featured video module in the channel page's browse view for unsubscribed viewers. Subscribed viewers may see a different video that highlights more recent channel activity.
  ///
  ///If specified, the property's value must be the YouTube video ID of a public or unlisted video that is owned by the channel owner.
  final String? unsubscribedTrailer;

  ///The language of the text in the channel resource's snippet.title and snippet.description properties.
  final String? defaultLanguage;

  ///The country with which the channel is associated. Update this property to set the value of the snippet.country property.
  final String? country;

  Channel({
    required this.title,
    required this.description,
    this.keywords,
    this.trackingAnalyticsAccountId,
    this.moderateComments = false,
    this.unsubscribedTrailer,
    this.defaultLanguage,
    this.country,
  });

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
