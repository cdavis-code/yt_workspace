// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memberships_level_snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembershipsLevelSnippet _$MembershipsLevelSnippetFromJson(
  Map<String, dynamic> json,
) => MembershipsLevelSnippet(
  creatorChannelId: json['creatorChannelId'] as String,
  levelDetails: LevelDetails.fromJson(
    json['levelDetails'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$MembershipsLevelSnippetToJson(
  MembershipsLevelSnippet instance,
) => <String, dynamic>{
  'creatorChannelId': instance.creatorChannelId,
  'levelDetails': instance.levelDetails,
};
