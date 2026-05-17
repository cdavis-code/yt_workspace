# Youtube REST API Client

<p align="center">
  <img src="https://raw.githubusercontent.com/cdavis-code/yt_workspace/refs/heads/main/packages/yt/images/banner.svg" alt="yt - Native Dart Client for YouTube APIs" width="100%">
</p>

Native [Dart](https://dart.dev/) interface to multiple Google REST APIs, including:

- [YouTube Data API](https://developers.google.com/youtube/v3/docs)
- [YouTube Live Streaming API](https://developers.google.com/youtube/v3/live/docs)
- [YouTube Analytics API](https://developers.google.com/youtube/analytics/reference)

**Related Packages:**
- [yt_cli](https://github.com/cdavis-code/yt/tree/main/packages/yt_cli) — CLI tool for YouTube APIs

[![pub package](https://img.shields.io/pub/v/yt.svg)](https://pub.dartlang.org/packages/yt)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![github build](https://img.shields.io/github/actions/workflow/status/cdavis-code/yt/dart.yml?branch=main)](https://shields.io/github/workflow/status/cdavis-code/yt/Dart)
[![github issues](https://shields.io/github/issues/cdavis-code/yt)](https://shields.io/github/issues/cdavis-code/yt)

## Quick Start

```dart
import 'package:yt/yt.dart';

void main() async {
  // Use an API key for read-only access
  final yt = Yt.withKey('[your youtube api key]');

  // Search for videos
  final results = await yt.search.list(q: 'flutter tutorial', maxResults: 5);
  for (final item in results.items) {
    print('${item.snippet?.title}');
  }
}
```

For write operations (uploading videos, managing broadcasts), use OAuth — see [Configuration](#configuration) below.

## Features

- **YouTube Data API** — Channels, Playlists, Videos, Search, Comments, Subscriptions, Thumbnails, Captions, and more
- **YouTube Live Streaming API** — LiveBroadcasts, LiveStreams, and LiveChat
- **YouTube Analytics API** — Reports, Groups, and Group Items for channel analytics
- **Members & Memberships** — Channel members, membership levels, and video abuse report reasons
- **Activities** — Channel activity feeds including uploads, likes, favorites, subscriptions, and playlist additions
- **Multiple auth methods** — API key, OAuth 2.0 with automatic token refresh, or custom token generators
- **Cross-platform** — works on all Dart/Flutter platforms including web, mobile, and desktop
- **Dart-first** — manually crafted (not auto-generated) for a focused, well-documented API surface

## Getting Started

Add to your `pubspec.yaml`:

```yaml
dependencies:
  yt: ^3.0.1
```

## Configuration

### ⚠️ Breaking Changes in v3.0.1

**OAuth credential filenames have changed.** If you upgrade from v2.x to v3.x, you must update your credential files:

| File | Old Name | New Name |
|------|----------|----------|
| Client secrets | `credentials.json` | `client_secrets.json` |
| Access tokens | `access_credentials.json` | `access_tokens.json` |

**Migration options:**
1. **Rename your files** on disk to match the new names in `$HOME/.yt/`
2. **Set environment variables** to point at the old locations:
   ```sh
   export YT_CLIENT_SECRETS_FILE="$HOME/.yt/credentials.json"
   export YT_ACCESS_TOKENS_FILE="$HOME/.yt/access_credentials.json"
   ```

For full details, see the [CHANGELOG](https://github.com/cdavis-code/yt/blob/main/packages/yt/CHANGELOG.md).

YouTube API access requires either an API key (read-only) or OAuth 2.0 credentials.

| Action Type | Authentication Requirement | Why |
|---|---|---|
| Reading Public Data | API Key or OAuth 2.0 | Accesses data anyone can see (e.g., public video titles, search results). |
| Reading Private Data | OAuth 2.0 Required | Accesses data specific to a user (e.g., a user's private videos or watch history). |
| Writing/Modifying Data | OAuth 2.0 Required | Performs actions on behalf of a user (e.g., uploading, deleting, or commenting). |

### API Key

Create an API key in the [Google API Console](https://developers.google.com/youtube/v3/live/registering_an_application), then:

```dart
final yt = Yt.withKey('[your api key]');
```

### OAuth 2.0

OAuth 2.0 uses two files:

| File | Purpose | Source |
|------|---------|--------|
| `client_secrets.json` | OAuth client secret (input) | Downloaded from Google Cloud Console |
| `access_tokens.json` | Persisted access & refresh tokens (output) | Created by the authorization flow |

**1. Create OAuth credentials in the [Google Cloud Console](https://developers.google.com/youtube/v3/live/registering_an_application)**, download the client-secret JSON, and save it to `$HOME/.yt/client_secrets.json`.

**2. Run the authorization flow** using the [yt_cli](https://pub.dev/packages/yt_cli) tool. Pass `--credentials-file` to point at the client-secret JSON you saved in step 1, and `--tokens-file` to write the resulting tokens to the location the `yt` library expects:

**Via Homebrew (macOS/Linux — fewer dependencies):**

```sh
brew tap cdavis-code/yt
brew install yt
yt authorize \
  --credentials-file $HOME/.yt/client_secrets.json \
  --tokens-file $HOME/.yt/access_tokens.json
```

**Via Dart pub (requires Dart SDK):**

```sh
dart pub global activate yt_cli
yt authorize \
  --credentials-file $HOME/.yt/client_secrets.json \
  --tokens-file $HOME/.yt/access_tokens.json
```

This opens a browser, prompts for consent, and writes the tokens to `$HOME/.yt/access_tokens.json`.

> **Why both flags?** `yt_cli`'s default filenames (`client_secret.json` in the current directory for input, `youtube_server_tokens.json` for output) differ from the `yt` library's defaults (`client_secrets.json` and `access_tokens.json` in `$HOME/.yt/`). Passing both flags writes everything directly to the locations `Yt.withOAuth()` reads — no manual rename or copy needed. Alternatively, set the `YT_CLIENT_SECRETS_FILE` and `YT_ACCESS_TOKENS_FILE` environment variables (see below).

**3. Use the credentials in your code:**

```dart
final yt = await Yt.withOAuth();  // Uses default file locations
```

#### Customizing file locations

Both files can be redirected to arbitrary paths via environment variables (resolved from the runtime environment first, then a `.env` file in the current working directory):

| Variable | Default |
|----------|---------|
| `YT_CLIENT_SECRETS_FILE` | `$HOME/.yt/client_secrets.json` |
| `YT_ACCESS_TOKENS_FILE`  | `$HOME/.yt/access_tokens.json` |

Either variable may be set independently — unset variables keep the default location. Leading `~` in the resolved path is expanded against the user's home directory.

## Usage

### Data API

```dart
import 'package:yt/yt.dart';

final yt = Yt.withOAuth();

var playlistResponse = await yt.playlists.list(
    channelId: '[youtube channel id]', maxResults: 25);

playlistResponse.items
    .forEach((playlist) => print('${playlist.snippet?.title}'));
```

### Upload a Video

```dart
final yt = await Yt.withOAuth();

final body = <String, dynamic>{
  'snippet': {
    'title': 'TEST title',
    'description': 'Test Description',
    'tags': ['tag1', 'tag2'],
    'categoryId': '22'
  },
  'status': {
    'privacyStatus': 'private',
    'embeddable': true,
    'license': 'youtube'
  }
};

final videoItem = await yt.videos.insert(
    body: body,
    videoFile: File('[path to a video to upload]'),
    notifySubscribers: false);

print(videoItem);
```

### Live Streaming API

```dart
import 'package:yt/yt.dart';

final yt = await Yt.withOAuth();
final br = yt.broadcast;
final th = yt.thumbnails;

// Create a broadcast
final broadcastItem = await br.insert(body: {
  'snippet': {
    'title': 'TEST Broadcast',
    'description': 'Test',
    'scheduledStartTime':
        DateTime.now().add(Duration(hours: 2)).toUtc().toIso8601String()
  },
  'status': {'privacyStatus': 'private'},
  'contentDetails': {
    'monitorStream': {
      'enableMonitorStream': false,
      'broadcastStreamDelayMs': 10
    },
    'enableDvr': true,
    'enableContentEncryption': true,
    'enableEmbed': true,
    'recordFromStart': true,
    'startWithSlate': false
  }
}, part: 'snippet,status,contentDetails');

// Bind to a stream and upload thumbnail
await br.bind(
    broadcastId: broadcastItem.id,
    streamId: '[one of your valid stream ids]');

await th.set(
    videoId: broadcastItem.id,
    thumbnail: File('[path to an image to upload]'));
```

### Download a LiveChat

```dart
final yt = await Yt.withOAuth();

var broadcastResponse = await yt.broadcast.list(broadcastStatus: 'active');

if (broadcastResponse.items.isNotEmpty) {
  await yt.chat.downloadHistory(
      liveBroadcastItem: broadcastResponse.items.first);
}
```

### Analytics

```dart
final yt = await Yt.withOAuth();

// Query channel analytics
final report = await yt.analytics.query(
  ids: 'channel==MINE',
  startDate: '2026-01-01',
  endDate: '2026-01-31',
  metrics: 'views,estimatedMinutesWatched',
  dimensions: 'day',
);

for (final header in report.columnHeaders) {
  print('${header.name} (${header.dataType})');
}

// List analytics groups
final groups = await yt.analytics.groupsList(mine: true);
for (final group in groups.items) {
  print('${group.id}: ${group.snippet.title}');
}
```

### Activities

```dart
final yt = Yt.withKey('[your api key]');

// List recent channel activities
final activities = await yt.activities.list(
  channelId: 'UC_x5XG1OV2P6uZZ5FSM9Ttw',
  maxResults: 10,
);

for (final activity in activities.items) {
  print('${activity.snippet?.type}: ${activity.snippet?.title}');
}
```

```dart
final yt = await Yt.withOAuth();

// List my recent activities
final myActivities = await yt.activities.list(
  mine: true,
  maxResults: 20,
);

for (final activity in myActivities.items) {
  print('${activity.snippet?.publishedAt}: ${activity.snippet?.title}');
}
```

## Flutter Integration

This package has no Flutter dependencies and works on all platforms. To authenticate with a user's own YouTube account, implement a [TokenGenerator](https://pub.dev/documentation/yt/latest/yt/util_tokenGenerator/TokenGenerator-class.html):

```dart
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yt/yt.dart';

class YtLoginGenerator implements TokenGenerator {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['https://www.googleapis.com/auth/youtube'],
  );

  @override
  Future<Token> generate() async {
    var _currentUser = await _googleSignIn.signInSilently();
    if (_currentUser == null) _currentUser = await _googleSignIn.signIn();
    final token = (await _currentUser!.authentication).accessToken;
    if (token == null) throw Exception();
    return Token(
        accessToken: token, expiresIn: 3599, scope: null, tokenType: '');
  }
}
```

Then in your Flutter app:

```dart
late final Yt yt;

void _init() async {
  yt = await Yt.withGenerator(YtLoginGenerator());
}

void _getPlaylists() async {
  setState(() {
    items.addAll(await yt.playlists.list(mine: true));
  });
}
```

See [Usage within Flutter](https://pub.dev/packages/google_sign_in#usage) for google_sign_in setup requirements.

## Documentation

- [API Reference](https://pub.dev/documentation/yt/latest/) — Full Dart API docs
- [CHANGELOG](https://github.com/cdavis-code/yt/blob/main/packages/yt/CHANGELOG.md) — Release history and breaking changes
- [YouTube Data API](https://developers.google.com/youtube/v3/docs) — Google's Data API docs
- [YouTube Live Streaming API](https://developers.google.com/youtube/v3/live/docs) — Google's Live Streaming API docs
- [YouTube Analytics API](https://developers.google.com/youtube/analytics/reference) — Google's Analytics API docs
- [Example](https://github.com/cdavis-code/yt/blob/main/packages/yt/example/example.dart) — Command-line example

## Contributing

Any help from the open-source community is always welcome and needed:
- Found an issue? Please fill a bug report with details.
- Need a feature? Open a feature request with use cases.
- Are you a developer? Fix a bug, implement a new feature, or improve tests — send a pull request.
- Are you using and liking the project? Promote it, or let me know and I'll cross-link your project.

*If you donate 1 hour of your time, you can contribute a lot, because others will do the same — just be part and start with your 1 hour.*

## License

MIT — see the [LICENSE](https://github.com/cdavis-code/yt/blob/main/packages/yt/LICENSE) file for details.
