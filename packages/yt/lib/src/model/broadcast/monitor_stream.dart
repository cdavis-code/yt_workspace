import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'monitor_stream.g.dart';

///The monitorStream object contains information about the monitor stream, which the broadcaster can use to review the event content before the broadcast stream is shown publicly.
@JsonSerializable()
class MonitorStream {
  ///This value determines whether the monitor stream is enabled for the broadcast. If the monitor stream is enabled, then YouTube will broadcast the event content on a special stream intended only for the broadcaster's consumption. The broadcaster can use the stream to review the event content and also to identify the optimal times to insert cuepoints.
  ///
  ///You need to set this value to true if you intend to have a testing stage for your broadcast or if you want to have a broadcast delay for your event. In addition, if this property's value is true, then you must transition your broadcast to the testing state before you can transition it to the live state. (If the property's value is false, your broadcast cannot have a testing stage, so you can transition the broadcast directly to the live state.)
  ///
  ///When you update a broadcast, this property must be set if your API request includes the contentDetails part in the part parameter value. However, when you insert a broadcast, the property is optional and has a default value of true.
  ///
  ///Important: This property cannot be updated once the broadcast is in the testing or live state.
  final bool enableMonitorStream;

  ///If you have set the enableMonitorStream property to true, then this property determines the length of the live broadcast delay.
  ///
  ///When you update a broadcast, this property must be set if your API request includes the contentDetails part in the part parameter value. However, when you insert a broadcast, the property is optional and has a default value of 0. This value indicates that the broadcast does not have a broadcast delay. Note: This property cannot be updated once the broadcast is in the testing or live state.
  final int? broadcastStreamDelayMs;

  ///HTML code that embeds a player that plays the monitor stream.
  final String? embedHtml;

  MonitorStream({
    required this.enableMonitorStream,
    this.broadcastStreamDelayMs,
    this.embedHtml,
  });

  factory MonitorStream.fromJson(Map<String, dynamic> json) =>
      _$MonitorStreamFromJson(json);

  Map<String, dynamic> toJson() => _$MonitorStreamToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
