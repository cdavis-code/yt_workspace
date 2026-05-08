import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'resource_id.g.dart';

///The id object contains information that can be used to uniquely identify the resource that is included in the playlist as the playlist item.
@JsonSerializable()
class ResourceId {
  ///The kind, or type, of the referred resource.
  final String kind;

  ///If the snippet.resourceId.kind property's value is youtube#video, then this property will be present and its value will contain the ID that YouTube uses to uniquely identify the video in the playlist.
  final String videoId;

  ResourceId({required this.kind, required this.videoId});

  factory ResourceId.fromJson(Map<String, dynamic> json) =>
      _$ResourceIdFromJson(json);

  Map<String, dynamic> toJson() => _$ResourceIdToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
