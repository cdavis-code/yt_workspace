// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_section_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelSectionListResponse _$ChannelSectionListResponseFromJson(
  Map<String, dynamic> json,
) => ChannelSectionListResponse(
  kind: json['kind'] as String? ?? 'youtube#channelSectionListResponse',
  etag: json['etag'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => ChannelSection.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ChannelSectionListResponseToJson(
  ChannelSectionListResponse instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'items': instance.items,
};
