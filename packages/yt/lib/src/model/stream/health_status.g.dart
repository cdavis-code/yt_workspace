// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthStatus _$HealthStatusFromJson(Map<String, dynamic> json) => HealthStatus(
  status: json['status'] as String,
  lastUpdateTimeSeconds: (json['lastUpdateTimeSeconds'] as num?)?.toInt(),
  configurationIssues: (json['configurationIssues'] as List<dynamic>?)
      ?.map((e) => ConfigurationIssue.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$HealthStatusToJson(HealthStatus instance) =>
    <String, dynamic>{
      'status': instance.status,
      'lastUpdateTimeSeconds': instance.lastUpdateTimeSeconds,
      'configurationIssues': instance.configurationIssues
          ?.map((e) => e.toJson())
          .toList(),
    };
