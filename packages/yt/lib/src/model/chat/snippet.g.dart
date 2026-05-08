// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Snippet _$SnippetFromJson(Map<String, dynamic> json) => Snippet(
  type: json['type'] as String?,
  liveChatId: json['liveChatId'] as String?,
  authorChannelId: json['authorChannelId'] as String?,
  publishedAt: json['publishedAt'] == null
      ? null
      : DateTime.parse(json['publishedAt'] as String),
  hasDisplayContent: json['hasDisplayContent'] as bool?,
  displayMessage: json['displayMessage'] as String?,
  textMessageDetails: json['textMessageDetails'] == null
      ? null
      : TextMessageDetails.fromJson(
          json['textMessageDetails'] as Map<String, dynamic>,
        ),
  messageDeletedDetails: json['messageDeletedDetails'] == null
      ? null
      : MessageDeletedDetails.fromJson(
          json['messageDeletedDetails'] as Map<String, dynamic>,
        ),
  userBannedDetails: json['userBannedDetails'] == null
      ? null
      : UserBannedDetails.fromJson(
          json['userBannedDetails'] as Map<String, dynamic>,
        ),
  superChatDetails: json['superChatDetails'] == null
      ? null
      : SuperChatDetails.fromJson(
          json['superChatDetails'] as Map<String, dynamic>,
        ),
  superStickerDetails: json['superStickerDetails'] == null
      ? null
      : SuperStickerDetails.fromJson(
          json['superStickerDetails'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$SnippetToJson(Snippet instance) => <String, dynamic>{
  'type': instance.type,
  'liveChatId': instance.liveChatId,
  'authorChannelId': instance.authorChannelId,
  'publishedAt': instance.publishedAt?.toIso8601String(),
  'hasDisplayContent': instance.hasDisplayContent,
  'displayMessage': instance.displayMessage,
  'textMessageDetails': instance.textMessageDetails?.toJson(),
  'messageDeletedDetails': instance.messageDeletedDetails?.toJson(),
  'userBannedDetails': instance.userBannedDetails?.toJson(),
  'superChatDetails': instance.superChatDetails?.toJson(),
  'superStickerDetails': instance.superStickerDetails?.toJson(),
};
