import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/comments.dart';

class Comments extends YouTubeApiHelper {
  final CommentsClient _rest;

  Comments({required super.dio, super.token, super.apiKey})
    : _rest = CommentsClient(dio);

  /// Returns a list of comments that match the API request parameters.
  Future<CommentListResponse> list({
    /// The [part] parameter specifies a comma-separated list of one or more
    /// comment resource properties that the API response will include.
    ///
    /// The following list contains the part names that you can include in the
    /// parameter value: id, snippet
    String part = 'id,snippet',

    /// The [partList] parameter specifies a list of one or more comment resource
    /// properties that the API response will include.
    List<String> partList = const [],

    /// The [id] parameter specifies a comma-separated list of comment IDs for
    /// the resources that are being retrieved. In a [Comment] resource, the id
    /// property specifies the comment's ID.
    String? id,

    /// The [parentId] parameter specifies the ID of the comment for which
    /// replies should be retrieved.
    ///
    /// Note: YouTube currently supports replies only for top-level comments.
    /// However, replies to replies may be supported in the future.
    String? parentId,

    /// The maxResults parameter specifies the maximum number of items that
    /// should be returned in the result set.
    ///
    /// Note: This parameter is not supported for use in conjunction with the id
    /// parameter. Acceptable values are 1 to 100, inclusive. The default value
    /// is 20.
    int? maxResults,

    /// The [pageToken] parameter identifies a specific page in the result set
    /// that should be returned. In an API response, the nextPageToken property
    /// identifies the next page of the result that can be retrieved.
    ///
    /// Note: This parameter is not supported for use in conjunction with the id
    /// parameter.
    String? pageToken,

    /// This parameter indicates whether the API should return comments
    /// formatted as HTML or as plain text. The default value is html.
    String? textFormat,
  }) async {
    return _rest.list(
      apiKey,
      accept,
      buildParts(partList, part),
      id: id,
      parentId: parentId,
      maxResults: Util.maxResults(maxResults),
      pageToken: pageToken,
      textFormat: textFormat,
    );
  }

  /// The [id] parameter specifies a comma-separated list of comment IDs for the
  /// resources that are being retrieved. In a comment resource, the id property
  /// specifies the comment's ID.
  Future<CommentListResponse> listByIds({
    /// The [ids] parameter specifies a comma-separated list of comment IDs for
    /// the resources that are being retrieved. In a comment resource, the id
    /// property specifies the comment's ID.
    required List<String> ids,

    /// The [maxResults] parameter specifies the maximum number of items that
    /// should be returned in the result set.
    ///
    /// Note: This parameter is not supported for use in conjunction with the id
    /// parameter. Acceptable values are 1 to 100, inclusive. The default value
    /// is 20.
    int? maxResults,

    /// The [pageToken] parameter identifies a specific page in the result set
    /// that should be returned. In an API response, the nextPageToken property
    /// identifies the next page of the result that can be retrieved.
    ///
    /// Note: This parameter is not supported for use in conjunction with the
    /// [id] parameter.
    String? pageToken,

    /// This parameter indicates whether the API should return comments
    /// formatted as HTML or as plain text. The default value is html.
    TextFormat? textFormat = TextFormat.html,
  }) => _rest.list(
    apiKey,
    accept,
    'id,snippet',
    id: ids.join(','),
    maxResults: Util.maxResults(maxResults),
    pageToken: pageToken,
    textFormat: textFormat?.name,
  );

  /// The [id] parameter specifies a comment ID for the resource that is being
  /// retrieved. In a comment resource, the id property specifies the comment's
  /// ID.
  Future<CommentListResponse> listById({
    /// The [id] parameter specifies an ID for the resource that is to be
    /// retrieved. In a comment resource, the id property specifies the
    /// comment's ID.
    required String id,

    /// This parameter indicates whether the API should return comments
    /// formatted as HTML or as plain text. The default value is html.
    TextFormat? textFormat = TextFormat.html,
  }) => _rest.list(
    apiKey,
    accept,
    'id,snippet',
    id: id,
    textFormat: textFormat?.name,
  );

