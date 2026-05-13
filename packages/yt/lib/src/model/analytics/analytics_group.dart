import 'package:json_annotation/json_annotation.dart';

part 'analytics_group.g.dart';

@JsonSerializable()
class AnalyticsGroup {
  final String kind;
  final String etag;
  final String id;
  final AnalyticsGroupSnippet snippet;

  AnalyticsGroup({
    this.kind = 'youtubeAnalytics#group',
    required this.etag,
    required this.id,
    required this.snippet,
  });

  factory AnalyticsGroup.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsGroupFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsGroupToJson(this);
}

@JsonSerializable()
class AnalyticsGroupSnippet {
  final String title;

  AnalyticsGroupSnippet({required this.title});

  factory AnalyticsGroupSnippet.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsGroupSnippetFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsGroupSnippetToJson(this);
}
