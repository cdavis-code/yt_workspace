import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'page_info.g.dart';

///PageInfo
@JsonSerializable()
class PageInfo {
  ///The total number of results in the result set.
  final int totalResults;

  ///The number of results included in the API response.
  final int resultsPerPage;

  PageInfo({required this.totalResults, required this.resultsPerPage});

  factory PageInfo.fromJson(Map<String, dynamic> json) =>
      _$PageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PageInfoToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
