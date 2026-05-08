// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Statistics _$StatisticsFromJson(Map<String, dynamic> json) => Statistics(
  viewCount: (json['viewCount'] as num?)?.toInt(),
  likeCount: (json['likeCount'] as num?)?.toInt(),
  dislikeCount: (json['dislikeCount'] as num?)?.toInt(),
  favoriteCount: (json['favoriteCount'] as num?)?.toInt(),
  commentCount: (json['commentCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$StatisticsToJson(Statistics instance) =>
    <String, dynamic>{
      'viewCount': instance.viewCount,
      'likeCount': instance.likeCount,
      'dislikeCount': instance.dislikeCount,
      'favoriteCount': instance.favoriteCount,
      'commentCount': instance.commentCount,
    };
