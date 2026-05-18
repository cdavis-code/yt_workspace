// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_banner_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelBannerResource _$ChannelBannerResourceFromJson(
  Map<String, dynamic> json,
) => ChannelBannerResource(
  kind: json['kind'] as String? ?? 'youtube#channelBannerResource',
  etag: json['etag'] as String?,
  url: json['url'] as String?,
);

Map<String, dynamic> _$ChannelBannerResourceToJson(
  ChannelBannerResource instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'url': instance.url,
};
