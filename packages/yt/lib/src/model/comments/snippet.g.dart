// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Snippet _$SnippetFromJson(Map<String, dynamic> json) => Snippet(
  authorDisplayName: json['authorDisplayName'] as String,
  authorProfileImageUrl: json['authorProfileImageUrl'] as String,
  authorChannelUrl: json['authorChannelUrl'] as String,
  authorChannelId: AuthorChannelId.fromJson(
    json['authorChannelId'] as Map<String, dynamic>,
  ),
  channelId: json['channelId'] as String?,
  videoId: json['videoId'] as String?,
  textDisplay: json['textDisplay'] as String,
  textOriginal: json['textOriginal'] as String,
  parentId: json['parentId'] as String?,
  canRate: json['canRate'] as bool,
  viewerRating: json['viewerRating'] as String,
  likeCount: (json['likeCount'] as num).toInt(),
  moderationStatus: json['moderationStatus'] as String?,
  publishedAt: DateTime.parse(json['publishedAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$SnippetToJson(Snippet instance) => <String, dynamic>{
  'authorDisplayName': instance.authorDisplayName,
  'authorProfileImageUrl': instance.authorProfileImageUrl,
  'authorChannelUrl': instance.authorChannelUrl,
  'authorChannelId': instance.authorChannelId,
  'channelId': instance.channelId,
  'videoId': instance.videoId,
  'textDisplay': instance.textDisplay,
  'textOriginal': instance.textOriginal,
  'parentId': instance.parentId,
  'canRate': instance.canRate,
  'viewerRating': instance.viewerRating,
  'likeCount': instance.likeCount,
  'moderationStatus': instance.moderationStatus,
  'publishedAt': instance.publishedAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
