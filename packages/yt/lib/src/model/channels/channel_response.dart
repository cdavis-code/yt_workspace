import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../page_info.dart';
import '../list_response.dart';
import 'channel_item.dart';

part 'channel_response.g.dart';

/// A channel resource contains information about a YouTube channel.
@JsonSerializable()
class ChannelResponse extends ListResponse {
  ///Identifies the API resource's type. The value will be youtube#channelListResponse.
  ///A list of channels that match the request criteria.
  @JsonKey(name: 'items')
  final List<ChannelItem>? channelItems;

  ChannelResponse({
    required super.kind,
    required super.etag,
    super.nextPageToken,
    super.prevPageToken,
    required super.pageInfo,
    this.channelItems,
  });

  List<ChannelItem> get items => channelItems ?? [];

  factory ChannelResponse.fromJson(Map<String, dynamic> json) =>
      _$ChannelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
