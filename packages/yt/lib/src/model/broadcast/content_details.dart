import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'monitor_stream.dart';

part 'content_details.g.dart';

/// The contentDetails object contains information about the event's video content, such as whether the content can be shown in an embedded video player or if it will be archived and therefore available for viewing after the event has concluded.
@JsonSerializable(explicitToJson: true)
class ContentDetails {
  /// This value uniquely identifies the live stream bound to the broadcast.
  final String? boundStreamId;

  /// The date and time that the live stream referenced by boundStreamId was last updated.
  final DateTime? boundStreamLastUpdateTimeMs;

  /// Note: This property replaces the contentDetails.enableClosedCaptions property.
  ///
  /// This property indicates whether closed captioning is enabled for your broadcast and, if so, what type of closed captions you are providing:
  /// - closedCaptionsDisabled: Closed captions are disabled for the live broadcast.
  /// - closedCaptionsHttpPost: You will send captions, via HTTP POST, to an ingestion URL associated with your live stream.
  /// - closedCaptionsEmbedded: Captions will be encoded in the video stream using EIA-608 and/or CEA-708 formats.
  final String closedCaptionsType;

  /// Indicates whether this broadcast should start automatically when you start streaming video on the bound live stream.
  final bool? enableAutoStart;

  /// Indicates whether this broadcast should stop automatically around one minute after the channel owner stops streaming video on the bound video stream.
  final bool? enableAutoStop;

  /// This setting indicates whether YouTube should enable content encryption for the broadcast.
  ///
  /// When you update a broadcast, this property must be set if your API request includes the contentDetails part in the part parameter value. However, when you insert a broadcast, the property is optional and has a default value of false.
  ///
  /// Note: This property cannot be updated once the broadcast is in the testing or live state.
  final bool? enableContentEncryption;

  /// This setting determines whether viewers can access DVR controls while watching the video. DVR controls enable the viewer to control the video playback experience by pausing, rewinding, or fast forwarding content. The default value for this property is true.
  ///
  /// When you update a broadcast, this property must be set if your API request includes the contentDetails part in the part parameter value. However, when you insert a broadcast, the property is optional and has a default value of true.
  ///
  /// Important: You must set the value to true and also set the enableArchive property's value to true if you want to make playback available immediately after the broadcast ends. In addition, this property cannot be updated once the broadcast is in the testing or live state.
  final bool? enableDvr;

  /// This setting indicates whether the broadcast video can be played in an embedded player. If you choose to archive the video (using the enableArchive property), this setting will also apply to the archived video.
  ///
  /// When you update a broadcast, this property must be set if your API request includes the contentDetails part in the part parameter value. However, when you insert a broadcast, the property is optional and has a default value of true.
  ///
  /// Note: This property cannot be updated once the broadcast is in the testing or live state.
  final bool? enableEmbed;

  /// Indicates whether this broadcast should be encoded for low-latency streaming. A low-latency stream can reduce the amount of time it takes for video to be visible to users watching a broadcast, though it can also impact the resolution for viewers of the stream.
  final bool? enableLowLatency;

  /// Indicates which latency setting to use for this broadcast. This property may be used instead of enableLowLatency, which does not support ultraLow.
  ///
  /// A low-latency stream can reduce the amount of time it takes for video to be visible to users watching a broadcast, though it can also affect the smoothness of playback.
  ///
  /// An ultra-low-latency stream further reduces the time it takes for video to be visible to viewers, making interaction with viewers easier, but ultra-low latency does not support closed captions, or resolutions higher than 1080p.
  ///
  /// Valid values for this property are:
  /// - normal
  /// - low
  /// - ultraLow
  final String latencyPreference;

  /// The monitorStream object contains information about the monitor stream, which the broadcaster can use to review the event content before the broadcast stream is shown publicly.
  final MonitorStream monitorStream;

  /// The projection format of this broadcast. The property's default value is rectangular.
  ///
  /// Valid values for this property are:
  /// - 360
  /// - rectangular
  final String projection;

  /// This setting indicates whether YouTube will automatically start recording the broadcast after the event's status changes to live.
  ///
  /// This property's default value is true, and it can only be set to false if the broadcasting channel is allowed to disable recordings for live broadcasts.
  ///
  /// If your channel does not have permission to disable recordings, and you attempt to insert a broadcast with the recordFromStart property set to false, the API will return a Forbidden error. In addition, if your channel does not have that permission and you attempt to update a broadcast to set the recordFromStart property to false, the API will return a modificationNotAllowed error.
  ///
  /// When you update a broadcast, this property must be set if your API request includes the contentDetails part in the part parameter value. However, when you insert a broadcast, the property is optional and has a default value of true.
  ///
  /// Important: You must also set the enableDvr property's value to true if you want the playback to be available immediately after the broadcast ends. If you set this property's value to true but do not also set the enableDvr property to true, there may be a delay of around one day before the archived video will be available for playback.
  ///
  /// Note: This property cannot be updated once the broadcast is in the testing or live state.
  final bool? recordFromStart;

  /// This setting indicates whether the broadcast should automatically begin with an in-stream slate when you update the broadcast's status to live. After updating the status, you then need to send a liveCuepoints.insert request that sets the cuepoint's eventState to end to remove the slate and make your broadcast stream visible to viewers. When you update a broadcast, this property must be set if your API request includes the contentDetails part in the part parameter value. However, when you insert a broadcast, the property is optional and has a default value of false.
  ///
  /// Note: This property cannot be updated once the broadcast is in the testing or live state.
  final bool? startWithSlate;

  ContentDetails({
    this.boundStreamId,
    this.boundStreamLastUpdateTimeMs,
    required this.closedCaptionsType,
    this.enableAutoStart,
    this.enableAutoStop,
    this.enableContentEncryption,
    this.enableDvr,
    this.enableEmbed,
    this.enableLowLatency,
    required this.latencyPreference,
    required this.monitorStream,
    required this.projection,
    this.recordFromStart,
    this.startWithSlate,
  });

  factory ContentDetails.fromJson(Map<String, dynamic> json) =>
      _$ContentDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ContentDetailsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
