import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'snippet.g.dart';

@JsonSerializable(explicitToJson: true)
///The snippet object contains basic details about the stream, including its channel, title, and description.
class Snippet {
  ///The date and time that the stream was created. The value is specified in [ISO 8601](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sZ) format.
  final DateTime publishedAt;

  ///The ID that YouTube uses to uniquely identify the channel that is transmitting the stream.
  final String channelId;

  ///The stream's title. The value must be between 1 and 128 characters long.
  final String title;

  ///The stream's description. The value cannot be longer than 10000 characters.
  final String description;
  @Deprecated('')
  @JsonKey(ignore: true)
  final bool? isDefaultStream;

  Snippet({
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.description,
    this.isDefaultStream,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);

  Map<String, dynamic> toJson() => _$SnippetToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
