// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatbot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chatbot _$ChatbotFromJson(Map<String, dynamic> json) => Chatbot(
  botName: json['botName'] as String,
  dialogs: (json['dialogs'] as List<dynamic>)
      .map((e) => Dialog.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ChatbotToJson(Chatbot instance) => <String, dynamic>{
  'botName': instance.botName,
  'dialogs': instance.dialogs,
};
