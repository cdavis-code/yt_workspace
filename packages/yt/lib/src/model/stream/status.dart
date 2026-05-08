import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'health_status.dart';

part 'status.g.dart';

///The status object contains information about live stream's status.
@JsonSerializable(explicitToJson: true)
class Status {
  ///The stream's status.
  ///
  ///Valid values for this property are:
  ///- active – The stream is in active state which means the user is receiving data via the stream.
  ///- created – The stream has been created but does not have valid CDN settings.
  ///- error – An error condition exists on the stream.
  ///- inactive – The stream is in inactive state which means the user is not receiving data via the stream.
  ///- ready – The stream has valid CDN settings.
  final String streamStatus;

  ///The status code of this stream.
  ///
  ///Valid values for this property are:
  ///- good – There are no configuration issues for which the severity is warning or worse.
  ///- ok – There are no configuration issues for which the severity is error.
  ///- bad – The stream has some issues for which the severity is error.
  ///- noData – YouTube's live streaming backend servers do not have any information about the stream's health status.
  final HealthStatus healthStatus;

  Status({required this.streamStatus, required this.healthStatus});

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
