import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'statistics.g.dart';

///The [Statistics] object encapsulates statistics for the channel.
@JsonSerializable()
class Statistics {
  ///The number of times the channel has been viewed.
  final int viewCount;

  ///The number of subscribers that the channel has. This value is rounded down to three significant figures. Please see the Revision History or the YouTube Help Center for more details about how subscriber counts are rounded.
  final int subscriberCount;

  ///Indicates whether the channel's subscriber count is publicly visible.
  final bool hiddenSubscriberCount;

  ///The number of public videos uploaded to the channel. Note that the value reflects the count of the channel's public videos only, even to owners. This behavior is consistent with counts shown on the YouTube website.
  final int videoCount;

  Statistics({
    required this.viewCount,
    required this.subscriberCount,
    required this.hiddenSubscriberCount,
    required this.videoCount,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) =>
      _$StatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
