// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoItem _$VideoItemFromJson(Map<String, dynamic> json) => VideoItem(
  kind: json['kind'] as String,
  etag: json['etag'] as String,
  id: json['id'] as String,
  snippet: json['snippet'] == null
      ? null
      : Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
  status: json['status'] == null
      ? null
      : Status.fromJson(json['status'] as Map<String, dynamic>),
  contentDetails: json['contentDetails'] == null
      ? null
      : ContentDetails.fromJson(json['contentDetails'] as Map<String, dynamic>),
  statistics: json['statistics'] == null
      ? null
      : Statistics.fromJson(json['statistics'] as Map<String, dynamic>),
  player: json['player'] == null
      ? null
      : Player.fromJson(json['player'] as Map<String, dynamic>),
  liveStreamingDetails: json['liveStreamingDetails'] == null
      ? null
      : LiveStreamingDetails.fromJson(
          json['liveStreamingDetails'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$VideoItemToJson(VideoItem instance) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'id': instance.id,
  'snippet': instance.snippet,
  'contentDetails': instance.contentDetails,
  'status': instance.status,
  'statistics': instance.statistics,
  'player': instance.player,
  'liveStreamingDetails': instance.liveStreamingDetails,
};
