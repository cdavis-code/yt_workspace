// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberSnippet _$MemberSnippetFromJson(Map<String, dynamic> json) =>
    MemberSnippet(
      creatorChannelId: json['creatorChannelId'] as String,
      memberDetails: json['memberDetails'] == null
          ? null
          : MemberDetails.fromJson(
              json['memberDetails'] as Map<String, dynamic>,
            ),
      membershipsDetails: MembershipsDetails.fromJson(
        json['membershipsDetails'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$MemberSnippetToJson(MemberSnippet instance) =>
    <String, dynamic>{
      'creatorChannelId': instance.creatorChannelId,
      'memberDetails': instance.memberDetails,
      'membershipsDetails': instance.membershipsDetails,
    };
