import 'package:json_annotation/json_annotation.dart';

part 'analytics_group.g.dart';

@JsonSerializable()
class AnalyticsGroup {
  final String kind;
  final String etag;
  final String id;
  final AnalyticsGroupSnippet snippet;
  final AnalyticsGroupContentDetails? contentDetails;

  AnalyticsGroup({
    this.kind = 'youtubeAnalytics#group',
    required this.etag,
    required this.id,
    required this.snippet,
    this.contentDetails,
  });

  factory AnalyticsGroup.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsGroupFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsGroupToJson(this);
}

@JsonSerializable()
class AnalyticsGroupSnippet {
  final String? publishedAt;
  final String title;

  AnalyticsGroupSnippet({this.publishedAt, required this.title});

  factory AnalyticsGroupSnippet.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsGroupSnippetFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsGroupSnippetToJson(this);
}

@JsonSerializable()
class AnalyticsGroupContentDetails {
  final String itemCount;
  final String itemType;

  AnalyticsGroupContentDetails({
    required this.itemCount,
    required this.itemType,
  });

  factory AnalyticsGroupContentDetails.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsGroupContentDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsGroupContentDetailsToJson(this);
}
