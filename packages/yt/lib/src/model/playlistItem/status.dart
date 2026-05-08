import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

///The status object contains information about the playlist item's privacy status.
@JsonSerializable()
class Status {
  ///The playlist item's privacy status. The channel that uploaded the video that the playlist item represents can set this value using either the videos.insert or videos.update method.
  final String privacyStatus;

  Status({required this.privacyStatus});

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
