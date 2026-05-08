// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Statistics _$StatisticsFromJson(Map<String, dynamic> json) => Statistics(
  viewCount: (json['viewCount'] as num).toInt(),
  subscriberCount: (json['subscriberCount'] as num).toInt(),
  hiddenSubscriberCount: json['hiddenSubscriberCount'] as bool,
  videoCount: (json['videoCount'] as num).toInt(),
);

Map<String, dynamic> _$StatisticsToJson(Statistics instance) =>
    <String, dynamic>{
      'viewCount': instance.viewCount,
      'subscriberCount': instance.subscriberCount,
      'hiddenSubscriberCount': instance.hiddenSubscriberCount,
      'videoCount': instance.videoCount,
    };
