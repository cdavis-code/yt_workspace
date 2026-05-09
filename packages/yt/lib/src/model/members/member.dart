import 'package:json_annotation/json_annotation.dart';

import 'member_snippet.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  final String kind;
  final String etag;
  final MemberSnippet snippet;

  Member({
    this.kind = 'youtube#member',
    required this.etag,
    required this.snippet,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
