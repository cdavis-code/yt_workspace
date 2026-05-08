import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'text_message_details.g.dart';

///This object contains details about the text message. It is only present if the message type is textMessageEvent.
@JsonSerializable()
class TextMessageDetails {
  ///The user's message.
  final String messageText;

  TextMessageDetails({required this.messageText});

  factory TextMessageDetails.fromJson(Map<String, dynamic> json) =>
      _$TextMessageDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TextMessageDetailsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
