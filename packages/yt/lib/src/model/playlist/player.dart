import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'player.g.dart';

///The [Player] object contains information that you would use to play the playlist in an embedded player.
@JsonSerializable()
class Player {
  ///An <iframe> tag that embeds a player that will play the playlist.
  final String embedHtml;

  Player({required this.embedHtml});

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
