import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'banned_user_details.g.dart';

///This object contains information about the banned user.
@JsonSerializable()
class BannedUserDetails {
  ///The banned user's YouTube channel ID.
  final String? channelId;

  ///The URL of the banned user's YouTube channel.
  final String? channelUrl;

  ///The display name of the banned user's YouTube channel.
  final String? displayName;

  ///The avatar of the banned user's YouTube channel.
  final String? profileImageUrl;

  BannedUserDetails({
    this.channelId,
    this.channelUrl,
    this.displayName,
    this.profileImageUrl,
  });

  factory BannedUserDetails.fromJson(Map<String, dynamic> json) =>
      _$BannedUserDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$BannedUserDetailsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
