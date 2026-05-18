// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cuepoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cuepoint _$CuepointFromJson(Map<String, dynamic> json) => Cuepoint(
  id: json['id'] as String?,
  cueType: json['cueType'] as String? ?? 'cueTypeAd',
  durationSecs: (json['durationSecs'] as num?)?.toInt(),
  insertionOffsetTimeMs: (json['insertionOffsetTimeMs'] as num?)?.toInt(),
  walltimeMs: (json['walltimeMs'] as num?)?.toInt(),
);

Map<String, dynamic> _$CuepointToJson(Cuepoint instance) => <String, dynamic>{
  'id': instance.id,
  'cueType': instance.cueType,
  'durationSecs': instance.durationSecs,
  'insertionOffsetTimeMs': instance.insertionOffsetTimeMs,
  'walltimeMs': instance.walltimeMs,
};
