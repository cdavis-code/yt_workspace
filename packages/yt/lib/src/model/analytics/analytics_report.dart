import 'package:json_annotation/json_annotation.dart';

part 'analytics_report.g.dart';

@JsonSerializable()
class AnalyticsReport {
  final String kind;
  final List<ColumnHeader> columnHeaders;
  final List<dynamic> rows;

  AnalyticsReport({
    this.kind = 'youtubeAnalytics#resultTable',
    required this.columnHeaders,
    required this.rows,
  });

  factory AnalyticsReport.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsReportFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsReportToJson(this);
}

@JsonSerializable()
class ColumnHeader {
  final String name;
  final String columnType;
  final String dataType;

  ColumnHeader({
    required this.name,
    required this.columnType,
    required this.dataType,
  });

  factory ColumnHeader.fromJson(Map<String, dynamic> json) =>
      _$ColumnHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$ColumnHeaderToJson(this);
}
