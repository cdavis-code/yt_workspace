import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../page_info.dart';
import '../list_response.dart';
import 'live_chat_message.dart';

part 'live_chat_message_list_response.g.dart';

///A liveChatMessage resource represents a chat message in a YouTube live chat. The resource can contain details about several types of messages, including a newly posted text message or fan funding event.
///
///The live chat feature is enabled by default for live broadcasts and is available while the live event is active. (After the event ends, live chat is no longer available for that event.)
@JsonSerializable()
class LiveChatMessageListResponse extends ListResponse {
  ///The amount of time, in milliseconds, that the client should wait before polling again for new live chat messages.
  final int? pollingIntervalMillis;

  ///The date and time when the underlying live stream went offline. This property is only present if the stream is already offline. The value is specified in [ISO 8601](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sZ) format.
  final DateTime? offlineAt;

  ///A list of live chat messages. Each item in the list is a liveChatMessage resource.
  @JsonKey(name: 'items')
  final List<LiveChatMessage>? liveChatMessageItems;

  LiveChatMessageListResponse({
    required super.kind,
    required super.etag,
    super.nextPageToken,
    this.pollingIntervalMillis,
    this.offlineAt,
    required super.pageInfo,
    this.liveChatMessageItems,
  });

  List<LiveChatMessage> get items => liveChatMessageItems ?? [];

  factory LiveChatMessageListResponse.fromJson(Map<String, dynamic> json) =>
      _$LiveChatMessageListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LiveChatMessageListResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
