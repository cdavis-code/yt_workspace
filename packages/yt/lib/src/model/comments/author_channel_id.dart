import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'author_channel_id.g.dart';

/// This object encapsulates information about the comment author's YouTube channel, if available.
@JsonSerializable()
class AuthorChannelId {
  /// The ID of the comment author's YouTube channel, if available.
  final String value;

  AuthorChannelId({required this.value});

  factory AuthorChannelId.fromJson(Map<String, dynamic> json) =>
      _$AuthorChannelIdFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorChannelIdToJson(this);

  @override
  String toString() => json.encode(toJson());
}
