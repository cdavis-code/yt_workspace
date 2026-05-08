import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'author_details.g.dart';

///The authorDetails object contains additional details about the user that posted this message.
@JsonSerializable()
class AuthorDetails {
  ///The author's YouTube channel ID.
  final String? channelId;

  ///The URL of the author's YouTube channel.
  final String? channelUrl;

  ///The display name of the author's YouTube channel.
  final String? displayName;

  ///The avatar URL of the author's YouTube channel.
  final String? profileImageUrl;

  ///This value indicates whether the author's identity has been verified by YouTube.
  final bool? isVerified;

  ///This value indicates whether the author is the owner of the live chat.
  final bool? isChatOwner;

  ///This value indicates whether the author is a sponsor of the live chat.
  final bool? isChatSponsor;

  ///This value indicates whether the author is a moderator of the live chat.
  final bool? isChatModerator;

  AuthorDetails({
    this.channelId,
    this.channelUrl,
    this.displayName,
    this.profileImageUrl,
    this.isVerified,
    this.isChatOwner,
    this.isChatSponsor,
    this.isChatModerator,
  });

  factory AuthorDetails.fromJson(Map<String, dynamic> json) =>
      _$AuthorDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorDetailsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
