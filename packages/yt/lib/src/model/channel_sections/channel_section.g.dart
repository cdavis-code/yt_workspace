// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelSection _$ChannelSectionFromJson(Map<String, dynamic> json) =>
    ChannelSection(
      kind: json['kind'] as String? ?? 'youtube#channelSection',
      etag: json['etag'] as String,
      id: json['id'] as String?,
      snippet: json['snippet'] == null
          ? null
          : ChannelSectionSnippet.fromJson(
              json['snippet'] as Map<String, dynamic>,
            ),
      contentDetails: json['contentDetails'] == null
          ? null
          : ChannelSectionContentDetails.fromJson(
              json['contentDetails'] as Map<String, dynamic>,
            ),
      localizations: (json['localizations'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          k,
          ChannelSectionLocalized.fromJson(e as Map<String, dynamic>),
        ),
      ),
    );

Map<String, dynamic> _$ChannelSectionToJson(ChannelSection instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'id': instance.id,
      'snippet': instance.snippet,
      'contentDetails': instance.contentDetails,
      'localizations': instance.localizations,
    };
