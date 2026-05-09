// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Keyword _$KeywordFromJson(Map<String, dynamic> json) => Keyword(
  patterns: (json['patterns'] as List<dynamic>)
      .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
      .toList(),
  score: (json['score'] as num).toInt(),
);

Map<String, dynamic> _$KeywordToJson(Keyword instance) => <String, dynamic>{
  'patterns': instance.patterns,
  'score': instance.score,
};
