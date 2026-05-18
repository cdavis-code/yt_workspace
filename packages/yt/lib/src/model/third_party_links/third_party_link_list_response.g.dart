// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'third_party_link_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThirdPartyLinkListResponse _$ThirdPartyLinkListResponseFromJson(
  Map<String, dynamic> json,
) => ThirdPartyLinkListResponse(
  kind: json['kind'] as String? ?? 'youtube#thirdPartyLinkListResponse',
  etag: json['etag'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => ThirdPartyLink.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ThirdPartyLinkListResponseToJson(
  ThirdPartyLinkListResponse instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'items': instance.items,
};
