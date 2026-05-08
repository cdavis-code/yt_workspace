// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelItem _$ChannelItemFromJson(Map<String, dynamic> json) => ChannelItem(
  kind: json['kind'] as String,
  etag: json['etag'] as String,
  id: json['id'] as String,
  snippet: json['snippet'] == null
      ? null
      : Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
  contentDetails: json['contentDetails'] == null
      ? null
      : ContentDetails.fromJson(json['contentDetails'] as Map<String, dynamic>),
  statistics: json['statistics'] == null
      ? null
      : Statistics.fromJson(json['statistics'] as Map<String, dynamic>),
  brandingSettings: json['brandingSettings'] == null
      ? null
      : BrandingSettings.fromJson(
          json['brandingSettings'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ChannelItemToJson(ChannelItem instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'id': instance.id,
      'snippet': instance.snippet,
      'contentDetails': instance.contentDetails,
      'statistics': instance.statistics,
      'brandingSettings': instance.brandingSettings,
    };
