// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watermarks_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatermarksResource _$WatermarksResourceFromJson(Map<String, dynamic> json) =>
    WatermarksResource(
      timing: Timing.fromJson(json['timing'] as Map<String, dynamic>),
      position: Position.fromJson(json['position'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String? ?? '',
      imageBytes: WatermarksResource.stringToUint8List(
        json['imageBytes'] as List<int>,
      ),
      targetChannelId: json['targetChannelId'] as String,
    );

Map<String, dynamic> _$WatermarksResourceToJson(WatermarksResource instance) =>
    <String, dynamic>{
      'timing': instance.timing,
      'position': instance.position,
      'imageUrl': instance.imageUrl,
      'imageBytes': WatermarksResource.imageBytesToList(instance.imageBytes),
      'targetChannelId': instance.targetChannelId,
    };
