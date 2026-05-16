import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../page_info.dart';
import '../list_response.dart';
import 'activity.dart';

part 'activity_list_response.g.dart';

/// Returns a collection of YouTube activity events that match the request criteria.
@JsonSerializable()
class ActivityListResponse extends ListResponse {
  /// A list of activities, or events, that match the request criteria.
  @JsonKey(name: 'items')
  final List<Activity>? activityItems;

  ActivityListResponse({
    required super.kind,
    required super.etag,
    super.nextPageToken,
    super.prevPageToken,
    required super.pageInfo,
    this.activityItems,
  });

  List<Activity> get items => activityItems ?? [];

  factory ActivityListResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivityListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityListResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
