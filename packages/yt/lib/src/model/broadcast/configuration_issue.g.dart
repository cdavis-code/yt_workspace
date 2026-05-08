// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigurationIssue _$ConfigurationIssueFromJson(Map<String, dynamic> json) =>
    ConfigurationIssue(
      type: json['type'] as String?,
      severity: json['severity'] as String?,
      reason: json['reason'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ConfigurationIssueToJson(ConfigurationIssue instance) =>
    <String, dynamic>{
      'type': instance.type,
      'severity': instance.severity,
      'reason': instance.reason,
      'description': instance.description,
    };
