// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
  kind: json['kind'] as String,
  etag: json['etag'] as String,
  id: json['id'] as String,
  snippet: json['snippet'] == null
      ? null
      : Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'id': instance.id,
  'snippet': instance.snippet,
};
