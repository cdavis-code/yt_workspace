import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'text_message_details.dart';
import 'message_deleted_details.dart';
import 'user_banned_details.dart';
import 'super_chat_details.dart';
import 'super_sticker_details.dart';

part 'snippet.g.dart';

@JsonSerializable(explicitToJson: true)
class Snippet {
  ///The message's type. This property is always present, and its value determines which fields are present in the resource.
  ///
  ///Valid values for this property are:
  ///- chatEndedEvent – The chat has ended and no more messages can be inserted after this one. This will occur naturally a little while after a broadcast ends. Note that this type of message is not currently sent for live chats on a channel's default broadcast.
  ///- messageDeletedEvent – A message has been deleted by a moderator. The author field contains the moderator's details. This event does not have any display content.
  ///- newSponsorEvent – A new user has sponsored the channel that owns the live chat. The author fields contain the new sponsor's details.
  ///- sponsorOnlyModeEndedEvent – The chat is no longer in sponsors-only mode, which means that users that are not sponsors are now able to send messages. This event does not have any display content.
  ///- sponsorOnlyModeStartedEvent – The chat has entered sponsors-only mode, which means that only sponsors are able to send messages. This event has no display content.
  ///- superChatEvent – A user has purchased a Super Chat.
  ///- superStickerEvent – A user has purchased a Super Sticker.
  ///- textMessageEvent – A user has sent a text message.
  ///- tombstone – A tombstone signifies that a message used to exist with this id and publish time, but it has since been deleted. It is not sent upon deletion of a message, but rather is shown to signify where the message used to be before deletion. Only the snippet.liveChatId, snippet.type, and snippet.publishedAt fields are present in this type of message.
  ///- userBannedEvent – A user has been banned by a moderator. The author field contains the moderator's details.
  final String? type;

  ///The ID that uniquely identifies the live chat with which the message is associated. The live chat ID associated with a broadcast is returned in the liveBroadcast resource's snippet.liveChatId property.
  final String? liveChatId;

  ///The ID of the user that authored the message. This field is only filled for the following message types:
  ///- If the message type is textMessageEvent, the property value identifies the user that wrote the message.
  ///- If the message type is fanFundingEvent, the property value identifies the user that funded the broadcast.
  ///- If the message type is messageDeletedEvent, the property value identifies the moderator that deleted the message.
  ///- If the message type is newSponsorEvent, the property value identifies the user that just became a sponsor.
  ///- If the message type is userBannedEvent, the property value identifies the moderator that banned the user.
  final String? authorChannelId;

  ///The date and time when the message was originally published. The value is specified in [ISO 8601](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sZ) format.
  final DateTime? publishedAt;

  ///Indicates whether the message has display content that should be displayed to users.
  final bool? hasDisplayContent;

  ///Contains a string that is displayed to users. This field is not present if the message type is chatEndedEvent or tombstone.
  final String? displayMessage;

  ///This object contains details about the text message. It is only present if the message type is textMessageEvent.
  final TextMessageDetails? textMessageDetails;

  ///This object contains details about a message deleted by a chat moderator or by the owner of the live broadcast's channel. It is only present if the message type is messageDeletedEvent.
  final MessageDeletedDetails? messageDeletedDetails;

  ///This object contains details about a user who has been banned from the chat. It also contains details about the ban itself. Users can be banned from a chat permanently or temporarily.
  final UserBannedDetails? userBannedDetails;

  ///This object contains details about a Super Chat event. It is only present if the message type is superChatEvent.
  final SuperChatDetails? superChatDetails;

  ///This object contains details about a Super Sticker event. It is only present if the message type is superStickerEvent.
  final SuperStickerDetails? superStickerDetails;

  Snippet({
    this.type,
    this.liveChatId,
    this.authorChannelId,
    this.publishedAt,
    this.hasDisplayContent,
    this.displayMessage,
    this.textMessageDetails,
    this.messageDeletedDetails,
    this.userBannedDetails,
    this.superChatDetails,
    this.superStickerDetails,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);

  Map<String, dynamic> toJson() => _$SnippetToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
