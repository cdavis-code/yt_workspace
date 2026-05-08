import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../page_info.dart';
import '../list_response.dart';
import 'subscription.dart';

part 'subscription_list_response.g.dart';

/// Returns subscription resources that match the API request criteria.
@JsonSerializable()
class SubscriptionListResponse extends ListResponse {
  /// A list of subscriptions that match the request criteria.
  @JsonKey(name: 'items')
  final List<Subscription>? subscriptionItems;

  SubscriptionListResponse({
    required super.kind,
    required super.etag,
    super.nextPageToken,
    super.prevPageToken,
    required super.pageInfo,
    this.subscriptionItems,
  });

  List<Subscription> get items => subscriptionItems ?? [];

  factory SubscriptionListResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionListResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
