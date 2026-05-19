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
  /// Reads `YT_API_KEY` for API key authentication (read-only public data)
  /// or `YT_OAUTH_TOKEN` for OAuth token authentication (full access).
  static Future<void> bootstrapFromEnv() async {
    try {
      final apiKey = Platform.environment[envApiKey];
      final oAuthToken = Platform.environment[envOAuthToken];

      if (apiKey != null && apiKey.isNotEmpty) {
        _client = Yt.withApiKey(apiKey: apiKey);
      } else if (oAuthToken != null && oAuthToken.isNotEmpty) {
        // Basic validation: OAuth tokens are typically long strings
        if (oAuthToken.length < 10) {
          _bootstrapError =
              '$envOAuthToken appears to be invalid (too short, expected >= 10 characters).';
          return;
        }
        _client = Yt.withOAuth();
      } else {
        _bootstrapError =
            'Neither $envApiKey nor $envOAuthToken is set in the environment.';
      }
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
    String part = 'snippet',
    @Parameter(description: 'Comma-separated channel IDs') String? id,
    @Parameter(description: 'YouTube username') String? forUsername,
    @Parameter(description: 'Maximum items to return (1-50)')
    int maxResults = 5,
  }) async {
    final response = await _yt.channels.list(
      part: part,
      id: id,
      forUsername: forUsername,
      maxResults: maxResults,
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
}
