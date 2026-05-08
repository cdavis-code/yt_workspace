// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
  kind: json['kind'] as String,
  etag: json['etag'] as String,
  id: json['id'] as String,
  snippet: json['snippet'] == null
      ? null
      : Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
  contentDetails: json['contentDetails'] == null
      ? null
      : ContentDetails.fromJson(json['contentDetails'] as Map<String, dynamic>),
  subscriberSnippet: json['subscriberSnippet'] == null
      ? null
      : SubscriberSnippet.fromJson(
          json['subscriberSnippet'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'id': instance.id,
      'snippet': instance.snippet,
      'contentDetails': instance.contentDetails,
      'subscriberSnippet': instance.subscriberSnippet,
    };
