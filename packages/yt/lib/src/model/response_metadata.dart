/// Returns a collection of results that match the parameters specified in the API request.
abstract class ResponseMetadata {
  /// Identifies the API resource's type. The value will be youtube#searchListResponse.
  final String kind;

  /// The Etag of this resource.
  final String etag;

  ResponseMetadata({required this.kind, required this.etag});
}
