import 'package:json_annotation/json_annotation.dart';

part 'memberships_duration.g.dart';

@JsonSerializable()
class MembershipsDuration {
  @JsonKey(name: 'memberSince')
  final DateTime memberSince;

  @JsonKey(name: 'memberTotalDurationMonths')
  final int memberTotalDurationMonths;

  MembershipsDuration({
    required this.memberSince,
    required this.memberTotalDurationMonths,
  });

  factory MembershipsDuration.fromJson(Map<String, dynamic> json) =>
      _$MembershipsDurationFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipsDurationToJson(this);
}