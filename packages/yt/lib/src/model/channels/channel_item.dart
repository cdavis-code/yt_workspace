import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'snippet.dart';
import 'content_details.dart';
import 'statistics.dart';

import '../response_metadata.dart';
import 'branding_settings.dart';

part 'channel_item.g.dart';

///A channel resource contains information about a YouTube channel.
@JsonSerializable()
class ChannelItem extends ResponseMetadata {
  ///The ID that YouTube uses to uniquely identify the channel
  final String id;

  ///The [Snippet] object contains basic details about the channel, such as its title, description, and thumbnail images.
  final Snippet? snippet;

  ///The [ContentDetails] object encapsulates information about the channel's content.
  final ContentDetails? contentDetails;

  ///The [Statistics] object encapsulates statistics for the channel.
  final Statistics? statistics;

  ///The [BrandingSettings] object encapsulates information about the branding of the channel.
  final BrandingSettings? brandingSettings;

  ChannelItem({
    required super.kind,
    required super.etag,
    required this.id,
    this.snippet,
    this.contentDetails,
    this.statistics,
    this.brandingSettings,
  });

  factory ChannelItem.fromJson(Map<String, dynamic> json) =>
      _$ChannelItemFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelItemToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
