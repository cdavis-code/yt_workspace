import 'package:json_annotation/json_annotation.dart';

import 'memberships_level_snippet.dart';

part 'memberships_level.g.dart';

@JsonSerializable()
class MembershipsLevel {
  final String kind;
  final String etag;
  final String id;
  final MembershipsLevelSnippet snippet;

  MembershipsLevel({
    this.kind = 'youtube#membershipsLevel',
    required this.etag,
    required this.id,
    required this.snippet,
  });

  factory MembershipsLevel.fromJson(Map<String, dynamic> json) =>
      _$MembershipsLevelFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipsLevelToJson(this);
}