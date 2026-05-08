/// JS-adapted MCP facade for the YouTube Data and Live Streaming API client.
///
/// Port of `packages/yt_mcp/lib/src/yt_mcp_server.dart` with dart:io replaced
/// by Node.js process.env via dart:js_interop.
library;

import 'package:yt/yt.dart';

import 'node_interop.dart';

/// MCP facade exposing YouTube Data and Live Streaming APIs as tools.
class YtMcpServer {
  static const String envApiKey = 'YT_API_KEY';
  static const String envOAuthToken = 'YT_OAUTH_TOKEN';

  static Yt? _client;
  static String? _bootstrapError;

  // ignore: unused_element
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

  // ---------------------------------------------------------------------------
  // Environment bootstrap (JS version — no dotenv file loading)
  // ---------------------------------------------------------------------------

  static bool get _debugEnabled {
    final val = getEnvVar('YT_MCP_DEBUG');
    return val == '1';
  }

  static void _debugLog(String message) {
    if (_debugEnabled) {
      logError('[yt-mcp-js] $message');
    }
  }

  static Future<void> bootstrapFromEnv() async {
    if (_client != null) return;

    try {
      final apiKey = getEnvVar(envApiKey);
      final oAuthToken = getEnvVar(envOAuthToken);

      if (apiKey != null && apiKey.isNotEmpty) {
        _debugLog('Initializing with API key');
        _client = Yt.withApiKey(apiKey);
      } else if (oAuthToken != null && oAuthToken.isNotEmpty) {
        _debugLog('Initializing with OAuth');
        _client = Yt.withOAuth();
      } else {
        _bootstrapError =
            'Neither $envApiKey nor $envOAuthToken is set in the environment.';
        _debugLog(_bootstrapError!);
      }
    } catch (e) {
      _bootstrapError = e.toString();
      _debugLog('Bootstrap failed: $_bootstrapError');
    }
  }
}
