import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'content_details.g.dart';

@JsonSerializable(explicitToJson: true)
class ContentDetails {
  final String duration;
  final String dimension;
  final String definition;
  final String caption;
  final bool licensedContent;
  final Map<String, dynamic>? regionRestriction;

  ContentDetails({
    required this.duration,
    required this.dimension,
    required this.definition,
    required this.caption,
    required this.licensedContent,
    this.regionRestriction,
  });

  factory ContentDetails.fromJson(Map<String, dynamic> json) =>
      _$ContentDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ContentDetailsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
