import 'package:json_annotation/json_annotation.dart';

import 'channel_section.dart';

part 'channel_section_list_response.g.dart';

@JsonSerializable()
class ChannelSectionListResponse {
  final String kind;
  final String etag;
  final List<ChannelSection> items;

  ChannelSectionListResponse({
    this.kind = 'youtube#channelSectionListResponse',
    required this.etag,
    required this.items,
  });

  factory ChannelSectionListResponse.fromJson(Map<String, dynamic> json) =>
      _$ChannelSectionListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelSectionListResponseToJson(this);
}
