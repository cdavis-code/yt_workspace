import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../thumbnails.dart';

part 'snippet.g.dart';

@JsonSerializable(explicitToJson: true)
class Snippet {
  final DateTime publishedAt;
  final String channelId;
  final String title;
  final String description;
  final Thumbnails thumbnails;
  final String channelTitle;
  final String liveBroadcastContent;
  final DateTime publishTime;

  Snippet({
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.description,
    required this.thumbnails,
    required this.channelTitle,
    required this.liveBroadcastContent,
    required this.publishTime,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);

  Map<String, dynamic> toJson() => _$SnippetToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
