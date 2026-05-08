import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

///The status object contains information about the event's status.
@JsonSerializable(explicitToJson: true)
class Status {
  ///The broadcast's status. The status can be updated using the API's liveBroadcasts.transition method.
  ///
  ///Valid values for this property are:
  ///- complete – The broadcast is finished.
  ///- created – The broadcast has incomplete settings, so it is not ready to transition to a live or testing status, but it has been created and is otherwise valid.
  ///- live – The broadcast is active.
  ///- liveStarting – The broadcast is in the process of transitioning to live status.
  ///- ready – The broadcast settings are complete and the broadcast can transition to a live or testing status.
  ///- revoked – This broadcast was removed by an admin action.
  ///- testStarting – The broadcast is in the process of transitioning to testing status.
  ///- testing – The broadcast is only visible to the partner.
  final String lifeCycleStatus;

  ///The broadcast's privacy status. Note that the broadcast represents exactly one YouTube video, so the privacy settings are identical to those supported for videos. In addition, you can set this field by modifying the broadcast resource or by setting the privacyStatus field of the corresponding video resource.
  ///
  ///Valid values for this property are:
  ///- private
  ///- public
  ///- unlisted
  final String privacyStatus;

  ///The broadcast's recording status.
  ///
  ///Valid values for this property are:
  ///- notRecording
  ///- recorded
  ///- recording
  final String recordingStatus;

  ///This value indicates whether the broadcast is designated as child-directed. This property value is read-only.
  final bool madeForKids;

  ///In a [Broadcast.insert] request, this property allows the channel owner to designate the broadcast as being child-directed. In a [Broadcast.list] request, the property value is only returned if the channel owner authorized the API request.
  final bool selfDeclaredMadeForKids;

  Status({
    required this.lifeCycleStatus,
    required this.privacyStatus,
    required this.recordingStatus,
    required this.madeForKids,
    required this.selfDeclaredMadeForKids,
  });

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
