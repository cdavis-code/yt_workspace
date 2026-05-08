// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
  type: json['type'] as String? ?? 'corner',
  cornerPosition: json['cornerPosition'] as String,
);

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
  'type': instance.type,
  'cornerPosition': instance.cornerPosition,
};
