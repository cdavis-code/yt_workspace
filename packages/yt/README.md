# Youtube REST API Client

Native [Dart](https://dart.dev/) interface to multiple Google REST APIs, including:

- [YouTube Data API](https://developers.google.com/youtube/v3/docs)
- [YouTube Live Streaming API](https://developers.google.com/youtube/v3/live/docs)

**Related Packages:**
- [yt_cli](https://github.com/faithoflifedev/yt/tree/main/packages/yt_cli) - CLI tool for YouTube APIs
- [yt_js](https://github.com/faithoflifedev/yt/tree/main/packages/yt_js) - JavaScript/TypeScript bindings
- [yt_mcp](https://github.com/faithoflifedev/yt/tree/main/packages/yt_mcp) - MCP server for AI integration
- [yt_mcp_js](https://github.com/faithoflifedev/yt/tree/main/packages/yt_mcp_js) - MCP server for Node.js

[![pub package](https://img.shields.io/pub/v/yt.svg)](https://pub.dartlang.org/packages/yt) 
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Table of Contents

- [Table of Contents](#table-of-contents)
- [How does this package differ from the googleapis package?](#how-does-this-package-differ-from-the-googleapis-package)
- [Release News](#release-news)
  - [New for v2.2.x (pre-release)](#new-for-v22x-pre-release)
  - [New for v2.0.x](#new-for-v20x)
- [Getting Started](#getting-started)
- [Obtaining Authorization Credentials](#obtaining-authorization-credentials)
  - [yaml](#yaml)
  - [json](#json)
- [Using of the Data API](#using-of-the-data-api)
- [Upload a Video](#upload-a-video)
- [Using the Live Streaming API](#using-the-live-streaming-api)
- [Download a LiveChat](#download-a-livechat)
- [Usage within Flutter](#usage-within-flutter)
- [Available Examples](#available-examples)
- [Youtube REST API cli (Youtube at the command prompt)](#youtube-rest-api-cli-youtube-at-the-command-prompt)
  - [dart pub install](#dart-pub-install)
  - [homebrew install](#homebrew-install)
- [API Commands Supported](#api-commands-supported)
  - [Data API](#data-api)
  - [Live Streaming API](#live-streaming-api)
  - [Custom Features (experimental)](#custom-features-experimental)
- [What's Next?](#whats-next)
- [Breaking changes](#breaking-changes)
  - [v2.0.x 2.1.x](#v20x-21x)
  - [v2.0.x from v1.2.x](#v20x-from-v12x)
- [Contributing](#contributing)

[![Build Status](https://github.com/faithoflifedev/yt/workflows/Dart/badge.svg)](https://github.com/faithoflifedev/yt/actions) [![github last commit](https://shields.io/github/last-commit/faithoflifedev/yt)](https://shields.io/github/last-commit/faithoflifedev/yt) [![github build](https://img.shields.io/github/actions/workflow/status/faithoflifedev/yt/dart.yml?branch=main)](https://shields.io/github/workflow/status/faithoflifedev/yt/Dart) [![github issues](https://shields.io/github/issues/faithoflifedev/yt)](https://shields.io/github/issues/faithoflifedev/yt)

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/guidelines/download-assets-1.svg)](https://www.buymeacoffee.com/faithoflif2)

## How does this package differ from the [googleapis](https://pub.dev/packages/googleapis) package?

- It's not generated, it's manually coded and limited to a targeted set of just YouTube APIs
- Since it's not generated the package includes additional useful features like a cli (Command Line Interface)
- A tighter focus to the package means focused documentation and focused examples

## Release News

### New for v2.2.x

For the 2.2.x release the oauth code has been refactored to remove the `dart:io` dependencies that prevented the package from being used as part of a Flutter app running in a browser.  With this release the package can now be used by all Dart/Flutter supported platforms.

This release also introduces a workspace structure with multiple packages:
- **yt**: Core Dart library for YouTube APIs
- **yt_cli**: Command-line interface tool
- **yt_js**: JavaScript/TypeScript bindings for web and Node.js
- **yt_mcp**: MCP server for AI assistant integration
- **yt_mcp_js**: MCP server compiled to JavaScript for Node.js  

Please **NOTE** that this package uses the [google_sign_in](https://pub.dev/packages/google_sign_in) package for authentication in Flutter, which auto-magically defers to [google_sign_in_web](https://pub.dev/packages/google_sign_in_web) for browser apps.  You must follow the [usage](https://pub.dev/packages/google_sign_in_web#usage) instructions to the letter if you want to the included `flutter_youtube` app to function without errors in a browser.

The first line in the usage instructions states,  "First, go through the instructions [here](https://developers.google.com/identity/gsi/web/guides/get-google-api-clientid) to create your Google Sign-In OAuth client ID.".  If you don't follow these steps properly, your web application will not work.  **DO NOT** submit GitHub issues around this, they will be ignored.

### New for v2.0.x

As of the 2.0.x release of this package there is a cli utility included that can be used to return data for any API call currently supported by the package. If you want to get started quickly with the cli utility run these commands in a terminal session:

```sh
pub global activate yt

yt --help
```

Please see the cli documentation [README.md](https://github.com/faithoflifedev/yt/tree/main/bin) for more detailed usage information.

**NOTE:** Cloud Vision API support has been permanently removed from this package and will be available as it's own [package](https://pub.dev/packages/google_vision).  Additionally, cache support has been temporarily removed.

## Getting Started

To use this package, add the dependency to your pubspec.yaml file:

```yaml
dependencies:
  ...
  yt: ^2.2.6+1
```

Or use one of the related packages:

```yaml
dependencies:
  ...
  yt_cli: ^2.2.6  # CLI tool
  # OR
  yt_js: ^2.2.6   # JavaScript bindings
  # OR  
  yt_mcp: ^2.2.6  # MCP server
```

## Obtaining Authorization Credentials

YouTube API access requires an access token or API key depending on the API and the type of information being accessed. As a general rule of thumb, read-only public information and be accessed through an API key, otherwise an access token is required.

The `yt` library supports multiple mechanisms for authentication. All of the authentication schemes require some configuration in the [Google API console](https://developers.google.com/youtube/v3/live/registering_an_application). The document [Obtaining authorization credentials](https://developers.google.com/youtube/v3/live/registering_an_application) covers authentication with [OAuth 2.0](https://developers.google.com/identity/protocols/OAuth2) which works for both the Data API and the Live Streaming API the same document also covers authenticating with API keys which works only with the Data API.

More in depth documentation on how OAuth2 works within the `yt` library is available in the [OAuth 2.0 for Mobile & Desktop Apps](https://developers.google.com/identity/protocols/oauth2/native-app) document. Overall, for OAuth2 the library takes a provided single use auth code and generates a long lived OAuth2 refresh token that is persisted as a hidden file.

Both of the above authentication methods will work for Flutter apps as well, however you may want to instead allow your app's users to use their own YouTube credentials. Instructions for authenticating this way are included at the end of this document in the _Usage within Flutter_ section.

Some of the included examples use OAuth 2.0 for authentication. The examples have the OAuth2 credentials made available to the code though a **.json** or **.yaml** file that contains these lines:

### yaml

```yaml
identifier: [client id from the API console]
secret: [client secret from the API console]
```

### json

```json
{
  "identifier": "[client id from the API console]",
  "secret": "[client secret from the API console]"
}
```

The **.json** version of this file can be generated using the cli utility:

```sh
#make sure you've created an app instance in the Google API console
#make sure you've already activated the cli utility "pub global activate yt"

yt authorize

#follow the prompts to provide clientID, clientSecret, then use a browser to 
#authenticate and generate the one-time code
```

After following the steps provided by the above **_cli_** command, your credential file will be auto created as `$HOME/.yt/credentials.json`

## Using of the Data API

YouTube provides multiple methods for API authentication. The Data API can use both API key and OAuth for authentication the example below shows how both of these

```dart
import 'package:yt/yt.dart';

// if you used "yt authorize" to generate a credentials file
final yt = Yt.withOAuth();

// authenticate using OAuth - manually created file
// final yt = Yt.withOAuth(OAuthCredentials.fromYaml('example/youtube.yaml'));

// some APIs can use an API Key for authentication
// final yt = Yt.withKey('[youtube api key]');

// List of videos from playlist
var playlistResponse = await yt.playlists.list(
      channelId: '[youtube channel id]', maxResults: 25);

playlistResponse.items
    .forEach((playlist) => print('${playlist.snippet?.title}'));
```

## Upload a Video

```dart
final yt = await Yt.withOAuth();

final body = <String, dynamic>{
  'snippet': {
    'title': 'TEST title',
    'description': 'Test Description',
    'tags': ['tag1', 'tag2'],
    'categoryId': "22"
  },
  'status': {
    'privacyStatus': 'private',
    "embeddable": true,
    "license": "youtube"
  }
};
 
final videoItem = await yt.videos.insert(
    body: body,
    videoFile:
        File('[path to a video to upload]'),
    notifySubscribers: false);

print(videoItem);
```

## Using the Live Streaming API

```dart
import 'package:yt/yt.dart';

final yt = await Yt.withOAuth();

// the live streaming broadcast API client
final br = yt.broadcast;

// the thumbnail data API client
final th = yt.thumbnails;

// create a private broadcast for 2 hours from now
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

// bind the broadcast to an existing stream
await br.bind(
    broadcastId: broadcastItem.id,
    streamId: '[one of your valid stream ids]');

// upload the thumbnail
await th.set(
    videoId: broadcastItem.id,
    thumbnail: File('[path to an image to upload]'));
```

## Download a LiveChat

```dart
import 'package:yt/yt.dart';

final yt = await Yt.withOAuth();

var broadcastResponse = await yt.broadcast.list(broadcastStatus: 'active');

if (broadcastResponse.items.isNotEmpty) {
  // will download and output to stdout
  await yt.chat.downloadHistory(liveBroadcastItem: broadcastResponse.items.first);
}
```



## Usage within Flutter

This library does not include any Flutter dependencies but it can be easily integrated with Flutter code using any of the authentication mechanisms described above. In addition, for some applications there may be a desire to use the user's own YouTube credentials for authentication. The library uses the concept of a [TokenGenerator](https://pub.dev/documentation/yt/latest/yt/util_tokenGenerator/TokenGenerator-class.html) to allow for this. [TokenGenerator](https://pub.dev/documentation/yt/latest/yt/util_tokenGenerator/TokenGenerator-class.html) is an abstract class that is extended within the library through the [JwtGenerator](https://pub.dev/documentation/yt/latest/yt/util_tokenGenerator/JwtGenerator-class.html) and [OAuthGenerator](https://pub.dev/documentation/yt/latest/yt/util_tokenGenerator//OAuthGenerator-class.html) classes, and generates the authentication token used in API calls to YouTube.

For a Flutter app the [TokenGenerator](https://pub.dev/documentation/yt/latest/yt/util_tokenGenerator/TokenGenerator-class.html) can be extended to allow for auth tokens to be generated through the [google_sign_in](https://pub.dev/packages/google_sign_in) package provided by the [flutter.dev](https://pub.dev/publishers/flutter.dev/packages) team. Keep in mind that you must fulfill all of the requirements for the **google_sign_in** package before attempting to use the code below. The code to use google_sign_in for authentication:

```dart
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yt/yt.dart';

class YtLoginGenerator implements TokenGenerator {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/youtube',
    ],
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

With the generator in place, it becomes quite easy to include _google sign-in_ for YouTube into your Flutter app. In one of your controllers you would include code like:

```dart
  // class definitions for a Flutter app
  ...
  final items = <Playlist>[];

  late final Yt yt;

  Playlists? playlists;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() async {
    yt = await Yt.withGenerator(YtLoginGenerator());
  }

  void _getPlaylists() async {
    items.clear();

    setState(() {
      items.addAll(await yt.playlists.list(mine: true));
    });
  }

    @override
  Widget build(BuildContext context) {
    // ListView.builder
    ...
    floatingActionButton: FloatingActionButton(
        onPressed: _getPlaylists,
        child: Icon(Icons.add),
      )
  }
```

## Available Examples

- [example.dart](https://github.com/faithoflifedev/yt/blob/main/example/example.dart) - (command line) display various YouTube data
- [flutter_youtube](https://github.com/faithoflifedev/yt/tree/main/example/flutter_youtube) - a simple flutter app that can function on web and mobile platforms that allows the user to type a keyword to get matching youtube videos with image and title
  
## Youtube REST API cli (Youtube at the command prompt)

A command line interface for broadcasting to Youtube through OBS

### dart pub install

To install using `dart pub`:

```sh
pub global activate yt
```

If the above shows an error like:

```text
-bash: webdev: command not found
```

Then this section of the Dart SDK doc might fix the problem - [running-a-script-from-your-path](https://dart.dev/tools/pub/cmd/pub-global#running-a-script-from-your-path)

### homebrew install

Install using `brew`:

```sh
brew tap faithoflifedev/yt

brew install yt
```

Usage:

```sh
prompt>yt --help
A command line interface for connecting to Youtube

Usage: yt <command> [arguments]

Global options:
-h, --help    Print this usage information.
    --log-level    [all, debug, info, warning, error, off (default)]
    
Available commands:
  authorize          Generate a refresh token used to authenticate the command line API requests
  broadcast          A liveBroadcast resource represents an event that will be streamed, via live video, on YouTube.
  channels           A channel resource contains information about a YouTube channel.
  chat               A liveChatMessage resource represents a chat message in a YouTube live chat. The resource can contain details about several types of messages, including a newly posted text message or fan funding event.
  playlists          A playlist resource represents a YouTube playlist. A playlist is a collection of videos that can be viewed sequentially and shared with other users. By default, playlists are publicly visible to other users, but playlists can be public or private.
  search             A search result contains information about a YouTube video, channel, or playlist that matches the search parameters specified in an API request. While a search result points to a uniquely identifiable resource, like a video, it does not have its own persistent data.
  stream             A liveStream resource contains information about the video stream that you are transmitting to YouTube. The stream provides the content that will be broadcast to YouTube users. Once created, a liveStream resource can be bound to one or more liveBroadcast resources.
  subscriptions      A subscription resource contains information about a YouTube user subscription. A subscription notifies a user when new videos are added to a channel or when another user takes one of several actions on YouTube, such as uploading a video, rating a video, or commenting on a video.
  thumbnails         A thumbnail resource identifies different thumbnail image sizes associated with a resource.
  video-categories   A videoCategory resource identifies a category that has been or could be associated with uploaded videos.
  videos             A video resource represents a YouTube video.
```

## API Commands Supported

### Data API

- [Channels](https://developers.google.com/youtube/v3/docs/channels)
- [Comments](https://developers.google.com/youtube/v3/docs/comments) (partial)
- [PlaylistItems](https://developers.google.com/youtube/v3/docs/playlistItems)
- [Playlists](https://developers.google.com/youtube/v3/docs/playlists)
- [Search](https://developers.google.com/youtube/v3/docs/search)
- [Thumbnails](https://developers.google.com/youtube/v3/docs/thumbnails)
- [VideoCategories](https://developers.google.com/youtube/v3/docs/videoCategories)
- [Videos](https://developers.google.com/youtube/v3/docs/videos)

### Live Streaming API

- [LiveBroadcasts](https://developers.google.com/youtube/v3/live/docs/liveBroadcasts)
- [LiveChatMessages](https://developers.google.com/youtube/v3/live/docs/liveChatMessages)
- [LiveStreams](https://developers.google.com/youtube/v3/live/docs/liveStreams)

### Custom Features (experimental)

- download chat history from a LiveChat

## What's Next?

- ~~A working sample Flutter app~~
- Expanded API Commands

## Breaking changes

### v2.0.x 2.1.x

`Yt.withOAuth` and `Yt.withKey` now return a `Yt` object not `Future<Yt>`.

```dart
// now do this
final yt = Yt.withOAuth(
    oAuthClientId:
        OAuthCredentials.fromYaml('credentials.yaml').oAuthClientId);

// since this won't work
final yt = await Yt.withOAuth(
    oAuthClientId:
        OAuthCredentials.fromYaml('credentials.yaml').oAuthClientId);
```

### v2.0.x from v1.2.x

The `Yt` object now returns a `Future` and the reference to a specific API module is no longer a `Future`.  So now you can use the following code:

```dart
final yt = await Yt.withOAuth(); //uses default credentials file, created with "yt authorize" cli utility

final playlists = yt.playlists;

var playlistResponse = await yt.playlists.list(
      channelId: '[youtube channel id]', maxResults: 25);
```

in place of:

```dart
final yt = Yt.withOAuth(OAuthCredentials.fromYaml('example/youtube.yaml'));

final playlists = await yt.playlists;

var playlistResponse = await yt.playlists.list(
      channelId: '[youtube channel id]', maxResults: 25);

```

## Contributing

Any help from the open-source community is always welcome and needed:
- Found an issue?
    - Please fill a bug report with details.
- Need a feature?
    - Open a feature request with use cases.
- Are you using and liking the project?
    - Promote the project: create an article or post about it
    - Make a donation
- Do you have a project that uses this package
    - let's cross promote, let me know and I'll add a link to your project
- Are you a developer?
    - Fix a bug and send a pull request.
    - Implement a new feature.
    - Improve the Unit Tests.
- Have you already helped in any way?
    - **Many thanks from me, the contributors and everybody that uses this project!**

*If you donate 1 hour of your time, you can contribute a lot, because others will do the same, just be part and start with your 1 hour.*