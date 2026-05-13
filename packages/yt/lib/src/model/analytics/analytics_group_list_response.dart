import 'package:json_annotation/json_annotation.dart';

import 'analytics_group.dart';

part 'analytics_group_list_response.g.dart';

@JsonSerializable()
class AnalyticsGroupListResponse {
  final String kind;
  final String etag;
  final List<AnalyticsGroup> items;

  AnalyticsGroupListResponse({
    this.kind = 'youtubeAnalytics#groupListResponse',
    required this.etag,
    required this.items,
  });

  factory AnalyticsGroupListResponse.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsGroupListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsGroupListResponseToJson(this);
}
