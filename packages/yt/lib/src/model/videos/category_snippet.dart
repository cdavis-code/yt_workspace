import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'category_snippet.g.dart';

///The [Snippet] object contains basic details about the video, such as its title, description, and category.
@JsonSerializable(explicitToJson: true)
class CategorySnippet {
  ///The YouTube channel that created the video category.
  final String? channelId;

  ///The video category's title.
  final String title;

  ///Indicates whether videos can be associated with the category.
  final bool assignable;

  CategorySnippet({
    this.channelId,
    required this.title,
    required this.assignable,
  });

  factory CategorySnippet.fromJson(Map<String, dynamic> json) =>
      _$CategorySnippetFromJson(json);

  Map<String, dynamic> toJson() => _$CategorySnippetToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
