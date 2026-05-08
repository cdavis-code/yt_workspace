import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'message_deleted_details.g.dart';

///This object contains details about a message deleted by a chat moderator or by the owner of the live broadcast's channel. It is only present if the message type is messageDeletedEvent.
@JsonSerializable()
class MessageDeletedDetails {
  ///The ID that uniquely identifies the deleted message. The value is the same as the id property value of the original text message. For example, if a textMessageEvent has an id property value of 123, and that message is subsequently deleted, the snippet.messageDeletedDetails.deletedMessageId value will be 123 for that message.
  ///
  ///If you cache chat messages after retrieving them, use the value of this property to identify the message that should no longer be displayed.
  final String? deletedMessageId;

  MessageDeletedDetails({this.deletedMessageId});

  factory MessageDeletedDetails.fromJson(Map<String, dynamic> json) =>
      _$MessageDeletedDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDeletedDetailsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
