import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'related_playlists.dart';

part 'content_details.g.dart';

///The contentDetails object encapsulates information about the channel's content.
@JsonSerializable()
class ContentDetails {
  ///The relatedPlaylists object is a map that identifies playlists associated with the channel, such as the channel's uploaded videos or liked videos. You can retrieve any of these playlists using the playlists.list method.
  final RelatedPlaylists relatedPlaylists;

  ContentDetails({required this.relatedPlaylists});

  factory ContentDetails.fromJson(Map<String, dynamic> json) =>
      _$ContentDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ContentDetailsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
