// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingestion_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngestionInfo _$IngestionInfoFromJson(Map<String, dynamic> json) =>
    IngestionInfo(
      streamName: json['streamName'] as String,
      ingestionAddress: json['ingestionAddress'] as String,
      backupIngestionAddress: json['backupIngestionAddress'] as String,
      rtmpsIngestionAddress: json['rtmpsIngestionAddress'] as String,
      rtmpsBackupIngestionAddress:
          json['rtmpsBackupIngestionAddress'] as String,
    );

Map<String, dynamic> _$IngestionInfoToJson(IngestionInfo instance) =>
    <String, dynamic>{
      'streamName': instance.streamName,
      'ingestionAddress': instance.ingestionAddress,
      'backupIngestionAddress': instance.backupIngestionAddress,
      'rtmpsIngestionAddress': instance.rtmpsIngestionAddress,
      'rtmpsBackupIngestionAddress': instance.rtmpsBackupIngestionAddress,
    };
