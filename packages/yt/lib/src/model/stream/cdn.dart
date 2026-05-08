import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'ingestion_info.dart';

part 'cdn.g.dart';

@JsonSerializable(explicitToJson: true)
class Cdn {
  final String ingestionType;
  final IngestionInfo ingestionInfo;
  final String resolution;
  final String frameRate;

  Cdn({
    required this.ingestionType,
    required this.ingestionInfo,
    required this.resolution,
    required this.frameRate,
  });

  factory Cdn.fromJson(Map<String, dynamic> json) => _$CdnFromJson(json);

  Map<String, dynamic> toJson() => _$CdnToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
