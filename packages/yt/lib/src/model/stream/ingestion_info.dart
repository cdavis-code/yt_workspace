import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'ingestion_info.g.dart';

@JsonSerializable()
class IngestionInfo {
  final String streamName;
  final String ingestionAddress;
  final String backupIngestionAddress;
  final String rtmpsIngestionAddress;
  final String rtmpsBackupIngestionAddress;

  IngestionInfo({
    required this.streamName,
    required this.ingestionAddress,
    required this.backupIngestionAddress,
    required this.rtmpsIngestionAddress,
    required this.rtmpsBackupIngestionAddress,
  });

  factory IngestionInfo.fromJson(Map<String, dynamic> json) =>
      _$IngestionInfoFromJson(json);

  Map<String, dynamic> toJson() => _$IngestionInfoToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
