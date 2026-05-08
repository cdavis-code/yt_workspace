// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorDetails _$AuthorDetailsFromJson(Map<String, dynamic> json) =>
    AuthorDetails(
      channelId: json['channelId'] as String?,
      channelUrl: json['channelUrl'] as String?,
      displayName: json['displayName'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      isVerified: json['isVerified'] as bool?,
      isChatOwner: json['isChatOwner'] as bool?,
      isChatSponsor: json['isChatSponsor'] as bool?,
      isChatModerator: json['isChatModerator'] as bool?,
    );

Map<String, dynamic> _$AuthorDetailsToJson(AuthorDetails instance) =>
    <String, dynamic>{
      'channelId': instance.channelId,
      'channelUrl': instance.channelUrl,
      'displayName': instance.displayName,
      'profileImageUrl': instance.profileImageUrl,
      'isVerified': instance.isVerified,
      'isChatOwner': instance.isChatOwner,
      'isChatSponsor': instance.isChatSponsor,
      'isChatModerator': instance.isChatModerator,
    };
