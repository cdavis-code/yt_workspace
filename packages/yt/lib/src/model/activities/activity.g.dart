// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
  kind: json['kind'] as String,
  etag: json['etag'] as String,
  id: json['id'] as String,
  snippet: json['snippet'] == null
      ? null
      : ActivitySnippet.fromJson(json['snippet'] as Map<String, dynamic>),
  contentDetails: json['contentDetails'] == null
      ? null
      : ActivityContentDetails.fromJson(
          json['contentDetails'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'id': instance.id,
  'snippet': instance.snippet,
  'contentDetails': instance.contentDetails,
};
