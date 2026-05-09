import 'package:json_annotation/json_annotation.dart';

import '../page_info.dart';
import 'member.dart';

part 'member_list_response.g.dart';

@JsonSerializable()
class MemberListResponse {
  final String kind;
  final String etag;

  @JsonKey(name: 'nextPageToken')
  final String? nextPageToken;

  @JsonKey(name: 'pageInfo')
  final PageInfo? pageInfo;

  final List<Member> items;

  MemberListResponse({
    this.kind = 'youtube#memberListResponse',
    required this.etag,
    this.nextPageToken,
    this.pageInfo,
    required this.items,
  });

  factory MemberListResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MemberListResponseToJson(this);
}
