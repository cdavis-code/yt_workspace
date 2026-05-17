/// Example usage of the `yt` package.
///
/// ## Prerequisites
///
/// 1. **Download `client_secrets.json`** from
///    [Google Cloud Console](https://console.cloud.google.com/apis/credentials)
///    (OAuth 2.0 Client ID → Download JSON).
///
/// 2. **Save it** to `~/.yt/client_secrets.json`
///    (or set the `YT_CLIENT_SECRETS_FILE` environment variable).
///
/// 3. **Run `yt authorize`** to generate access tokens
///    (saved to `~/.yt/access_tokens.json` by default,
///    or set `YT_ACCESS_TOKENS_FILE`).
///
/// 4. Optionally create a `.env` file in the working directory —
///    see `.env.example` for the supported variables.
///
/// For **read-only** access to public data you only need an API key
/// (no OAuth required). See [apiKeyExample] below.
library;

import 'package:yt/yt.dart';

// ---------------------------------------------------------------------------
// API Key example — read-only access to public data
// ---------------------------------------------------------------------------

/// Demonstrates read-only access using an API key.
///
/// Set `YT_API_KEY` in your environment or `.env` file, then run:
///
/// ```sh
/// dart run example/example.dart
/// ```
Future<void> apiKeyExample() async {
  final Yt yt;
  try {
    yt = Yt.withApiKey();
  } on ArgumentError {
    print('Skipping API-key example — YT_API_KEY is not set.\n');
    return;
  }

  final searchResponse = await yt.search.list(
    q: 'dart programming',
    part: 'snippet',
    type: 'video',
  );

  print('Search (API key):');
  for (final result in searchResponse.items) {
    print('  title: ${result.snippet?.title}');
  }
  print('');
}

// ---------------------------------------------------------------------------
// OAuth example — full access (read + write)
// ---------------------------------------------------------------------------

/// Demonstrates authenticated access using OAuth 2.0.
///
/// `Yt.withOAuth()` automatically resolves credential file paths via:
///   1. Runtime environment variables
///   2. `.env` file in the current working directory
///   3. Defaults: `~/.yt/client_secrets.json` & `~/.yt/access_tokens.json`
Future<void> oAuthExample() async {
  final Yt yt;
  try {
    yt = Yt.withOAuth();
  } on ArgumentError catch (e) {
    print('Skipping OAuth example — $e\n');
    return;
  }

  // --- Search ---
  final searchListResponse = await yt.search.list(
    q: 'reddit',
    part: 'snippet',
    type: 'video',
  );

  print('Search (OAuth):');
  for (final searchResult in searchListResponse.items) {
    print('''  title: ${searchResult.snippet?.title}
  thumbnail: ${searchResult.snippet?.thumbnails.thumbnailsDefault.url}
  channel: ${searchResult.snippet?.channelTitle}''');
  }

  // --- Playlists ---
  print('\nPlaylist: [a playlist id]');
  final playlistResponse = await yt.playlists.list(id: '[a playlist id]');

  for (final playlist in playlistResponse.items) {
    print('''  title: ${playlist.snippet?.title}
  thumbnail: ${playlist.snippet?.thumbnails.thumbnailsDefault.url}''');
  }

  // --- Channels ---
  final channelsResponse = await yt.channels.list(
    id: '[a channel id]',
    part: 'snippet,contentDetails',
  );

  print('\nChannel: [a channel id]');
  for (final channelItem in channelsResponse.items) {
    print('''  title: ${channelItem.snippet?.title}
  thumbnail: ${channelItem.snippet?.thumbnails?.thumbnailsDefault.url}
  uploads: ${channelItem.contentDetails?.relatedPlaylists.uploads}''');
  }

  // --- Live Broadcasts (requires OAuth) ---
  final liveBroadcastResponse = await yt.broadcast.list(
    mine: true,
    part: 'snippet,contentDetails,status',
  );

  print('\nBroadcasts:');
  for (final broadcastItem in liveBroadcastResponse.items) {
    print('''  title: ${broadcastItem.snippet?.title}
  thumbnail: ${broadcastItem.snippet?.thumbnails?.thumbnailsDefault.url}
  status: ${broadcastItem.status?.lifeCycleStatus}''');
  }
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

void main() async {
  await apiKeyExample();
  await oAuthExample();
}
