// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentThread _$CommentThreadFromJson(Map<String, dynamic> json) =>
    CommentThread(
      kind: json['kind'] as String,
      etag: json['etag'] as String,
      id: json['id'] as String,
      snippet: json['snippet'] == null
          ? null
          : Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentThreadToJson(CommentThread instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'id': instance.id,
      'snippet': instance.snippet,
    };
