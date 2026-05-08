import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'rating.g.dart';

@JsonSerializable()
class Rating {
  final String videoId;
  final String rating;

  Rating({required this.videoId, required this.rating});

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  Map<String, dynamic> toJson() => _$RatingToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
