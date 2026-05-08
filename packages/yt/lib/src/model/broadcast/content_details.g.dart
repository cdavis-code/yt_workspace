// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentDetails _$ContentDetailsFromJson(Map<String, dynamic> json) =>
    ContentDetails(
      boundStreamId: json['boundStreamId'] as String?,
      boundStreamLastUpdateTimeMs: json['boundStreamLastUpdateTimeMs'] == null
          ? null
          : DateTime.parse(json['boundStreamLastUpdateTimeMs'] as String),
      closedCaptionsType: json['closedCaptionsType'] as String,
      enableAutoStart: json['enableAutoStart'] as bool?,
      enableAutoStop: json['enableAutoStop'] as bool?,
      enableContentEncryption: json['enableContentEncryption'] as bool?,
      enableDvr: json['enableDvr'] as bool?,
      enableEmbed: json['enableEmbed'] as bool?,
      enableLowLatency: json['enableLowLatency'] as bool?,
      latencyPreference: json['latencyPreference'] as String,
      monitorStream: MonitorStream.fromJson(
        json['monitorStream'] as Map<String, dynamic>,
      ),
      projection: json['projection'] as String,
      recordFromStart: json['recordFromStart'] as bool?,
      startWithSlate: json['startWithSlate'] as bool?,
    );

Map<String, dynamic> _$ContentDetailsToJson(ContentDetails instance) =>
    <String, dynamic>{
      'boundStreamId': instance.boundStreamId,
      'boundStreamLastUpdateTimeMs': instance.boundStreamLastUpdateTimeMs
          ?.toIso8601String(),
      'closedCaptionsType': instance.closedCaptionsType,
      'enableAutoStart': instance.enableAutoStart,
      'enableAutoStop': instance.enableAutoStop,
      'enableContentEncryption': instance.enableContentEncryption,
      'enableDvr': instance.enableDvr,
      'enableEmbed': instance.enableEmbed,
      'enableLowLatency': instance.enableLowLatency,
      'latencyPreference': instance.latencyPreference,
      'monitorStream': instance.monitorStream.toJson(),
      'projection': instance.projection,
      'recordFromStart': instance.recordFromStart,
      'startWithSlate': instance.startWithSlate,
    };
