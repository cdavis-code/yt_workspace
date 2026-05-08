import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'resource_id.dart';

import '../thumbnails.dart';

part 'snippet.g.dart';

/// The snippet object contains basic details about the subscription, including
/// its title and the channel that the user subscribed to.
@JsonSerializable()
class Snippet {
  /// The date and time that the subscription was created. The value is
  /// specified in [ISO 8601](https://www.w3.org/TR/NOTE-datetime) format.
  final DateTime publishedAt;

  /// The title of the channel that the subscription belongs to.
  final String? channelTitle;

  /// The subscription's title.
  final String title;

  /// The subscription's details.
  final String description;

  /// The id object contains information about the channel that the user
  /// subscribed to.
  final ResourceId resourceId;

  /// The ID that YouTube uses to uniquely identify the subscriber's channel.
  /// The resource_id object identifies the channel that the user subscribed to.
  final String channelId;

  /// A map of thumbnail images associated with the subscription. For each
  /// object in the map, the key is the name of the thumbnail image, and the
  /// value is an object that contains other information about the thumbnail.
  final Thumbnails thumbnails;

  Snippet({
    required this.publishedAt,
    this.channelTitle,
    required this.title,
    required this.description,
    required this.resourceId,
    required this.channelId,
    required this.thumbnails,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);

  Map<String, dynamic> toJson() => _$SnippetToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
