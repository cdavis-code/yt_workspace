import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../page_info.dart';
import '../list_response.dart';
import 'live_stream_item.dart';

part 'live_stream_list_response.g.dart';

@JsonSerializable()
class LiveStreamListResponse extends ListResponse {
  /// A list of live streams that match the request criteria.
  @JsonKey(name: 'items')
  final List<LiveStreamItem>? liveStreamItems;

  LiveStreamListResponse({
    required super.kind,
    required super.etag,
    super.nextPageToken,
    super.prevPageToken,
    required super.pageInfo,
    this.liveStreamItems,
  });

  List<LiveStreamItem> get items => liveStreamItems ?? [];

  factory LiveStreamListResponse.fromJson(Map<String, dynamic> json) =>
      _$LiveStreamListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LiveStreamListResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
