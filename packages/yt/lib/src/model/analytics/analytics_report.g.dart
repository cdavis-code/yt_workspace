// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyticsReport _$AnalyticsReportFromJson(Map<String, dynamic> json) =>
    AnalyticsReport(
      kind: json['kind'] as String? ?? 'youtubeAnalytics#resultTable',
      columnHeaders: (json['columnHeaders'] as List<dynamic>)
          .map((e) => ColumnHeader.fromJson(e as Map<String, dynamic>))
          .toList(),
      rows: json['rows'] as List<dynamic>,
    );

Map<String, dynamic> _$AnalyticsReportToJson(AnalyticsReport instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'columnHeaders': instance.columnHeaders,
      'rows': instance.rows,
    };

ColumnHeader _$ColumnHeaderFromJson(Map<String, dynamic> json) => ColumnHeader(
  name: json['name'] as String,
  columnType: json['columnType'] as String,
  dataType: json['dataType'] as String,
);

Map<String, dynamic> _$ColumnHeaderToJson(ColumnHeader instance) =>
    <String, dynamic>{
      'name': instance.name,
      'columnType': instance.columnType,
      'dataType': instance.dataType,
    };
