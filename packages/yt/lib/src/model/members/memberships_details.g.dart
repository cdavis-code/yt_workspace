// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memberships_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembershipsDetails _$MembershipsDetailsFromJson(Map<String, dynamic> json) =>
    MembershipsDetails(
      highestAccessibleLevel: json['highestAccessibleLevel'] as String,
      highestAccessibleLevelDisplayName:
          json['highestAccessibleLevelDisplayName'] as String,
      accessibleLevels: (json['accessibleLevels'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      membershipsDuration: MembershipsDuration.fromJson(
        json['membershipsDuration'] as Map<String, dynamic>,
      ),
      membershipsDurationAtLevel:
          (json['membershipsDurationAtLevel'] as List<dynamic>)
              .map(
                (e) => MembershipsDurationAtLevel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
    );

Map<String, dynamic> _$MembershipsDetailsToJson(MembershipsDetails instance) =>
    <String, dynamic>{
      'highestAccessibleLevel': instance.highestAccessibleLevel,
      'highestAccessibleLevelDisplayName':
          instance.highestAccessibleLevelDisplayName,
      'accessibleLevels': instance.accessibleLevels,
      'membershipsDuration': instance.membershipsDuration,
      'membershipsDurationAtLevel': instance.membershipsDurationAtLevel,
    };
