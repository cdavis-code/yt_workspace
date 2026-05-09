import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'keyword.g.dart';

@JsonSerializable(explicitToJson: true)
class Keyword {
  final List<List<String>> patterns;
  final int score;

  Keyword({required this.patterns, required this.score});

  factory Keyword.fromJson(Map<String, dynamic> json) =>
      _$KeywordFromJson(json);

  Map<String, dynamic> toJson() => _$KeywordToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
