import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'statistics.g.dart';

@JsonSerializable()
class Statistics {
  final int? viewCount;
  final int? likeCount;
  final int? dislikeCount;
  final int? favoriteCount;
  final int? commentCount;

  Statistics({
    this.viewCount,
    this.likeCount,
    this.dislikeCount,
    this.favoriteCount,
    this.commentCount,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) =>
      _$StatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
