// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
  streamStatus: json['streamStatus'] as String,
  healthStatus: HealthStatus.fromJson(
    json['healthStatus'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
  'streamStatus': instance.streamStatus,
  'healthStatus': instance.healthStatus.toJson(),
};
