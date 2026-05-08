import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../thumbnails.dart';

part 'subscriber_snippet.g.dart';

/// The subscriberSnippet object contains basic details about the subscriber.
@JsonSerializable()
class SubscriberSnippet {
  /// The title of the subscriber's channel.
  final String title;

  /// The description of the subscriber's channel.
  final String description;

  /// The ID that YouTube assigns to uniquely identify the subscriber's channel.
  final String channelId;

  /// Thumbnail images for the subscriber's channel.
  final Thumbnails thumbnails;

  SubscriberSnippet({
    required this.title,
    required this.description,
    required this.channelId,
    required this.thumbnails,
  });

  factory SubscriberSnippet.fromJson(Map<String, dynamic> json) =>
      _$SubscriberSnippetFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriberSnippetToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
