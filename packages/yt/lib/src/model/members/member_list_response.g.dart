// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberListResponse _$MemberListResponseFromJson(Map<String, dynamic> json) =>
    MemberListResponse(
      kind: json['kind'] as String? ?? 'youtube#memberListResponse',
      etag: json['etag'] as String,
      nextPageToken: json['nextPageToken'] as String?,
      pageInfo: json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>)
          .map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MemberListResponseToJson(MemberListResponse instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'nextPageToken': instance.nextPageToken,
      'pageInfo': instance.pageInfo,
      'items': instance.items,
    };
