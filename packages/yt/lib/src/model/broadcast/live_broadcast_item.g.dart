// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_broadcast_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveBroadcastItem _$LiveBroadcastItemFromJson(Map<String, dynamic> json) =>
    LiveBroadcastItem(
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
          : ContentDetails.fromJson(
              json['contentDetails'] as Map<String, dynamic>,
            ),
      statistics: json['statistics'] == null
          ? null
          : Statistics.fromJson(json['statistics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LiveBroadcastItemToJson(LiveBroadcastItem instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'id': instance.id,
      'snippet': instance.snippet?.toJson(),
      'status': instance.status?.toJson(),
      'contentDetails': instance.contentDetails?.toJson(),
      'statistics': instance.statistics?.toJson(),
    };
