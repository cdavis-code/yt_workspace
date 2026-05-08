// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_thread_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentThreadListResponse _$CommentThreadListResponseFromJson(
  Map<String, dynamic> json,
) => CommentThreadListResponse(
  kind: json['kind'] as String,
  etag: json['etag'] as String,
  nextPageToken: json['nextPageToken'] as String?,
  prevPageToken: json['prevPageToken'] as String?,
  pageInfo: json['pageInfo'] == null
      ? null
      : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
  commentThreadItems: (json['items'] as List<dynamic>?)
      ?.map((e) => CommentThread.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CommentThreadListResponseToJson(
  CommentThreadListResponse instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'nextPageToken': instance.nextPageToken,
  'prevPageToken': instance.prevPageToken,
  'pageInfo': instance.pageInfo,
  'items': instance.commentThreadItems,
};
