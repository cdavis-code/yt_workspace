// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Snippet _$SnippetFromJson(Map<String, dynamic> json) => Snippet(
  channelId: json['channelId'] as String?,
  videoId: json['videoId'] as String,
  topLevelComment: Comment.fromJson(
    json['topLevelComment'] as Map<String, dynamic>,
  ),
  canReply: json['canReply'] as bool,
  totalReplyCount: (json['totalReplyCount'] as num).toInt(),
  isPublic: json['isPublic'] as bool,
  replies: json['replies'] == null
      ? null
      : Replies.fromJson(json['replies'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SnippetToJson(Snippet instance) => <String, dynamic>{
  'channelId': instance.channelId,
  'videoId': instance.videoId,
  'topLevelComment': instance.topLevelComment,
  'canReply': instance.canReply,
  'totalReplyCount': instance.totalReplyCount,
  'isPublic': instance.isPublic,
  'replies': instance.replies,
};
