import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'super_sticker_metadata.g.dart';

///Details about the Super Sticker.
@JsonSerializable()
class SuperStickerMetadata {
  ///A unique ID that identifies the sticker image. Note that the image is only displayed as part of the Super Sticker message when users view the chat window on YouTube. However, the image URL is not available via the API.
  final String? stickerId;

  ///A text string that describes the sticker. The snippet.superStickerDetails.superStickerMetadata.language field identifies the language of the text. When calling the liveChatMessages.list method, set the hl parameter value to the desired language for the text.
  final String? altText;

  ///The language of the snippet.superStickerDetails.superStickerMetadata.altText property value.
  final String? language;

  SuperStickerMetadata({this.stickerId, this.altText, this.language});

  factory SuperStickerMetadata.fromJson(Map<String, dynamic> json) =>
      _$SuperStickerMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$SuperStickerMetadataToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
