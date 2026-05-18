import 'package:json_annotation/json_annotation.dart';

import 'third_party_link.dart';

part 'third_party_link_list_response.g.dart';

@JsonSerializable()
class ThirdPartyLinkListResponse {
  final String kind;
  final String etag;
  final List<ThirdPartyLink> items;

  ThirdPartyLinkListResponse({
    this.kind = 'youtube#thirdPartyLinkListResponse',
    required this.etag,
    required this.items,
  });

  factory ThirdPartyLinkListResponse.fromJson(Map<String, dynamic> json) =>
      _$ThirdPartyLinkListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThirdPartyLinkListResponseToJson(this);
}
