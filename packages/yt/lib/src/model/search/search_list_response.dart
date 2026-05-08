import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../page_info.dart';
import '../list_response.dart';
import 'search_result.dart';

part 'search_list_response.g.dart';

/// Returns a collection of search results that match the query parameters specified in the API request. By default, a search result set identifies matching video, channel, and playlist resources, but you can also configure queries to only retrieve a specific type of resource.
@JsonSerializable()
class SearchListResponse extends ListResponse {
  /// The region code that was used for the search query. The property value is a two-letter ISO country code that identifies the region. The i18nRegions.list method returns a list of supported regions. The default value is US. If a non-supported region is specified, YouTube might still select another region, rather than the default value, to handle the query.
  final String? regionCode;

  /// A list of results that match the search criteria.
  @JsonKey(name: 'items')
  final List<SearchResult>? searchItems;

  SearchListResponse({
    required super.kind,
    required super.etag,
    super.nextPageToken,
    super.prevPageToken,
    this.regionCode,
    required super.pageInfo,
    this.searchItems,
  });

  List<SearchResult> get items => searchItems ?? [];

  factory SearchListResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchListResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
