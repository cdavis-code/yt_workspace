// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentDetails _$ContentDetailsFromJson(Map<String, dynamic> json) =>
    ContentDetails(
      totalItemCount: (json['totalItemCount'] as num).toInt(),
      newItemCount: (json['newItemCount'] as num).toInt(),
      activityType: json['activityType'] as String,
    );

Map<String, dynamic> _$ContentDetailsToJson(ContentDetails instance) =>
    <String, dynamic>{
      'totalItemCount': instance.totalItemCount,
      'newItemCount': instance.newItemCount,
      'activityType': instance.activityType,
    };
