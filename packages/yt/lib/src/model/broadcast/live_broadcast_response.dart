import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../page_info.dart';
import '../list_response.dart';
import 'live_broadcast_item.dart';

part 'live_broadcast_response.g.dart';

///LiveBroadcastResponse
@JsonSerializable(explicitToJson: true)
class LiveBroadcastResponse extends ListResponse {
  ///A list of broadcasts that match the request criteria.
  @JsonKey(name: 'items')
  final List<LiveBroadcastItem>? broadcastItems;

  LiveBroadcastResponse({
    required super.kind,
    required super.etag,
    super.nextPageToken,
    super.prevPageToken,
    required super.pageInfo,
    this.broadcastItems,
  });

  List<LiveBroadcastItem> get items => broadcastItems ?? [];

  factory LiveBroadcastResponse.fromJson(Map<String, dynamic> json) =>
      _$LiveBroadcastResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LiveBroadcastResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());

  static LiveBroadcastItem closestTo(
    List<LiveBroadcastItem> items, {
    DateTime? dateTime,
  }) {
    final check = dateTime ?? DateTime.now().toUtc();

    return items.reduce((a, b) {
      print(
        'a: ${a.defaultStartTime().difference(check).abs().inSeconds}, b: ${b.defaultStartTime().difference(check).abs().inSeconds}',
      );

      return a.defaultStartTime().difference(check).abs() <
              b.defaultStartTime().difference(check).abs()
          ? a
          : b;
    });
  }
}
