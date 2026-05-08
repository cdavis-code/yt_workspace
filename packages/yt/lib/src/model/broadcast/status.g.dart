// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
  lifeCycleStatus: json['lifeCycleStatus'] as String,
  privacyStatus: json['privacyStatus'] as String,
  recordingStatus: json['recordingStatus'] as String,
  madeForKids: json['madeForKids'] as bool,
  selfDeclaredMadeForKids: json['selfDeclaredMadeForKids'] as bool,
);

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
  'lifeCycleStatus': instance.lifeCycleStatus,
  'privacyStatus': instance.privacyStatus,
  'recordingStatus': instance.recordingStatus,
  'madeForKids': instance.madeForKids,
  'selfDeclaredMadeForKids': instance.selfDeclaredMadeForKids,
};
