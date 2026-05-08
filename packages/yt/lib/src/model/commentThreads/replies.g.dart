// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Replies _$RepliesFromJson(Map<String, dynamic> json) => Replies(
  value: (json['value'] as List<dynamic>)
      .map((e) => Comment.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RepliesToJson(Replies instance) => <String, dynamic>{
  'value': instance.value,
};
