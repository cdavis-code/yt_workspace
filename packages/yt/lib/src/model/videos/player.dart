import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'player.g.dart';

@JsonSerializable()
class Player {
  final String? embedHtml;
  final int? embedHeight;
  final int? embedWidth;

  Player({this.embedHtml, this.embedHeight, this.embedWidth});

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
