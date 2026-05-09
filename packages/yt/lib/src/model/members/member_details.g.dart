// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberDetails _$MemberDetailsFromJson(Map<String, dynamic> json) =>
    MemberDetails(
      channelId: json['channelId'] as String?,
      channelUrl: json['channelUrl'] as String?,
      displayName: json['displayName'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
    );

Map<String, dynamic> _$MemberDetailsToJson(MemberDetails instance) =>
    <String, dynamic>{
      'channelId': instance.channelId,
      'channelUrl': instance.channelUrl,
      'displayName': instance.displayName,
      'profileImageUrl': instance.profileImageUrl,
    };
