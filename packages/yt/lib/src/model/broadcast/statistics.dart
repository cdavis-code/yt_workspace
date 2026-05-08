import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'statistics.g.dart';

///The statistics object contains statistics related to a live broadcast. The values for these statistics can change during the broadcast and can only be retrieved while the broadcast is live.
@JsonSerializable()
class Statistics {
  ///The total number of live chat messages associated with the broadcast. The property and its value are present if the broadcast is visible to the user, has the live chat feature enabled, and has at least one message. Note that this property will not specify a value after the broadcast ends. So, this property would not identify the number of chat messages for an archived video of a completed live broadcast.
  final int? totalChatCount;

  Statistics({this.totalChatCount});

  factory Statistics.fromJson(Map<String, dynamic> json) =>
      _$StatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
