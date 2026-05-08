import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'banned_user_details.dart';

part 'user_banned_details.g.dart';

///This object contains details about a user who has been banned from the chat. It also contains details about the ban itself. Users can be banned from a chat permanently or temporarily.
@JsonSerializable(explicitToJson: true)
class UserBannedDetails {
  ///This object contains information about the banned user.
  final BannedUserDetails bannedUserDetails;

  ///The type of ban. Valid values for this property are:
  ///- permanent
  ///- temporary
  final String? banType;

  ///The duration of the ban. This property is only present if the snippet.userBannedDetails.banType property value is temporary.
  final int? banDurationSeconds;

  UserBannedDetails({
    required this.bannedUserDetails,
    required this.banType,
    required this.banDurationSeconds,
  });

  factory UserBannedDetails.fromJson(Map<String, dynamic> json) =>
      _$UserBannedDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserBannedDetailsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
