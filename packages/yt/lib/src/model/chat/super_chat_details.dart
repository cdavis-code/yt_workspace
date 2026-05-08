import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'super_chat_details.g.dart';

///This object contains details about a Super Chat event. It is only present if the message type is superChatEvent.
@JsonSerializable()
class SuperChatDetails {
  ///The purchase amount, in micros of the purchase currency. For example, if the purchase amount is one dollar, the snippet.amountMicros property value is 1000000.
  final int? amountMicros;

  ///The currency in which the purchase was made. The value is an [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) currency code.
  final String? currency;

  ///A string, like $1.00, that contains the purchase amount and currency. The string is intended to be displayed to the user.
  final String? amountDisplayString;

  ///The comment added by the user to this Super Chat event.
  final String? userComment;

  ///The tier for the paid message. Note that in a superChatEvent resource, the snippet.messageType property contains this value.
  ///
  ///The tier is based on the amount of money spent to purchase the message. It also determines the color used to highlight the message in the live chat UI, the maximum message length, and the amount of time that the message is pinned the ticker.
  ///
  ///The Super Chat tiers are documented in the YouTube Help Center. (See the expandable section about Super Chat purchase details.) In that list, the tier with the lowest purchase amount is tier 1, the next lowest amount is tier 2, and so forth.
  final int? tier;

  SuperChatDetails({
    this.amountMicros,
    this.currency,
    this.amountDisplayString,
    this.userComment,
    this.tier,
  });

  factory SuperChatDetails.fromJson(Map<String, dynamic> json) =>
      _$SuperChatDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$SuperChatDetailsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