  /// The [parentId] parameter specifies the ID of the comment for which replies
  /// should be retrieved.
  ///
  /// Note: YouTube currently supports replies only for top-level comments.
  /// However, replies to replies may be supported in the future.
  Future<CommentListResponse> listByParentId({
    /// The [parentId] parameter specifies the ID of the comment for which
    /// replies should be retrieved.
    ///
    /// Note: YouTube currently supports replies only for top-level comments.
    /// However, replies to replies may be supported in the future.
    required String parentId,

    /// The [maxResults] parameter specifies the maximum number of items that
    /// should be returned in the result set.
    ///
    /// Note: This parameter is not supported for use in conjunction with the id
    /// parameter. Acceptable values are 1 to 100, inclusive. The default value
    /// is 20.
    int? maxResults,

    /// The [pageToken] parameter identifies a specific page in the result set
    /// that should be returned. In an API response, the nextPageToken property
    /// identifies the next page of the result that can be retrieved.
    ///
    /// Note: This parameter is not supported for use in conjunction with the
    /// [id] parameter.
    String? pageToken,

    /// This parameter indicates whether the API should return comments
    /// formatted as HTML or as plain text. The default value is html.
    TextFormat? textFormat = TextFormat.html,
  }) => _rest.list(
    apiKey,
    accept,
    'id,snippet',
    parentId: parentId,
    maxResults: Util.maxResults(maxResults),
    pageToken: pageToken,
    textFormat: textFormat?.name,
  );

  /// Creates a reply to an existing comment. Note: To create a top-level
  /// comment, use the commentThreads.insert method or commentThreads.add helper
  /// method.
  Future<Comment> insert({
    /// The part parameter identifies the properties that the API response will
    /// include. Set the parameter value to snippet. The snippet part has a
    /// quota cost of 2 units.
    String part = 'snippet',
    List<String> partList = const [],
    required Map<String, dynamic> body,
    String? onBehalfOfContentOwner,
  }) async =>
      _rest.insert(accept, contentType, buildParts(partList, part), body);

  /// Helper method that creates a new top-level comment.
  Future<Comment> add({
    /// The unique ID of the parent comment. This property is only set if the
    /// comment was submitted as a reply to another comment.
    required String parentId,

    /// The original, raw text of the comment as it was initially posted or last
    /// updated. The original text is only returned to the authenticated user if
    /// they are the comment's author.
    required String textOriginal,
  }) async => insert(
    body: {
      "snippet": {"parentId": parentId, "textOriginal": textOriginal},
    },
  );

  /// Modifies a comment.
  Future<Comment> update({
    /// The [part] parameter identifies the properties that the API response
    /// will include. You must at least include the snippet part in the
    /// parameter value since that part contains all of the properties that the
    /// API request can update.
    String part = 'id,snippet',
    List<String> partList = const [],
    required Map<String, dynamic> body,
    String? onBehalfOfContentOwner,
  }) async =>
      _rest.update(accept, contentType, buildParts(partList, part), body);

  /// Helper method to modify a comment.
  Future<Comment> change({
    required String commentId,
    required String textOriginal,
  }) async => insert(
    body: {
      "id": commentId,
      "snippet": {"textOriginal": textOriginal},
    },
  );

  /// Sets the moderation status of one or more comments. The API request
  /// must be authorized by the owner of the channel or video associated
  /// with the comments.
  Future<void> setModerationStatus({
    /// The [id] parameter specifies a comma-separated list of IDs that identify
    /// the comments for which you are updating the moderation status.
    required String id,

    /// Identifies the new moderation status of the specified comments.
    required ModerationStatus moderationStatus,

    /// The [banAuthor] parameter lets you indicate that you want to
    /// automatically reject any additional comments written by the comment's
    /// author. Set the parameter value to true to ban the author.
    ///
    /// Note: This parameter is only valid if the moderationStatus parameter is
    /// also set to rejected.
    bool? banAuthor,
  }) async => _rest.setModerationStatus(
    accept,
    contentType,
    'snippet',
    moderationStatus.name,
    moderationStatus == ModerationStatus.rejected ? banAuthor : null,
  );

  /// Deletes a comment.
  Future<void> delete({
    /// The [id] parameter specifies the comment ID for the resource that is being
    /// deleted.
    required String id,
  }) async => _rest.delete(accept, contentType, id);
}
