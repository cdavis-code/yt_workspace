import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../response_metadata.dart';
import 'rating.dart';

part 'video_get_rating_response.g.dart';

@JsonSerializable()
class VideoGetRatingResponse extends ResponseMetadata {
  /// A list of ratings that match the request criteria.
  @JsonKey(name: 'items')
  final List<Rating>? ratingItems;

  VideoGetRatingResponse({
    required super.kind,
    required super.etag,
    this.ratingItems,
  });

  List<Rating> get items => ratingItems ?? [];

  factory VideoGetRatingResponse.fromJson(Map<String, dynamic> json) =>
      _$VideoGetRatingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VideoGetRatingResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
