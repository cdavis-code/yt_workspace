import 'dart:io';

import 'package:yt/yt.dart';

void main() async {
  final yt = Yt.withOAuth();

  ///the live streaming broadcast API client
  final br = yt.broadcast;

  var broadcastResponse = await br.list(broadcastStatus: 'active');

  if (broadcastResponse.items.isEmpty) {
    broadcastResponse =
        await br.list(broadcastStatus: 'upcoming', maxResults: 1);
  }

  if (broadcastResponse.items.isNotEmpty) {
    final liveBroadcastItem = broadcastResponse.items.first;

    final chatbot = Chatbot.fromYaml(File('chatbot.yaml'));

    //if being run periodically you will want to provide a TimeStore to persist
    //a timestamp that will ensure the chatbot doesn't repeat answers
    await yt.chat
        .answerBot(liveBroadcastItem: liveBroadcastItem, chatbot: chatbot);
  }
}
