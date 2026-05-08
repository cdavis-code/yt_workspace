import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../localized.dart';
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
  final String? defaultLanguage;
  final Localized localized;

  Snippet({
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.description,
    required this.thumbnails,
    required this.channelTitle,
    this.defaultLanguage,
    required this.localized,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);

  Map<String, dynamic> toJson() => _$SnippetToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
