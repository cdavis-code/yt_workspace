import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'content_details.g.dart';

/// The contentDetails object contains basic statistics about the subscription.
@JsonSerializable()
class ContentDetails {
  /// The approximate number of items that the subscription points to.
  final int totalItemCount;

  /// The number of new items in the subscription since its content was last read.
  final int newItemCount;

  /// The type of activity this subscription is for (only uploads, everything).
  ///
  /// Valid values for this property are:
  /// - all
  /// - uploads
  final String activityType;

  ContentDetails({
    required this.totalItemCount,
    required this.newItemCount,
    required this.activityType,
  });

  factory ContentDetails.fromJson(Map<String, dynamic> json) =>
      _$ContentDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ContentDetailsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
