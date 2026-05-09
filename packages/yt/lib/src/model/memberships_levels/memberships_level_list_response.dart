import 'package:json_annotation/json_annotation.dart';

import 'memberships_level.dart';

part 'memberships_level_list_response.g.dart';

@JsonSerializable()
class MembershipsLevelListResponse {
  final String kind;
  final String etag;
  final List<MembershipsLevel> items;

  MembershipsLevelListResponse({
    this.kind = 'youtube#membershipsLevelListResponse',
    required this.etag,
    required this.items,
  });

  factory MembershipsLevelListResponse.fromJson(Map<String, dynamic> json) =>
      _$MembershipsLevelListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipsLevelListResponseToJson(this);
}