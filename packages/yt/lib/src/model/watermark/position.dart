import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'position.g.dart';

/// The position object encapsulates information about the spatial position
/// within the video where the watermark image will display.
@JsonSerializable()
class Position {
  /// The manner in which the promoted item is positioned in the video player.
  ///
  /// Valid values for this property are:
  /// - corner
  final String type;

  /// The corner of the player where the promoted item will appear. The item always appears in the upper right corner of the player.
  ///
  /// Valid values for this property are:
  /// - topRight
  final String cornerPosition;

  Position({this.type = 'corner', required this.cornerPosition});

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);

  Map<String, dynamic> toJson() => _$PositionToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
