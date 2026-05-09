// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dialog _$DialogFromJson(Map<String, dynamic> json) => Dialog(
  name: json['name'] as String,
  answers: (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
  keyword: Keyword.fromJson(json['keyword'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DialogToJson(Dialog instance) => <String, dynamic>{
  'name': instance.name,
  'answers': instance.answers,
  'keyword': instance.keyword.toJson(),
};
