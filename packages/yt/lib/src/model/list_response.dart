import 'page_info.dart';
import 'response_metadata.dart';

/// Returns a collection of results that match the parameters specified in the API request.
abstract class ListResponse extends ResponseMetadata {
  /// The token that can be used as the value of the pageToken parameter to retrieve the next page in the result set.
  final String? nextPageToken;

  /// The token that can be used as the value of the pageToken parameter to retrieve the previous page in the result set.
  final String? prevPageToken;

  /// The pageInfo object encapsulates paging information for the result set.
  final PageInfo? pageInfo;

  ListResponse({
    required super.kind,
    required super.etag,
    this.nextPageToken,
    this.prevPageToken,
    this.pageInfo,
  });
}
