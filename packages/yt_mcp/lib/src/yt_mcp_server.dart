/// MCP facade for the YouTube Data and Live Streaming API client.
///
/// [YtMcpServer] wraps [Yt] and exposes YouTube API operations as MCP tools
/// via the `easy_api_annotations` package.
///
/// The class is annotated with
/// `@Server(transport: McpTransport.stdio)` so the generator
/// produces a stdio MCP server at `yt_mcp_server.mcp.dart`.
///
/// Because the generated dispatcher constructs a fresh [YtMcpServer] instance
/// for every tool invocation, the live connection is kept in a static field
/// so it survives across calls.
library;

import 'dart:io';

import 'package:easy_api_annotations/mcp_annotations.dart';
import 'package:yt/yt.dart';

/// Unified MCP facade exposing YouTube Data and Live Streaming APIs as tools.
///
/// Callers rely on [bootstrapFromEnv] to initialize automatically from
/// `YT_API_KEY` or `YT_OAUTH_TOKEN` environment variables, then use any
/// of the grouped tools (`yt_search_list`, `yt_videos_list`, etc.).
@Server(transport: McpTransport.stdio, toolPrefix: 'yt_', logErrors: true)
class YtMcpServer {
  /// Environment variable holding the YouTube API key.
  static const String envApiKey = 'YT_API_KEY';

  /// Environment variable holding the YouTube OAuth token.
  static const String envOAuthToken = 'YT_OAUTH_TOKEN';

  /// Environment variable holding the path to OAuth client secrets file.
  static const String envClientSecretsFile = 'YT_CLIENT_SECRETS_FILE';

  /// Environment variable holding the path to OAuth access tokens file.
  static const String envAccessTokensFile = 'YT_ACCESS_TOKENS_FILE';

  /// Static so the client persists across per-tool-call instances
  /// created by the generated dispatcher.
  static Yt? _client;

  /// Stores the last bootstrap error to provide better error messages.
  static String? _bootstrapError;

  /// Canonical acknowledgement payload for tools that have no natural
  /// return value.
  // ignore: unused_field
  static const Map<String, dynamic> _ok = <String, dynamic>{'ok': true};

  /// Whether to log detailed errors with stack traces to stderr.
  ///
  /// Set via compile-time flag: `dart compile exe -D YT_MCP_DEBUG=true`
  /// In production, keep this false to avoid information leakage.
  static const bool debugMode = bool.fromEnvironment('YT_MCP_DEBUG');

  /// Returns the active client or throws a descriptive [StateError] when the
  /// caller forgot to set credentials.
  static Yt get _yt {
    final client = _client;
    if (client == null) {
      final errorContext = _bootstrapError != null
          ? ' Last attempt failed: $_bootstrapError'
          : '';
      throw StateError(
        'YouTube client not initialized. Set $envApiKey or $envOAuthToken in '
        'the environment.$errorContext',
      );
    }
    return client;
  }

  /// Bootstraps the YouTube client from environment variables.
  ///
  /// Reads `YT_API_KEY` for API key authentication (read-only public data),
  /// `YT_OAUTH_TOKEN` for raw OAuth token authentication, or
  /// `YT_CLIENT_SECRETS_FILE` + `YT_ACCESS_TOKENS_FILE` for file-based OAuth
  /// authentication (full access).
  static Future<void> bootstrapFromEnv() async {
    try {
      final apiKey = Platform.environment[envApiKey];
      final oAuthToken = Platform.environment[envOAuthToken];
      final clientSecretsFile = Platform.environment[envClientSecretsFile];
      final accessTokensFile = Platform.environment[envAccessTokensFile];

      // Priority 1: API key (read-only)
      if (apiKey != null && apiKey.isNotEmpty) {
        _client = Yt.withApiKey(apiKey: apiKey);
        return;
      }

      // Priority 2: Raw OAuth token
      if (oAuthToken != null && oAuthToken.isNotEmpty) {
        // Basic validation: OAuth tokens are typically long strings
        if (oAuthToken.length < 10) {
          _bootstrapError =
              '$envOAuthToken appears to be invalid (too short, expected >= 10 characters).';
          return;
        }
        _client = Yt.withOAuth();
        return;
      }

      // Priority 3: File-based OAuth (client_secrets.json + access_tokens.json)
      if (clientSecretsFile != null && clientSecretsFile.isNotEmpty) {
        // Validate that the client secrets file exists
        final secretsFile = File(clientSecretsFile);
        if (!secretsFile.existsSync()) {
          _bootstrapError =
              '$envClientSecretsFile points to "$clientSecretsFile" but the file does not exist.';
          return;
        }

        // If access tokens file is also set, validate it exists too
        if (accessTokensFile != null && accessTokensFile.isNotEmpty) {
          final tokensFile = File(accessTokensFile);
          if (!tokensFile.existsSync()) {
            _bootstrapError =
                '$envAccessTokensFile points to "$accessTokensFile" but the file does not exist. '
                'Run "yt authorize" to generate it, or delete the variable to trigger interactive OAuth flow.';
            return;
          }
        }

        // Initialize with file-based OAuth
        // Yt.withOAuth() will read YT_CLIENT_SECRETS_FILE and YT_ACCESS_TOKENS_FILE
        // from the environment automatically
        _client = Yt.withOAuth();
        return;
      }

      // No credentials found
      _bootstrapError =
          'No YouTube credentials found. Set one of:\n'
          '- $envApiKey (for read-only access)\n'
          '- $envOAuthToken (for OAuth token)\n'
          '- $envClientSecretsFile + $envAccessTokensFile (for file-based OAuth)';
    } catch (e) {
      _bootstrapError = e.toString();
    }
  }

  // -----------------------------------------------------------------------
  // Channels
  // -----------------------------------------------------------------------

  @Tool(
    name: 'channels_list',
    description: 'List YouTube channels by ID or username.',
  )
  Future<Map<String, dynamic>> channelsList({
    @Parameter(description: 'Comma-separated channel property names')
    String? part,
    @Parameter(description: 'Comma-separated channel IDs') String? id,
    @Parameter(description: 'YouTube username') String? forUsername,
    @Parameter(description: 'Maximum items to return (1-50)') int? maxResults,
  }) async {
    final response = await _yt.channels.list(
      part: part ?? 'snippet',
      id: id,
      forUsername: forUsername,
      maxResults: maxResults ?? 5,
    );
    return response.toJson();
  }

