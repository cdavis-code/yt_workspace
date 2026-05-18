// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'third_party_link_snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThirdPartyLinkSnippet _$ThirdPartyLinkSnippetFromJson(
  Map<String, dynamic> json,
) => ThirdPartyLinkSnippet(
  type: json['type'] as String?,
  channelToStoreLink: json['channelToStoreLink'] == null
      ? null
      : ChannelToStoreLink.fromJson(
          json['channelToStoreLink'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ThirdPartyLinkSnippetToJson(
  ThirdPartyLinkSnippet instance,
) => <String, dynamic>{
  'type': instance.type,
  'channelToStoreLink': instance.channelToStoreLink,
};
