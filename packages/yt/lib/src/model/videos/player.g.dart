// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
  embedHtml: json['embedHtml'] as String?,
  embedHeight: (json['embedHeight'] as num?)?.toInt(),
  embedWidth: (json['embedWidth'] as num?)?.toInt(),
);

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
  'embedHtml': instance.embedHtml,
  'embedHeight': instance.embedHeight,
  'embedWidth': instance.embedWidth,
};
