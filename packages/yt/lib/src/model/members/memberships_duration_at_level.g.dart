// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memberships_duration_at_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembershipsDurationAtLevel _$MembershipsDurationAtLevelFromJson(
  Map<String, dynamic> json,
) => MembershipsDurationAtLevel(
  level: json['level'] as String,
  memberSince: DateTime.parse(json['memberSince'] as String),
  memberTotalDurationMonths: (json['memberTotalDurationMonths'] as num).toInt(),
);

Map<String, dynamic> _$MembershipsDurationAtLevelToJson(
  MembershipsDurationAtLevel instance,
) => <String, dynamic>{
  'level': instance.level,
  'memberSince': instance.memberSince.toIso8601String(),
  'memberTotalDurationMonths': instance.memberTotalDurationMonths,
};
