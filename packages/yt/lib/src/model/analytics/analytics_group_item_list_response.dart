import 'package:json_annotation/json_annotation.dart';

import 'analytics_group_item.dart';

part 'analytics_group_item_list_response.g.dart';

@JsonSerializable()
class AnalyticsGroupItemListResponse {
  final String kind;
  final String etag;
  final List<AnalyticsGroupItem> items;

  AnalyticsGroupItemListResponse({
    this.kind = 'youtubeAnalytics#groupItemListResponse',
    required this.etag,
    required this.items,
  });

  factory AnalyticsGroupItemListResponse.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsGroupItemListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsGroupItemListResponseToJson(this);
}
