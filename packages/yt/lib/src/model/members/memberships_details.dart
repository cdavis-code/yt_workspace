import 'package:json_annotation/json_annotation.dart';

import 'memberships_duration.dart';
import 'memberships_duration_at_level.dart';

part 'memberships_details.g.dart';

@JsonSerializable()
class MembershipsDetails {
  @JsonKey(name: 'highestAccessibleLevel')
  final String highestAccessibleLevel;

  @JsonKey(name: 'highestAccessibleLevelDisplayName')
  final String highestAccessibleLevelDisplayName;

  @JsonKey(name: 'accessibleLevels')
  final List<String> accessibleLevels;

  @JsonKey(name: 'membershipsDuration')
  final MembershipsDuration membershipsDuration;

  @JsonKey(name: 'membershipsDurationAtLevel')
  final List<MembershipsDurationAtLevel> membershipsDurationAtLevel;

  MembershipsDetails({
    required this.highestAccessibleLevel,
    required this.highestAccessibleLevelDisplayName,
    required this.accessibleLevels,
    required this.membershipsDuration,
    required this.membershipsDurationAtLevel,
  });

  factory MembershipsDetails.fromJson(Map<String, dynamic> json) =>
      _$MembershipsDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipsDetailsToJson(this);
}