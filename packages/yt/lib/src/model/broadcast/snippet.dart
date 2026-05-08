import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../thumbnails.dart';

part 'snippet.g.dart';

///The snippet object contains basic details about the event, including its title, description, start time, and end time.
@JsonSerializable(explicitToJson: true)
class Snippet {
  ///The date and time that the broadcast was added to YouTube's live broadcast schedule. The value is specified in [ISO 8601](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sZ) format.
  final DateTime? publishedAt;

  ///The ID that YouTube uses to uniquely identify the channel that is publishing the broadcast.
  final String? channelId;

  ///The broadcast's title. Note that the broadcast represents exactly one YouTube video. You can set this field by modifying the broadcast resource or by setting the [title] field of the corresponding video resource.
  final String title;

  ///The broadcast's description. As with the title, you can set this field by modifying the broadcast resource or by setting the [description] field of the corresponding video resource.
  final String description;

  ///A map of [Thumbnail] images associated with the broadcast. For each nested object in this object, the key is the name of the thumbnail image, and the value is an object that contains other information about the thumbnail.
  final Thumbnails? thumbnails;

  ///The date and time that the broadcast is scheduled to start. The value is specified in [ISO 8601](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sZ) format.
  final DateTime? scheduledStartTime;

  ///The date and time that the broadcast is scheduled to end. The value is specified in [ISO 8601](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sZ) format. If a liveBroadcast resource does not specify a value for this property, then the broadcast is scheduled to continue indefinitely. Similarly, if you do not specify a value for this property, then YouTube treats the broadcast as if it will go on indefinitely.
  final DateTime? scheduledEndTime;

  ///The date and time that the broadcast actually started. This information is only available once the broadcast's state is live. The value is specified in [ISO 8601](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sZ) format.
  final DateTime? actualStartTime;

  @Deprecated('')
  @JsonKey(ignore: true)
  final bool? isDefaultBroadcast;

  ///The ID for the broadcast's YouTube live chat. With this ID, you can use the [LiveChatMessage] resource's methods to retrieve, insert, or delete chat messages. You can also add or remove chat moderators, ban users from participating in live chats, or remove existing bans.
  final String? liveChatId;

  Snippet({
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.description,
    required this.thumbnails,
    this.scheduledStartTime,
    this.scheduledEndTime,
    this.actualStartTime,
    this.isDefaultBroadcast,
    required this.liveChatId,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);

  Map<String, dynamic> toJson() => _$SnippetToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
