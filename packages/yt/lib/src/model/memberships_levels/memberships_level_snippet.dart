import 'package:json_annotation/json_annotation.dart';

import 'level_details.dart';

part 'memberships_level_snippet.g.dart';

@JsonSerializable()
class MembershipsLevelSnippet {
  @JsonKey(name: 'creatorChannelId')
  final String creatorChannelId;

  @JsonKey(name: 'levelDetails')
  final LevelDetails levelDetails;

  MembershipsLevelSnippet({
    required this.creatorChannelId,
    required this.levelDetails,
  });

  factory MembershipsLevelSnippet.fromJson(Map<String, dynamic> json) =>
      _$MembershipsLevelSnippetFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipsLevelSnippetToJson(this);
}
