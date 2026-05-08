// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_chat_message_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveChatMessageListResponse _$LiveChatMessageListResponseFromJson(
  Map<String, dynamic> json,
) => LiveChatMessageListResponse(
  kind: json['kind'] as String,
  etag: json['etag'] as String,
  nextPageToken: json['nextPageToken'] as String?,
  pollingIntervalMillis: (json['pollingIntervalMillis'] as num?)?.toInt(),
  offlineAt: json['offlineAt'] == null
      ? null
      : DateTime.parse(json['offlineAt'] as String),
  pageInfo: json['pageInfo'] == null
      ? null
      : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
  liveChatMessageItems: (json['items'] as List<dynamic>?)
      ?.map((e) => LiveChatMessage.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$LiveChatMessageListResponseToJson(
  LiveChatMessageListResponse instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'nextPageToken': instance.nextPageToken,
  'pageInfo': instance.pageInfo,
  'pollingIntervalMillis': instance.pollingIntervalMillis,
  'offlineAt': instance.offlineAt?.toIso8601String(),
  'items': instance.liveChatMessageItems,
};
