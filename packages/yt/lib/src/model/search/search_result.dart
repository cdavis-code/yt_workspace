import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../response_metadata.dart';
import 'id.dart';
import 'snippet.dart';

part 'search_result.g.dart';

/// a collection of search results that match the query parameters specified in the API request. By default, a search result set identifies matching video, channel, and playlist resources, but you can also configure queries to only retrieve a specific type of resource.
@JsonSerializable()
class SearchResult extends ResponseMetadata {
  /// The id object contains information that can be used to uniquely identify the resource that matches the search request.
  final Id id;

  /// The snippet object contains basic details about a search result, such as its title or description. For example, if the search result is a video, then the title will be the video's title and the description will be the video's description.
  final Snippet? snippet;

  SearchResult({
    required super.kind,
    required super.etag,
    required this.id,
    this.snippet,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
