import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'id.g.dart';

@JsonSerializable()
class Id {
  final String kind;
  final String? videoId;
  final String? channelId;
  final String? playlistId;

  Id({required this.kind, this.videoId, this.channelId, this.playlistId});

  factory Id.fromJson(Map<String, dynamic> json) => _$IdFromJson(json);

  Map<String, dynamic> toJson() => _$IdToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
