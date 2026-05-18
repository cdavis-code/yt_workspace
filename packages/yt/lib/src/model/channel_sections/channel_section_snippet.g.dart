// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_section_snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelSectionSnippet _$ChannelSectionSnippetFromJson(
  Map<String, dynamic> json,
) => ChannelSectionSnippet(
  type: json['type'] as String?,
  style: json['style'] as String?,
  channelId: json['channelId'] as String?,
  title: json['title'] as String?,
  position: (json['position'] as num?)?.toInt(),
  defaultLanguage: json['defaultLanguage'] as String?,
  localized: json['localized'] == null
      ? null
      : ChannelSectionLocalized.fromJson(
          json['localized'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ChannelSectionSnippetToJson(
  ChannelSectionSnippet instance,
) => <String, dynamic>{
  'type': instance.type,
  'style': instance.style,
  'channelId': instance.channelId,
  'title': instance.title,
  'position': instance.position,
  'defaultLanguage': instance.defaultLanguage,
  'localized': instance.localized,
};
