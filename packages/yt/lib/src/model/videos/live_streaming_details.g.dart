// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_streaming_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveStreamingDetails _$LiveStreamingDetailsFromJson(
  Map<String, dynamic> json,
) => LiveStreamingDetails(
  actualStartTime: DateTime.parse(json['actualStartTime'] as String),
  actualEndTime: json['actualEndTime'] == null
      ? null
      : DateTime.parse(json['actualEndTime'] as String),
  scheduledStartTime: DateTime.parse(json['scheduledStartTime'] as String),
  scheduledEndTime: DateTime.parse(json['scheduledEndTime'] as String),
  concurrentViewers: (json['concurrentViewers'] as num).toInt(),
  activeLiveChatId: json['activeLiveChatId'] as String?,
);

Map<String, dynamic> _$LiveStreamingDetailsToJson(
  LiveStreamingDetails instance,
) => <String, dynamic>{
  'actualStartTime': instance.actualStartTime.toIso8601String(),
  'actualEndTime': instance.actualEndTime?.toIso8601String(),
  'scheduledStartTime': instance.scheduledStartTime.toIso8601String(),
  'scheduledEndTime': instance.scheduledEndTime.toIso8601String(),
  'concurrentViewers': instance.concurrentViewers,
  'activeLiveChatId': instance.activeLiveChatId,
};
