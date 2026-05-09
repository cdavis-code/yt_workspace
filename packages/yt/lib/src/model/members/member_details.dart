import 'package:json_annotation/json_annotation.dart';

part 'member_details.g.dart';

@JsonSerializable()
class MemberDetails {
  final String? channelId;
  final String? channelUrl;
  final String? displayName;
  final String? profileImageUrl;

  MemberDetails({
    this.channelId,
    this.channelUrl,
    this.displayName,
    this.profileImageUrl,
  });

  factory MemberDetails.fromJson(Map<String, dynamic> json) =>
      _$MemberDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MemberDetailsToJson(this);
}