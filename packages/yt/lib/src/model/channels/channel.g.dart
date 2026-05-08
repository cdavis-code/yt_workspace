// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Channel _$ChannelFromJson(Map<String, dynamic> json) => Channel(
  title: json['title'] as String,
  description: json['description'] as String,
  keywords: json['keywords'] as String?,
  trackingAnalyticsAccountId: json['trackingAnalyticsAccountId'] as String?,
  moderateComments: json['moderateComments'] as bool? ?? false,
  unsubscribedTrailer: json['unsubscribedTrailer'] as String?,
  defaultLanguage: json['defaultLanguage'] as String?,
  country: json['country'] as String?,
);

Map<String, dynamic> _$ChannelToJson(Channel instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'keywords': instance.keywords,
  'trackingAnalyticsAccountId': instance.trackingAnalyticsAccountId,
  'moderateComments': instance.moderateComments,
  'unsubscribedTrailer': instance.unsubscribedTrailer,
  'defaultLanguage': instance.defaultLanguage,
  'country': instance.country,
};
