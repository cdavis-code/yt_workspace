// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_section_content_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelSectionContentDetails _$ChannelSectionContentDetailsFromJson(
  Map<String, dynamic> json,
) => ChannelSectionContentDetails(
  playlists: (json['playlists'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  channels: (json['channels'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$ChannelSectionContentDetailsToJson(
  ChannelSectionContentDetails instance,
) => <String, dynamic>{
  'playlists': instance.playlists,
  'channels': instance.channels,
};
