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
- [yt_mcp](https://github.com/cdavis-code/yt/tree/main/packages/yt_mcp) — MCP server for AI integration

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
  yt: ^2.2.6+4
```

## Configuration

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

Create OAuth credentials in the [Google API Console](https://developers.google.com/youtube/v3/live/registering_an_application), then generate a credentials file:

```sh
yt authorize
```

This creates `$HOME/.yt/credentials.json`. Then:

```dart
final yt = Yt.withOAuth();  // Uses default credentials file
```

For manual credential files, the format is:

```yaml
identifier: [client id from the API console]
secret: [client secret from the API console]
```

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
