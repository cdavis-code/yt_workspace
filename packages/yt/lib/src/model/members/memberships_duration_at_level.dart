import 'package:json_annotation/json_annotation.dart';

part 'memberships_duration_at_level.g.dart';

@JsonSerializable()
class MembershipsDurationAtLevel {
  final String level;

  @JsonKey(name: 'memberSince')
  final DateTime memberSince;

  @JsonKey(name: 'memberTotalDurationMonths')
  final int memberTotalDurationMonths;

  MembershipsDurationAtLevel({
    required this.level,
    required this.memberSince,
    required this.memberTotalDurationMonths,
  });

  factory MembershipsDurationAtLevel.fromJson(Map<String, dynamic> json) =>
      _$MembershipsDurationAtLevelFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipsDurationAtLevelToJson(this);
}
