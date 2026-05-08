// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
  uploadStatus: json['uploadStatus'] as String,
  failureReason: json['failureReason'] as String?,
  rejectionReason: json['rejectionReason'] as String?,
  privacyStatus: json['privacyStatus'] as String,
  publishAt: json['publishAt'] == null
      ? null
      : DateTime.parse(json['publishAt'] as String),
  license: json['license'] as String,
  embeddable: json['embeddable'] as bool,
  publicStatsViewable: json['publicStatsViewable'] as bool,
  madeForKids: json['madeForKids'] as bool?,
  selfDeclaredMadeForKids: json['selfDeclaredMadeForKids'] as bool?,
);

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
  'uploadStatus': instance.uploadStatus,
  'failureReason': instance.failureReason,
  'rejectionReason': instance.rejectionReason,
  'privacyStatus': instance.privacyStatus,
  'publishAt': instance.publishAt?.toIso8601String(),
  'license': instance.license,
  'embeddable': instance.embeddable,
  'publicStatsViewable': instance.publicStatsViewable,
  'madeForKids': instance.madeForKids,
  'selfDeclaredMadeForKids': instance.selfDeclaredMadeForKids,
};
