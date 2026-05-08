// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionListResponse _$SubscriptionListResponseFromJson(
  Map<String, dynamic> json,
) => SubscriptionListResponse(
  kind: json['kind'] as String,
  etag: json['etag'] as String,
  nextPageToken: json['nextPageToken'] as String?,
  prevPageToken: json['prevPageToken'] as String?,
  pageInfo: json['pageInfo'] == null
      ? null
      : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
  subscriptionItems: (json['items'] as List<dynamic>?)
      ?.map((e) => Subscription.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SubscriptionListResponseToJson(
  SubscriptionListResponse instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'etag': instance.etag,
  'nextPageToken': instance.nextPageToken,
  'prevPageToken': instance.prevPageToken,
  'pageInfo': instance.pageInfo,
  'items': instance.subscriptionItems,
};
