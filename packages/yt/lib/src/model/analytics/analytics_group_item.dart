import 'package:json_annotation/json_annotation.dart';

part 'analytics_group_item.g.dart';

@JsonSerializable()
class AnalyticsGroupItem {
  final String kind;
  final String etag;
  final String id;
  final String groupId;
  final AnalyticsGroupItemResource resource;

  AnalyticsGroupItem({
    this.kind = 'youtubeAnalytics#groupItem',
    required this.etag,
    required this.id,
    required this.groupId,
    required this.resource,
  });

  factory AnalyticsGroupItem.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsGroupItemFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsGroupItemToJson(this);
}

@JsonSerializable()
class AnalyticsGroupItemResource {
  final String id;
  final String kind;

  AnalyticsGroupItemResource({required this.id, required this.kind});

  factory AnalyticsGroupItemResource.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsGroupItemResourceFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsGroupItemResourceToJson(this);
}
