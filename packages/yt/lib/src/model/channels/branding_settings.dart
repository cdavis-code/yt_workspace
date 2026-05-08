import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'channel.dart';

part 'branding_settings.g.dart';

///The brandingSettings object encapsulates information about the branding of the channel.
@JsonSerializable(explicitToJson: true)
class BrandingSettings {
  ///The channel object encapsulates branding properties of the channel page.
  final Channel channel;

  BrandingSettings({required this.channel});

  factory BrandingSettings.fromJson(Map<String, dynamic> json) =>
      _$BrandingSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$BrandingSettingsToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