  @Tool(
    name: 'channels_update',
    description: 'Update channel metadata (requires OAuth).',
  )
  Future<Map<String, dynamic>> channelsUpdate({
    @Parameter(description: 'Comma-separated channel property names')
    String part = 'snippet',
    @Parameter(
      description:
          'Channel resource as JSON with properties to update (must include id and snippet)',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    final response = await _yt.channels.update(
      part: part,
      body: body,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return response.toJson();
  }

  // -----------------------------------------------------------------------
  // Search
  // -----------------------------------------------------------------------

  @Tool(
    name: 'search_list',
    description: 'Search YouTube for videos, channels, and playlists.',
  )
  Future<Map<String, dynamic>> searchList({
    @Parameter(description: 'Search query term') required String q,
    @Parameter(description: 'Comma-separated resource property names')
    String part = 'snippet',
    @Parameter(description: 'Resource type filter (video, channel, playlist)')
    String? type,
    @Parameter(description: 'Maximum items to return (1-50)')
    int maxResults = 5,
  }) async {
    final response = await _yt.search.list(
      q: q,
      part: part,
      type: type,
      maxResults: maxResults,
    );
    return response.toJson();
  }

  // -----------------------------------------------------------------------
  // Videos
  // -----------------------------------------------------------------------

  @Tool(name: 'videos_list', description: 'List YouTube videos by ID or chart.')
  Future<Map<String, dynamic>> videosList({
    @Parameter(description: 'Comma-separated video IDs') String? id,
    @Parameter(description: 'Chart type (mostPopular)') String? chart,
    @Parameter(description: 'Comma-separated video property names')
    String part = 'snippet',
    @Parameter(description: 'Maximum items to return (1-50)')
    int maxResults = 5,
  }) async {
    final response = await _yt.videos.list(
      id: id,
      chart: chart,
      part: part,
      maxResults: maxResults,
    );
    return response.toJson();
  }

  @Tool(
    name: 'videos_insert',
    description:
        'Upload a video to YouTube (requires OAuth). Provide the video file path.',
  )
  Future<Map<String, dynamic>> videosInsert({
    @Parameter(description: 'Video metadata as JSON (snippet, status, etc.)')
    required Map<String, dynamic> body,
    @Parameter(description: 'Absolute or relative path to the video file')
    required String videoFilePath,
    @Parameter(description: 'Comma-separated video property names')
    String part = 'snippet,status,contentDetails',
    @Parameter(description: 'Whether to notify subscribers')
    bool? notifySubscribers,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    final response = await _yt.videos.insert(
      body: body,
      videoFile: File(videoFilePath),
      part: part,
      notifySubscribers: notifySubscribers,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return response.toJson();
  }

  @Tool(
    name: 'videos_update',
    description: 'Update video metadata (requires OAuth).',
  )
  Future<Map<String, dynamic>> videosUpdate({
    @Parameter(
      description:
          'Video resource as JSON with properties to update (must include id)',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Comma-separated video property names')
    String part = 'snippet,status,contentDetails',
  }) async {
    final response = await _yt.videos.update(body: body, part: part);
    return response.toJson();
  }

  @Tool(
    name: 'videos_rate',
    description:
        'Like, dislike, or remove rating for a video (requires OAuth).',
  )
  Future<Map<String, dynamic>> videosRate({
    @Parameter(description: 'Video ID') required String id,
    @Parameter(description: 'Rating: "like", "dislike", or "none"')
    required String rating,
  }) async {
    await _yt.videos.rate(id: id, rating: rating);
    return _ok;
  }

  @Tool(
    name: 'videos_get_rating',
    description:
        'Get the rating that the authorized user gave to a video (requires OAuth).',
  )
  Future<Map<String, dynamic>> videosGetRating({
    @Parameter(description: 'Comma-separated video IDs') required String id,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    final response = await _yt.videos.getRating(
      id: id,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return response.toJson();
  }

  @Tool(
    name: 'videos_report_abuse',
    description: 'Report a video for abusive content (requires OAuth).',
  )
  Future<Map<String, dynamic>> videosReportAbuse({
    @Parameter(
      description: 'ReportAbuse resource as JSON with reasonId and videoId',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    await _yt.videos.reportAbuse(
      body: ReportAbuse.fromJson(body),
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return _ok;
  }

  @Tool(name: 'videos_delete', description: 'Delete a video (requires OAuth).')
  Future<Map<String, dynamic>> videosDelete({
    @Parameter(description: 'Video ID') required String id,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    await _yt.videos.delete(
      id: id,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return _ok;
  }

  // -----------------------------------------------------------------------
  // Playlists
  // -----------------------------------------------------------------------

  @Tool(name: 'playlists_list', description: 'List YouTube playlists.')
  Future<Map<String, dynamic>> playlistsList({
    @Parameter(description: 'Channel ID to list playlists for')
    String? channelId,
    @Parameter(description: 'Comma-separated playlist IDs') String? id,
    @Parameter(description: 'Comma-separated playlist property names')
    String part = 'snippet',
    @Parameter(description: 'Maximum items to return (1-50)')
    int maxResults = 5,
  }) async {
    final response = await _yt.playlists.list(
      channelId: channelId,
      id: id,
      part: part,
      maxResults: maxResults,
    );
    return response.toJson();
  }

  @Tool(
    name: 'playlists_insert',
    description: 'Create a playlist (requires OAuth).',
  )
  Future<Map<String, dynamic>> playlistsInsert({
    @Parameter(
      description:
          'Playlist resource as JSON with snippet (title, description, privacyStatus)',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Comma-separated playlist property names')
    String part = 'snippet,contentDetails,status',
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    final response = await _yt.playlists.insert(
      body: body,
      part: part,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return response.toJson();
  }

  @Tool(
    name: 'playlists_update',
    description: 'Update playlist metadata (requires OAuth).',
  )
  Future<Map<String, dynamic>> playlistsUpdate({
    @Parameter(
      description: 'Playlist resource as JSON with id and updated properties',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Comma-separated playlist property names')
    String part = 'snippet,contentDetails,status',
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    final response = await _yt.playlists.update(
      body: body,
      part: part,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return response.toJson();
  }

  @Tool(
    name: 'playlists_delete',
    description: 'Delete a playlist (requires OAuth).',
  )
  Future<Map<String, dynamic>> playlistsDelete({
    @Parameter(description: 'Playlist ID') required String id,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    await _yt.playlists.delete(
      id: id,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return _ok;
  }

  // -----------------------------------------------------------------------
  // Comments
  // -----------------------------------------------------------------------

  @Tool(name: 'comments_list', description: 'List YouTube comments.')
  Future<Map<String, dynamic>> commentsList({
    @Parameter(description: 'Comma-separated comment property names')
    String part = 'snippet',
    @Parameter(description: 'Parent comment ID') String? parentId,
    @Parameter(description: 'Maximum items to return') int maxResults = 20,
  }) async {
    final response = await _yt.comments.list(
      part: part,
      parentId: parentId,
      maxResults: maxResults,
    );
    return response.toJson();
  }

  @Tool(
    name: 'comments_list_by_ids',
    description: 'List comments by their IDs.',
  )
  Future<Map<String, dynamic>> commentsListByIds({
    @Parameter(description: 'Comma-separated comment IDs') required String ids,
    @Parameter(description: 'Maximum items to return') int? maxResults,
    @Parameter(description: 'Page token for pagination') String? pageToken,
    @Parameter(description: 'Text format: "html" or "plainText"')
    String? textFormat,
  }) async {
    final response = await _yt.comments.listByIds(
      ids: ids.split(',').map((e) => e.trim()).toList(),
      maxResults: maxResults,
      pageToken: pageToken,
      textFormat: textFormat != null
          ? TextFormat.values.byName(textFormat)
          : TextFormat.html,
    );
    return response.toJson();
  }

  @Tool(name: 'comments_list_by_id', description: 'Get a single comment by ID.')
  Future<Map<String, dynamic>> commentsListById({
    @Parameter(description: 'Comment ID') required String id,
    @Parameter(description: 'Text format: "html" or "plainText"')
    String? textFormat,
  }) async {
    final response = await _yt.comments.listById(
      id: id,
      textFormat: textFormat != null
          ? TextFormat.values.byName(textFormat)
          : TextFormat.html,
    );
    return response.toJson();
  }

  @Tool(
    name: 'comments_list_by_parent_id',
    description: 'List replies to a comment.',
  )
  Future<Map<String, dynamic>> commentsListByParentId({
    @Parameter(description: 'Parent comment ID') required String parentId,
    @Parameter(description: 'Maximum items to return') int? maxResults,
    @Parameter(description: 'Page token for pagination') String? pageToken,
    @Parameter(description: 'Text format: "html" or "plainText"')
    String? textFormat,
  }) async {
    final response = await _yt.comments.listByParentId(
      parentId: parentId,
      maxResults: maxResults,
      pageToken: pageToken,
      textFormat: textFormat != null
          ? TextFormat.values.byName(textFormat)
          : TextFormat.html,
    );
    return response.toJson();
  }

  @Tool(
    name: 'comments_insert',
    description: 'Create a comment reply (requires OAuth).',
  )
  Future<Map<String, dynamic>> commentsInsert({
    @Parameter(
      description:
          'Comment resource as JSON with snippet (parentId, textOriginal)',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Comma-separated comment property names')
    String part = 'snippet',
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    final response = await _yt.comments.insert(
      body: body,
      part: part,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return response.toJson();
  }

  @Tool(
    name: 'comments_add',
    description: 'Add a reply to a comment (requires OAuth). Helper method.',
  )
  Future<Map<String, dynamic>> commentsAdd({
    @Parameter(description: 'Parent comment ID') required String parentId,
    @Parameter(description: 'Comment text') required String textOriginal,
  }) async {
    final response = await _yt.comments.add(
      parentId: parentId,
      textOriginal: textOriginal,
    );
    return response.toJson();
  }

  @Tool(
    name: 'comments_update',
    description: 'Update a comment (requires OAuth).',
  )
  Future<Map<String, dynamic>> commentsUpdate({
    @Parameter(
      description: 'Comment resource as JSON with id and updated snippet',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Comma-separated comment property names')
    String part = 'id,snippet',
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    final response = await _yt.comments.update(
      body: body,
      part: part,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return response.toJson();
  }

  @Tool(
    name: 'comments_change',
    description: 'Change comment text (requires OAuth). Helper method.',
  )
  Future<Map<String, dynamic>> commentsChange({
    @Parameter(description: 'Comment ID') required String commentId,
    @Parameter(description: 'New comment text') required String textOriginal,
  }) async {
    final response = await _yt.comments.change(
      commentId: commentId,
      textOriginal: textOriginal,
    );
    return response.toJson();
  }

  @Tool(
    name: 'comments_set_moderation_status',
    description: 'Set moderation status for comments (requires OAuth).',
  )
  Future<Map<String, dynamic>> commentsSetModerationStatus({
    @Parameter(description: 'Comma-separated comment IDs') required String id,
    @Parameter(
      description:
          'Moderation status: "heldForReview", "likelySpam", "published", or "rejected"',
    )
    required String moderationStatus,
    @Parameter(
      description:
          'Ban the author (only valid when moderationStatus is "rejected")',
    )
    bool? banAuthor,
  }) async {
    await _yt.comments.setModerationStatus(
      id: id,
      moderationStatus: ModerationStatus.values.byName(moderationStatus),
      banAuthor: banAuthor,
    );
    return _ok;
  }

  @Tool(
    name: 'comments_delete',
    description: 'Delete a comment (requires OAuth).',
  )
  Future<Map<String, dynamic>> commentsDelete({
    @Parameter(description: 'Comment ID') required String id,
  }) async {
    await _yt.comments.delete(id: id);
    return _ok;
  }

  // -----------------------------------------------------------------------
  // Comment Threads
  // -----------------------------------------------------------------------

  @Tool(
    name: 'comment_threads_list',
    description: 'List YouTube comment threads for a video.',
  )
  Future<Map<String, dynamic>> commentThreadsList({
    @Parameter(description: 'Comma-separated comment thread property names')
    String part = 'snippet',
    @Parameter(description: 'Video ID') String? videoId,
    @Parameter(description: 'Maximum items to return') int maxResults = 20,
  }) async {
    final response = await _yt.commentThreads.list(
      part: part,
      videoId: videoId,
      maxResults: maxResults,
    );
    return response.toJson();
  }

  @Tool(
    name: 'comment_threads_list_by_video_id',
    description: 'List comment threads for a specific video.',
  )
  Future<Map<String, dynamic>> commentThreadsListByVideoId({
    @Parameter(description: 'Video ID') required String videoId,
    @Parameter(description: 'Maximum items to return') int? maxResults,
    @Parameter(description: 'Moderation status filter')
    String? moderationStatus,
    @Parameter(description: 'Sort order: "time" or "relevance"') String? order,
    @Parameter(description: 'Page token for pagination') String? pageToken,
    @Parameter(description: 'Search terms to filter by') String? searchTerms,
    @Parameter(description: 'Text format: "html" or "plainText"')
    String? textFormat,
  }) async {
    final response = await _yt.commentThreads.listByVideoId(
      videoId: videoId,
      maxResults: maxResults,
      moderationStatus: moderationStatus != null
          ? ModerationStatus.values.byName(moderationStatus)
          : null,
      order: order,
      pageToken: pageToken,
      searchTerms: searchTerms,
      textFormat: textFormat,
    );
    return response.toJson();
  }

  @Tool(
    name: 'comment_threads_list_by_ids',
    description: 'List comment threads by their IDs.',
  )
  Future<Map<String, dynamic>> commentThreadsListByIds({
    @Parameter(description: 'Comma-separated comment thread IDs')
    required String ids,
    @Parameter(description: 'Maximum items to return') int? maxResults,
    @Parameter(description: 'Moderation status filter')
    String? moderationStatus,
    @Parameter(description: 'Sort order') String? order,
    @Parameter(description: 'Page token for pagination') String? pageToken,
    @Parameter(description: 'Search terms') String? searchTerms,
    @Parameter(description: 'Text format') String? textFormat,
  }) async {
    final response = await _yt.commentThreads.listByIds(
      ids: ids.split(',').map((e) => e.trim()).toList(),
      maxResults: maxResults,
      moderationStatus: moderationStatus != null
          ? ModerationStatus.values.byName(moderationStatus)
          : null,
      order: order,
      pageToken: pageToken,
      searchTerms: searchTerms,
      textFormat: textFormat,
    );
    return response.toJson();
  }

  @Tool(
    name: 'comment_threads_list_by_id',
    description: 'Get a single comment thread by ID.',
  )
  Future<Map<String, dynamic>> commentThreadsListById({
    @Parameter(description: 'Comment thread ID') required String id,
    @Parameter(description: 'Moderation status filter')
    String? moderationStatus,
    @Parameter(description: 'Search terms') String? searchTerms,
    @Parameter(description: 'Text format') String? textFormat,
  }) async {
    final response = await _yt.commentThreads.listById(
      id: id,
      moderationStatus: moderationStatus != null
          ? ModerationStatus.values.byName(moderationStatus)
          : null,
      searchTerms: searchTerms,
      textFormat: textFormat,
    );
    return response.toJson();
  }

  @Tool(
    name: 'comment_threads_list_by_channel_id',
    description: 'List all comment threads related to a channel.',
  )
  Future<Map<String, dynamic>> commentThreadsListByChannelId({
    @Parameter(description: 'Channel ID') required String channelId,
    @Parameter(description: 'Maximum items to return') int? maxResults,
    @Parameter(description: 'Moderation status filter')
    String? moderationStatus,
    @Parameter(description: 'Sort order') String? order,
    @Parameter(description: 'Page token for pagination') String? pageToken,
    @Parameter(description: 'Search terms') String? searchTerms,
    @Parameter(description: 'Text format') String? textFormat,
  }) async {
    final response = await _yt.commentThreads.listByChannelId(
      channelId: channelId,
      maxResults: maxResults,
      moderationStatus: moderationStatus != null
          ? ModerationStatus.values.byName(moderationStatus)
          : null,
      order: order,
      pageToken: pageToken,
      searchTerms: searchTerms,
      textFormat: textFormat,
    );
    return response.toJson();
  }

  @Tool(
    name: 'comment_threads_insert',
    description: 'Create a new top-level comment thread (requires OAuth).',
  )
  Future<Map<String, dynamic>> commentThreadsInsert({
    @Parameter(
      description:
          'Comment thread resource as JSON with snippet (videoId, topLevelComment)',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet',
  }) async {
    final response = await _yt.commentThreads.insert(body: body, part: part);
    return response.toJson();
  }

  @Tool(
    name: 'comment_threads_add',
    description:
        'Add a top-level comment to a video (requires OAuth). Helper method.',
  )
  Future<Map<String, dynamic>> commentThreadsAdd({
    @Parameter(description: 'Video ID') required String videoId,
    @Parameter(description: 'Comment text') required String textOriginal,
  }) async {
    final response = await _yt.commentThreads.add(
      videoId: videoId,
      textOriginal: textOriginal,
    );
    return response.toJson();
  }

  // -----------------------------------------------------------------------
  // Members
  // -----------------------------------------------------------------------

  @Tool(
    name: 'members_list',
    description: 'Lists channel members (requires OAuth).',
  )
  Future<Map<String, dynamic>> membersList({
    @Parameter(description: 'Comma-separated member property names')
    String part = 'snippet',
    @Parameter(description: 'Mode: allCurrentMembers or updatesSince')
    String? mode,
    @Parameter(description: 'Maximum items to return') int? maxResults,
    @Parameter(description: 'Page token for pagination') String? pageToken,
  }) async {
    final response = await _yt.members.list(
      part: part,
      mode: mode,
      maxResults: maxResults,
      pageToken: pageToken,
    );
    return response.toJson();
  }

  // -----------------------------------------------------------------------
  // MembershipsLevels
  // -----------------------------------------------------------------------

  @Tool(
    name: 'memberships_levels_list',
    description: 'Lists membership levels for the channel (requires OAuth).',
  )
  Future<Map<String, dynamic>> membershipsLevelsList({
    @Parameter(description: 'Comma-separated level property names')
    String part = 'id,snippet',
  }) async {
    final response = await _yt.membershipsLevels.list(part: part);
    return response.toJson();
  }

  // -----------------------------------------------------------------------
  // VideoAbuseReportReasons
  // -----------------------------------------------------------------------

  @Tool(
    name: 'video_abuse_report_reasons_list',
    description:
        'Retrieves reasons for reporting abusive videos (requires OAuth).',
  )
  Future<Map<String, dynamic>> videoAbuseReportReasonsList({
    @Parameter(description: 'Comma-separated resource property names')
    String part = 'id,snippet',
    @Parameter(description: 'Language code for localized labels') String? hl,
  }) async {
    final response = await _yt.videoAbuseReportReasons.list(part: part, hl: hl);
    return response.toJson();
  }

  // -----------------------------------------------------------------------
  // PlaylistItems
  // -----------------------------------------------------------------------

  @Tool(name: 'playlist_items_list', description: 'List items in a playlist.')
  Future<Map<String, dynamic>> playlistItemsList({
    @Parameter(description: 'Playlist ID') required String playlistId,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet,contentDetails',
    @Parameter(description: 'Comma-separated playlist item IDs') String? id,
    @Parameter(description: 'Maximum items to return') int? maxResults,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'Filter by video ID') String? videoId,
    @Parameter(description: 'Page token for pagination') String? pageToken,
  }) async {
    final response = await _yt.playlistItems.list(
      playlistId: playlistId,
      part: part,
      id: id,
      maxResults: maxResults,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      videoId: videoId,
      pageToken: pageToken,
    );
    return response.toJson();
  }

  @Tool(
    name: 'playlist_items_insert',
    description: 'Add an item to a playlist (requires OAuth).',
  )
  Future<Map<String, dynamic>> playlistItemsInsert({
    @Parameter(
      description:
          'PlaylistItem resource as JSON with snippet (playlistId, resourceId)',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet,contentDetails',
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    final response = await _yt.playlistItems.insert(
      body: body,
      part: part,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return response.toJson();
  }

  @Tool(
    name: 'playlist_items_update',
    description: 'Update a playlist item (requires OAuth).',
  )
  Future<Map<String, dynamic>> playlistItemsUpdate({
    @Parameter(
      description: 'PlaylistItem resource as JSON with id and updated snippet',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet,contentDetails',
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    final response = await _yt.playlistItems.update(
      body: body,
      part: part,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return response.toJson();
  }

  @Tool(
    name: 'playlist_items_delete',
    description: 'Remove an item from a playlist (requires OAuth).',
  )
  Future<Map<String, dynamic>> playlistItemsDelete({
    @Parameter(description: 'Playlist item ID') required String id,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    await _yt.playlistItems.delete(
      id: id,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return _ok;
  }

  // -----------------------------------------------------------------------
  // Subscriptions
  // -----------------------------------------------------------------------

  @Tool(name: 'subscriptions_list', description: 'List subscriptions.')
  Future<Map<String, dynamic>> subscriptionsList({
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet,contentDetails',
    @Parameter(description: 'Channel ID') String? channelId,
    @Parameter(description: 'Comma-separated subscription IDs') String? id,
    @Parameter(description: 'Return authenticated user\'s subscriptions')
    bool? mine,
    @Parameter(description: 'Return recent subscribers')
    bool? myRecentSubscribers,
    @Parameter(description: 'Return all subscribers') bool? mySubscribers,
    @Parameter(description: 'Filter by channel ID') String? forChannelId,
    @Parameter(description: 'Maximum items to return') int? maxResults,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
    @Parameter(description: 'Sort order') String? order,
    @Parameter(description: 'Page token for pagination') String? pageToken,
  }) async {
    final response = await _yt.subscriptions.list(
      part: part,
      channelId: channelId,
      id: id,
      mine: mine,
      myRecentSubscribers: myRecentSubscribers,
      mySubscribers: mySubscribers,
      forChannelId: forChannelId,
      maxResults: maxResults,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
      order: order,
      pageToken: pageToken,
    );
    return response.toJson();
  }

  @Tool(
    name: 'subscriptions_insert',
    description: 'Subscribe to a channel (requires OAuth).',
  )
  Future<Map<String, dynamic>> subscriptionsInsert({
    @Parameter(
      description:
          'Subscription resource as JSON with snippet (resourceId with channelId)',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet,contentDetails',
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    final response = await _yt.subscriptions.insert(
      body: body,
      part: part,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return response.toJson();
  }

  @Tool(
    name: 'subscriptions_delete',
    description: 'Unsubscribe from a channel (requires OAuth).',
  )
  Future<Map<String, dynamic>> subscriptionsDelete({
    @Parameter(description: 'Subscription ID') required String id,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    await _yt.subscriptions.delete(
      id: id,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return _ok;
  }

  // -----------------------------------------------------------------------
  // Activities
  // -----------------------------------------------------------------------

  @Tool(name: 'activities_list', description: 'List channel activities.')
  Future<Map<String, dynamic>> activitiesList({
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet,contentDetails',
    @Parameter(description: 'Channel ID') String? channelId,
    @Parameter(description: 'Return authenticated user\'s activities')
    bool? mine,
    @Parameter(description: 'Maximum items to return') int? maxResults,
    @Parameter(description: 'Page token for pagination') String? pageToken,
    @Parameter(description: 'Published after (RFC 3339)')
    String? publishedAfter,
    @Parameter(description: 'Published before (RFC 3339)')
    String? publishedBefore,
    @Parameter(description: 'Region code') String? regionCode,
  }) async {
    final response = await _yt.activities.list(
      part: part,
      channelId: channelId,
      mine: mine,
      maxResults: maxResults,
      pageToken: pageToken,
      publishedAfter: publishedAfter,
      publishedBefore: publishedBefore,
      regionCode: regionCode,
    );
    return response.toJson();
  }

  // -----------------------------------------------------------------------
  // VideoCategories
  // -----------------------------------------------------------------------

  @Tool(name: 'video_categories_list', description: 'List video categories.')
  Future<Map<String, dynamic>> videoCategoriesList({
    @Parameter(description: 'Comma-separated category IDs') String? id,
    @Parameter(description: 'Region code (e.g., "US")') String? regionCode,
    @Parameter(description: 'Language code for labels') String? hl,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet',
  }) async {
    final response = await _yt.videoCategories.list(
      part: part,
      id: id,
      regionCode: regionCode,
      hl: hl,
    );
    return response.toJson();
  }

  // -----------------------------------------------------------------------
  // Captions
  // -----------------------------------------------------------------------

  @Tool(name: 'captions_list', description: 'List caption tracks for a video.')
  Future<Map<String, dynamic>> captionsList({
    @Parameter(description: 'Video ID') required String videoId,
    @Parameter(description: 'Comma-separated caption IDs') String? id,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'Comma-separated property names')
    String part = 'id,snippet',
  }) async {
    final response = await _yt.captions.list(
      videoId: videoId,
      part: part,
      id: id,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return response.toJson();
  }

  @Tool(
    name: 'captions_insert',
    description: 'Upload a caption track (requires OAuth).',
  )
  Future<Map<String, dynamic>> captionsInsert({
    @Parameter(
      description: 'Caption snippet as JSON (videoId, language, name, isDraft)',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Absolute or relative path to the caption file')
    required String captionFilePath,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet',
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    final response = await _yt.captions.insert(
      body: body,
      captionFile: File(captionFilePath),
      part: part,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return response.toJson();
  }

  @Tool(
    name: 'captions_update',
    description: 'Update a caption track (requires OAuth).',
  )
  Future<Map<String, dynamic>> captionsUpdate({
    @Parameter(
      description: 'Caption snippet as JSON with id and updated properties',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Absolute or relative path to the caption file')
    required String captionFilePath,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet',
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    final response = await _yt.captions.update(
      body: body,
      captionFile: File(captionFilePath),
      part: part,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return response.toJson();
  }

  @Tool(
    name: 'captions_delete',
    description: 'Delete a caption track (requires OAuth).',
  )
  Future<Map<String, dynamic>> captionsDelete({
    @Parameter(description: 'Caption ID') required String id,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    await _yt.captions.delete(
      id: id,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return _ok;
  }

  @Tool(name: 'captions_download', description: 'Download a caption track.')
  Future<Map<String, dynamic>> captionsDownload({
    @Parameter(description: 'Caption ID') required String id,
    @Parameter(description: 'Caption format: "srt", "vtt", "sbv"') String? tfmt,
    @Parameter(description: 'Target language for auto-translate') String? tlang,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    final content = await _yt.captions.download(
      id: id,
      tfmt: tfmt,
      tlang: tlang,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return {'content': content};
  }

  // -----------------------------------------------------------------------
  // Thumbnails
  // -----------------------------------------------------------------------

  @Tool(
    name: 'thumbnails_set',
    description: 'Set a custom thumbnail for a video (requires OAuth).',
  )
  Future<Map<String, dynamic>> thumbnailsSet({
    @Parameter(description: 'Video ID') required String videoId,
    @Parameter(
      description: 'Absolute or relative path to the thumbnail image file',
    )
    required String thumbnailFilePath,
  }) async {
    final response = await _yt.thumbnails.set(
      videoId: videoId,
      thumbnail: File(thumbnailFilePath),
    );
    return response.toJson();
  }

  // -----------------------------------------------------------------------
  // Watermarks
  // -----------------------------------------------------------------------

  @Tool(
    name: 'watermarks_set',
    description: 'Set a channel watermark image (requires OAuth).',
  )
  Future<Map<String, dynamic>> watermarksSet({
    @Parameter(description: 'Channel ID') required String channelId,
    @Parameter(
      description:
          'WatermarksResource as JSON with imageUrl, positioning, timing',
    )
    required Map<String, dynamic> watermarksResource,
  }) async {
    final result = await _yt.watermarks.set(
      channelId: channelId,
      watermarksResource: WatermarksResource.fromJson(watermarksResource),
    );
    return {'ok': result};
  }

  @Tool(
    name: 'watermarks_unset',
    description: 'Remove a channel watermark (requires OAuth).',
  )
  Future<Map<String, dynamic>> watermarksUnset({
    @Parameter(description: 'Channel ID') required String channelId,
  }) async {
    final result = await _yt.watermarks.unset(channelId: channelId);
    return {'ok': result};
  }

  // -----------------------------------------------------------------------
  // ChannelBanners
  // -----------------------------------------------------------------------

  @Tool(
    name: 'channel_banners_insert',
    description: 'Upload a channel banner image (requires OAuth).',
  )
  Future<Map<String, dynamic>> channelBannersInsert({
    @Parameter(
      description: 'Absolute or relative path to the banner image file',
    )
    required String imageFilePath,
    @Parameter(description: 'Channel ID') String? channelId,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    final response = await _yt.channelBanners.insert(
      image: File(imageFilePath),
      channelId: channelId,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return response.toJson();
  }

  // -----------------------------------------------------------------------
  // ChannelSections
  // -----------------------------------------------------------------------

  @Tool(name: 'channel_sections_list', description: 'List channel sections.')
  Future<Map<String, dynamic>> channelSectionsList({
    @Parameter(description: 'Comma-separated property names')
    String part = 'contentDetails,id,snippet',
    @Parameter(description: 'Channel ID') String? channelId,
    @Parameter(description: 'Comma-separated section IDs') String? id,
    @Parameter(description: 'Return authenticated user\'s sections') bool? mine,
    @Parameter(description: 'Language for localization') String? hl,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    final response = await _yt.channelSections.list(
      part: part,
      channelId: channelId,
      id: id,
      mine: mine,
      hl: hl,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return response.toJson();
  }

  @Tool(
    name: 'channel_sections_insert',
    description: 'Add a channel section (requires OAuth).',
  )
  Future<Map<String, dynamic>> channelSectionsInsert({
    @Parameter(
      description:
          'ChannelSection resource as JSON with snippet and contentDetails',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Comma-separated property names')
    String part = 'contentDetails,id,snippet',
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    final response = await _yt.channelSections.insert(
      body: body,
      part: part,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return response.toJson();
  }

  @Tool(
    name: 'channel_sections_update',
    description: 'Update a channel section (requires OAuth).',
  )
  Future<Map<String, dynamic>> channelSectionsUpdate({
    @Parameter(
      description:
          'ChannelSection resource as JSON with id and updated properties',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Comma-separated property names')
    String part = 'contentDetails,id,snippet',
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    final response = await _yt.channelSections.update(
      body: body,
      part: part,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return response.toJson();
  }

  @Tool(
    name: 'channel_sections_delete',
    description: 'Delete a channel section (requires OAuth).',
  )
  Future<Map<String, dynamic>> channelSectionsDelete({
    @Parameter(description: 'Channel section ID') required String id,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    await _yt.channelSections.delete(
      id: id,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return _ok;
  }

  // -----------------------------------------------------------------------
  // I18nLanguages
  // -----------------------------------------------------------------------

  @Tool(
    name: 'i18n_languages_list',
    description: 'List supported UI languages.',
  )
  Future<Map<String, dynamic>> i18nLanguagesList({
    @Parameter(description: 'Language code for localized names') String? hl,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet',
  }) async {
    final response = await _yt.i18nLanguages.list(part: part, hl: hl);
    return response.toJson();
  }

  // -----------------------------------------------------------------------
  // I18nRegions
  // -----------------------------------------------------------------------

  @Tool(
    name: 'i18n_regions_list',
    description: 'List supported content regions.',
  )
  Future<Map<String, dynamic>> i18nRegionsList({
    @Parameter(description: 'Language code for localized names') String? hl,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet',
  }) async {
    final response = await _yt.i18nRegions.list(part: part, hl: hl);
    return response.toJson();
  }

  // -----------------------------------------------------------------------
  // PlaylistImages
  // -----------------------------------------------------------------------

  @Tool(
    name: 'playlist_images_list',
    description: 'List custom images for a playlist.',
  )
  Future<Map<String, dynamic>> playlistImagesList({
    @Parameter(description: 'Playlist parent (e.g., "playlists/PLAYLIST_ID")')
    required String parent,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet',
    @Parameter(description: 'Maximum items to return') int? maxResults,
    @Parameter(description: 'Page token for pagination') String? pageToken,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    final response = await _yt.playlistImages.list(
      parent: parent,
      part: part,
      maxResults: maxResults,
      pageToken: pageToken,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return response.toJson();
  }

  @Tool(
    name: 'playlist_images_insert',
    description: 'Upload a custom playlist image (requires OAuth).',
  )
  Future<Map<String, dynamic>> playlistImagesInsert({
    @Parameter(description: 'Playlist parent') required String parent,
    @Parameter(description: 'Absolute or relative path to the image file')
    required String imageFilePath,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet',
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    final response = await _yt.playlistImages.insert(
      parent: parent,
      image: File(imageFilePath),
      part: part,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return response.toJson();
  }

  @Tool(
    name: 'playlist_images_update',
    description: 'Replace a playlist image (requires OAuth).',
  )
  Future<Map<String, dynamic>> playlistImagesUpdate({
    @Parameter(description: 'Absolute or relative path to the new image file')
    required String imageFilePath,
    @Parameter(description: 'Comma-separated property names')
    String part = 'id,snippet',
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    final response = await _yt.playlistImages.update(
      image: File(imageFilePath),
      part: part,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return response.toJson();
  }

  @Tool(
    name: 'playlist_images_delete',
    description: 'Delete a playlist image (requires OAuth).',
  )
  Future<Map<String, dynamic>> playlistImagesDelete({
    @Parameter(description: 'Playlist image ID') required String id,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    await _yt.playlistImages.delete(
      id: id,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return _ok;
  }

  // -----------------------------------------------------------------------
  // ThirdPartyLinks
  // -----------------------------------------------------------------------

  @Tool(name: 'third_party_links_list', description: 'List third-party links.')
  Future<Map<String, dynamic>> thirdPartyLinksList({
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet,status',
    @Parameter(description: 'External channel ID') String? externalChannelId,
    @Parameter(description: 'Linking token') String? linkingToken,
    @Parameter(description: 'Link type') String? type,
  }) async {
    final response = await _yt.thirdPartyLinks.list(
      part: part,
      externalChannelId: externalChannelId,
      linkingToken: linkingToken,
      type: type,
    );
    return response.toJson();
  }

  @Tool(
    name: 'third_party_links_insert',
    description: 'Create a third-party link (requires OAuth).',
  )
  Future<Map<String, dynamic>> thirdPartyLinksInsert({
    @Parameter(description: 'ThirdPartyLink resource as JSON')
    required Map<String, dynamic> body,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet,status',
    @Parameter(description: 'External channel ID') String? externalChannelId,
  }) async {
    final response = await _yt.thirdPartyLinks.insert(
      body: body,
      part: part,
      externalChannelId: externalChannelId,
    );
    return response.toJson();
  }

  @Tool(
    name: 'third_party_links_update',
    description: 'Update a third-party link (requires OAuth).',
  )
  Future<Map<String, dynamic>> thirdPartyLinksUpdate({
    @Parameter(
      description: 'ThirdPartyLink resource as JSON with updated properties',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet,status',
    @Parameter(description: 'External channel ID') String? externalChannelId,
  }) async {
    final response = await _yt.thirdPartyLinks.update(
      body: body,
      part: part,
      externalChannelId: externalChannelId,
    );
    return response.toJson();
  }

  @Tool(
    name: 'third_party_links_delete',
    description: 'Delete a third-party link (requires OAuth).',
  )
  Future<Map<String, dynamic>> thirdPartyLinksDelete({
    @Parameter(description: 'Linking token') required String linkingToken,
    @Parameter(description: 'Link type') required String type,
    @Parameter(description: 'Comma-separated property names') String? part,
    @Parameter(description: 'External channel ID') String? externalChannelId,
  }) async {
    await _yt.thirdPartyLinks.delete(
      linkingToken: linkingToken,
      type: type,
      part: part,
      externalChannelId: externalChannelId,
    );
    return _ok;
  }

  // -----------------------------------------------------------------------
  // Broadcast / Live
  // -----------------------------------------------------------------------

  @Tool(name: 'broadcasts_list', description: 'List live broadcasts.')
  Future<Map<String, dynamic>> broadcastsList({
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet,status,contentDetails',
    @Parameter(
      description: 'Broadcast status: "all", "active", "completed", "upcoming"',
    )
    String? broadcastStatus,
    @Parameter(description: 'Broadcast type: "all", "event", "persistent"')
    String? broadcastType,
    @Parameter(description: 'Comma-separated broadcast IDs') String? id,
    @Parameter(description: 'Maximum items to return') int? maxResults,
    @Parameter(description: 'Return authenticated user\'s broadcasts')
    bool? mine,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
    @Parameter(description: 'Page token for pagination') String? pageToken,
  }) async {
    final response = await _yt.broadcast.list(
      part: part,
      broadcastStatus: broadcastStatus,
      broadcastType: broadcastType,
      id: id,
      maxResults: maxResults,
      mine: mine,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
      pageToken: pageToken,
    );
    return response.toJson();
  }

  @Tool(
    name: 'broadcasts_insert',
    description: 'Create a live broadcast (requires OAuth).',
  )
  Future<Map<String, dynamic>> broadcastsInsert({
    @Parameter(
      description:
          'LiveBroadcast resource as JSON with snippet, status, contentDetails',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet,status,contentDetails',
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    final response = await _yt.broadcast.insert(
      body: body,
      part: part,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return response.toJson();
  }

  @Tool(
    name: 'broadcasts_update',
    description: 'Update a live broadcast (requires OAuth).',
  )
  Future<Map<String, dynamic>> broadcastsUpdate({
    @Parameter(
      description:
          'LiveBroadcast resource as JSON with id and updated properties',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet,status,contentDetails',
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    final response = await _yt.broadcast.update(
      body: body,
      part: part,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return response.toJson();
  }

  @Tool(
    name: 'broadcasts_transition',
    description: 'Transition a broadcast to a new status (requires OAuth).',
  )
  Future<Map<String, dynamic>> broadcastsTransition({
    @Parameter(description: 'Broadcast ID') required String id,
    @Parameter(description: 'Target status: "testing", "live", "complete"')
    required String broadcastStatus,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet,status,contentDetails',
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    final response = await _yt.broadcast.transition(
      id: id,
      broadcastStatus: broadcastStatus,
      part: part,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return response.toJson();
  }

  @Tool(
    name: 'broadcasts_bind',
    description: 'Bind a broadcast to a stream (requires OAuth).',
  )
  Future<Map<String, dynamic>> broadcastsBind({
    @Parameter(description: 'Broadcast ID') required String id,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet,status,contentDetails',
    @Parameter(description: 'Stream ID (omit to unbind)') String? streamId,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    final response = await _yt.broadcast.bind(
      id: id,
      part: part,
      streamId: streamId,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return response.toJson();
  }

  @Tool(
    name: 'broadcasts_delete',
    description: 'Delete a live broadcast (requires OAuth).',
  )
  Future<Map<String, dynamic>> broadcastsDelete({
    @Parameter(description: 'Broadcast ID') required String id,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    await _yt.broadcast.delete(
      id: id,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return _ok;
  }

  @Tool(
    name: 'broadcasts_cuepoint',
    description: 'Insert a cuepoint into a live broadcast (requires OAuth).',
  )
  Future<Map<String, dynamic>> broadcastsCuepoint({
    @Parameter(description: 'Broadcast ID') required String id,
    @Parameter(
      description: 'Cuepoint resource as JSON with durationSeconds, etc.',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    final response = await _yt.broadcast.cuepoint(
      id: id,
      body: Cuepoint.fromJson(body),
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return response.toJson();
  }

  @Tool(
    name: 'broadcasts_get_active',
    description: 'Get the currently active broadcast.',
  )
  Future<Map<String, dynamic>> broadcastsGetActive() async {
    final response = await _yt.broadcast.getActiveBroadcast();
    return response.toJson();
  }

  @Tool(
    name: 'broadcasts_get_upcoming_and_active',
    description: 'Get upcoming and active broadcasts.',
  )
  Future<Map<String, dynamic>> broadcastsGetUpcomingAndActive() async {
    final response = await _yt.broadcast.getUpcomingAndActiveBroadcast();
    return response.toJson();
  }

  // -----------------------------------------------------------------------
  // LiveStream
  // -----------------------------------------------------------------------

  @Tool(name: 'live_streams_list', description: 'List live streams.')
  Future<Map<String, dynamic>> liveStreamsList({
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet,status,contentDetails',
    @Parameter(description: 'Comma-separated stream IDs') String? id,
    @Parameter(description: 'Return authenticated user\'s streams') bool? mine,
    @Parameter(description: 'Maximum items to return') int? maxResults,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
    @Parameter(description: 'Page token for pagination') String? pageToken,
  }) async {
    final response = await _yt.liveStream.list(
      part: part,
      id: id,
      mine: mine,
      maxResults: maxResults,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
      pageToken: pageToken,
    );
    return response.toJson();
  }

  @Tool(
    name: 'live_streams_insert',
    description: 'Create a live stream (requires OAuth).',
  )
  Future<Map<String, dynamic>> liveStreamsInsert({
    @Parameter(
      description: 'LiveStream resource as JSON with snippet, cdn, status',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet,status,contentDetails',
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    final response = await _yt.liveStream.insert(
      body: body,
      part: part,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return response.toJson();
  }

  @Tool(
    name: 'live_streams_update',
    description: 'Update a live stream (requires OAuth).',
  )
  Future<Map<String, dynamic>> liveStreamsUpdate({
    @Parameter(
      description: 'LiveStream resource as JSON with id and updated properties',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet,status,contentDetails',
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    final response = await _yt.liveStream.update(
      body: body,
      part: part,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return response.toJson();
  }

  @Tool(
    name: 'live_streams_delete',
    description: 'Delete a live stream (requires OAuth).',
  )
  Future<Map<String, dynamic>> liveStreamsDelete({
    @Parameter(description: 'Stream ID') required String id,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
    @Parameter(description: 'On behalf of content owner channel')
    String? onBehalfOfContentOwnerChannel,
  }) async {
    await _yt.liveStream.delete(
      id: id,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );
    return _ok;
  }

  // -----------------------------------------------------------------------
  // Chat / LiveChat
  // -----------------------------------------------------------------------

  @Tool(name: 'live_chat_list', description: 'List live chat messages.')
  Future<Map<String, dynamic>> liveChatList({
    @Parameter(description: 'Live chat ID') required String liveChatId,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet,authorDetails',
    @Parameter(description: 'Language code for localization') String? hl,
    @Parameter(description: 'Maximum items to return') int? maxResults,
    @Parameter(description: 'Page token for pagination') String? pageToken,
    @Parameter(description: 'Profile image size in pixels')
    int? profileImageSize,
  }) async {
    final response = await _yt.chat.list(
      liveChatId: liveChatId,
      part: part,
      hl: hl,
      maxResults: maxResults,
      pageToken: pageToken,
      profileImageSize: profileImageSize,
    );
    return response.toJson();
  }

  @Tool(
    name: 'live_chat_insert',
    description: 'Send a live chat message (requires OAuth).',
  )
  Future<Map<String, dynamic>> liveChatInsert({
    @Parameter(
      description:
          'LiveChatMessage resource as JSON with snippet (textMessageDetails)',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'Comma-separated property names')
    String part = 'snippet',
  }) async {
    final response = await _yt.chat.insert(body: body, part: part);
    return response.toJson();
  }

  @Tool(
    name: 'live_chat_delete',
    description: 'Delete a live chat message (requires OAuth).',
  )
  Future<Map<String, dynamic>> liveChatDelete({
    @Parameter(description: 'Chat message ID') required String id,
  }) async {
    await _yt.chat.delete(id: id);
    return _ok;
  }

  // -----------------------------------------------------------------------
  // Analytics
  // -----------------------------------------------------------------------

  @Tool(
    name: 'analytics_query',
    description: 'Query YouTube Analytics reports.',
  )
  Future<Map<String, dynamic>> analyticsQuery({
    @Parameter(
      description:
          'Analytics ID (e.g., "channel==CHANNEL_ID" or "contentOwner==OWNER")',
    )
    required String ids,
    @Parameter(description: 'Start date (YYYY-MM-DD)')
    required String startDate,
    @Parameter(description: 'End date (YYYY-MM-DD)') required String endDate,
    @Parameter(
      description:
          'Comma-separated metrics (e.g., "views,likes,subscribersGained")',
    )
    required String metrics,
    @Parameter(description: 'Comma-separated dimensions (e.g., "day,country")')
    String? dimensions,
    @Parameter(description: 'Filters (e.g., "country==US")') String? filters,
    @Parameter(description: 'Maximum results') int? maxResults,
    @Parameter(description: 'Comma-separated sort fields') String? sort,
    @Parameter(description: 'Start index') int? startIndex,
    @Parameter(description: 'Currency code (e.g., "USD")') String? currency,
    @Parameter(description: 'Include historical channel data')
    bool? includeHistoricalChannelData,
  }) async {
    final response = await _yt.analytics.query(
      ids: ids,
      startDate: startDate,
      endDate: endDate,
      metrics: metrics,
      dimensions: dimensions,
      filters: filters,
      maxResults: maxResults,
      sort: sort,
      startIndex: startIndex,
      currency: currency,
      includeHistoricalChannelData: includeHistoricalChannelData,
    );
    return response.toJson();
  }

  @Tool(name: 'analytics_groups_list', description: 'List analytics groups.')
  Future<Map<String, dynamic>> analyticsGroupsList({
    @Parameter(description: 'Group ID') String? id,
    @Parameter(description: 'Return authenticated user\'s groups') bool? mine,
    @Parameter(description: 'Page token for pagination') String? pageToken,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    final response = await _yt.analytics.groupsList(
      id: id,
      mine: mine,
      pageToken: pageToken,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return response.toJson();
  }

  @Tool(
    name: 'analytics_groups_insert',
    description: 'Create an analytics group (requires OAuth).',
  )
  Future<Map<String, dynamic>> analyticsGroupsInsert({
    @Parameter(description: 'AnalyticsGroup resource as JSON')
    required Map<String, dynamic> body,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    final response = await _yt.analytics.groupsInsert(
      body: body,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return response.toJson();
  }

  @Tool(
    name: 'analytics_groups_update',
    description: 'Update an analytics group (requires OAuth).',
  )
  Future<Map<String, dynamic>> analyticsGroupsUpdate({
    @Parameter(
      description: 'AnalyticsGroup resource as JSON with id and updates',
    )
    required Map<String, dynamic> body,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    final response = await _yt.analytics.groupsUpdate(
      body: body,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return response.toJson();
  }

  @Tool(
    name: 'analytics_groups_delete',
    description: 'Delete an analytics group (requires OAuth).',
  )
  Future<Map<String, dynamic>> analyticsGroupsDelete({
    @Parameter(description: 'Group ID') required String id,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    await _yt.analytics.groupsDelete(
      id: id,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return _ok;
  }

  @Tool(
    name: 'analytics_group_items_list',
    description: 'List items in an analytics group.',
  )
  Future<Map<String, dynamic>> analyticsGroupItemsList({
    @Parameter(description: 'Group ID') String? groupId,
    @Parameter(description: 'Group item ID') String? id,
    @Parameter(description: 'Page token for pagination') String? pageToken,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    final response = await _yt.analytics.groupItemsList(
      groupId: groupId,
      id: id,
      pageToken: pageToken,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return response.toJson();
  }

  @Tool(
    name: 'analytics_group_items_insert',
    description: 'Add an item to an analytics group (requires OAuth).',
  )
  Future<Map<String, dynamic>> analyticsGroupItemsInsert({
    @Parameter(description: 'AnalyticsGroupItem resource as JSON')
    required Map<String, dynamic> body,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    final response = await _yt.analytics.groupItemsInsert(
      body: body,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return response.toJson();
  }

  @Tool(
    name: 'analytics_group_items_delete',
    description: 'Remove an item from an analytics group (requires OAuth).',
  )
  Future<Map<String, dynamic>> analyticsGroupItemsDelete({
    @Parameter(description: 'Group item ID') required String id,
    @Parameter(description: 'On behalf of content owner')
    String? onBehalfOfContentOwner,
  }) async {
    await _yt.analytics.groupItemsDelete(
      id: id,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
    return _ok;
  }
}
