import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

@JsonSerializable()
class Status {
  final String privacyStatus;

  Status({required this.privacyStatus});

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
