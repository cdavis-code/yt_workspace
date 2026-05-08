// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banned_user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannedUserDetails _$BannedUserDetailsFromJson(Map<String, dynamic> json) =>
    BannedUserDetails(
      channelId: json['channelId'] as String?,
      channelUrl: json['channelUrl'] as String?,
      displayName: json['displayName'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
    );

Map<String, dynamic> _$BannedUserDetailsToJson(BannedUserDetails instance) =>
    <String, dynamic>{
      'channelId': instance.channelId,
      'channelUrl': instance.channelUrl,
      'displayName': instance.displayName,
      'profileImageUrl': instance.profileImageUrl,
    };
