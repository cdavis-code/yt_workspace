import 'package:json_annotation/json_annotation.dart';

import 'member_details.dart';
import 'memberships_details.dart';

part 'member_snippet.g.dart';

@JsonSerializable()
class MemberSnippet {
  @JsonKey(name: 'creatorChannelId')
  final String creatorChannelId;

  @JsonKey(name: 'memberDetails')
  final MemberDetails? memberDetails;

  @JsonKey(name: 'membershipsDetails')
  final MembershipsDetails membershipsDetails;

  MemberSnippet({
    required this.creatorChannelId,
    this.memberDetails,
    required this.membershipsDetails,
  });

  factory MemberSnippet.fromJson(Map<String, dynamic> json) =>
      _$MemberSnippetFromJson(json);

  Map<String, dynamic> toJson() => _$MemberSnippetToJson(this);
}
