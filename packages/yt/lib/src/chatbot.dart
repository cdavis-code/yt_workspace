import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:universal_io/io.dart';
import 'package:yaml/yaml.dart';
import 'package:yt/yt.dart';

part 'chatbot.g.dart';

@JsonSerializable()
class Chatbot {
  final String botName;
  final List<Dialog> dialogs;
  final PhraseMatch phraseMatch;

  String get nameFormatted => EmojiFormatter.format(botName);

  Chatbot({required this.botName, required this.dialogs})
    : phraseMatch = PhraseMatch();

  factory Chatbot.fromYaml(File yamlFile) {
    final jsonString = json.encode(loadYaml(yamlFile.readAsStringSync()));

    return Chatbot.fromJson(json.decode(jsonString));
  }

  Future<void> checkDialog({
    required LiveChatMessage liveChatMessage,
    required Function onFound,
  }) async {
    for (Dialog dialog in dialogs) {
      var success = phraseMatch.checkQuestion(
        question: liveChatMessage.snippet.textMessageDetails!.messageText,
        keyword: dialog.keyword,
      );

      if (success) {
        var recipient = liveChatMessage.authorDetails?.displayName ?? '';

        onFound(dialog, recipient);
      }
    }
  }

  factory Chatbot.fromJson(Map<String, dynamic> json) =>
      _$ChatbotFromJson(json);

  Map<String, dynamic> toJson() => _$ChatbotToJson(this);

  @override
  String toString() => json.encode(toJson());
}
