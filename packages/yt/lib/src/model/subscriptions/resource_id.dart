import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'resource_id.g.dart';

/// The id object contains information about the channel that the user subscribed to.
@JsonSerializable()
class ResourceId {
  /// The type of the API resource.
  final String kind;

  /// The value that YouTube uses to uniquely identify the channel that the user subscribed to.
  final String channelId;

  ResourceId({required this.kind, required this.channelId});

  factory ResourceId.fromJson(Map<String, dynamic> json) =>
      _$ResourceIdFromJson(json);

  Map<String, dynamic> toJson() => _$ResourceIdToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
