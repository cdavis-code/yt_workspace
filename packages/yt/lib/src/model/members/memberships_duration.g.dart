// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memberships_duration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembershipsDuration _$MembershipsDurationFromJson(Map<String, dynamic> json) =>
    MembershipsDuration(
      memberSince: DateTime.parse(json['memberSince'] as String),
      memberTotalDurationMonths: (json['memberTotalDurationMonths'] as num)
          .toInt(),
    );

Map<String, dynamic> _$MembershipsDurationToJson(
  MembershipsDuration instance,
) => <String, dynamic>{
  'memberSince': instance.memberSince.toIso8601String(),
  'memberTotalDurationMonths': instance.memberTotalDurationMonths,
};
