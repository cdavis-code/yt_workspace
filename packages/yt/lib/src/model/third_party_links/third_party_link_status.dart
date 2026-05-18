import 'package:json_annotation/json_annotation.dart';

part 'third_party_link_status.g.dart';

/// The status object encapsulates information about the status of the
/// third-party account link.
@JsonSerializable()
class ThirdPartyLinkStatus {
  /// The link status. Valid values: `unknown`, `failed`, `pending`, `linked`.
  final String? linkStatus;

  ThirdPartyLinkStatus({this.linkStatus});

  factory ThirdPartyLinkStatus.fromJson(Map<String, dynamic> json) =>
      _$ThirdPartyLinkStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ThirdPartyLinkStatusToJson(this);
}
