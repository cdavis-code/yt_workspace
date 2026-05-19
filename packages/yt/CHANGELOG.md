## 3.2.0 (2026-05-18)

### Added

- **`Yt.captions` getter** — the existing `Captions` service is now exposed
  on the `Yt` facade alongside the other resource getters. Previously
  `Captions` was exported by `package:yt/yt.dart` but had to be constructed
  manually; consumers can now call `yt.captions.list(...)`,
  `yt.captions.insert(...)`, etc., consistent with `yt.videos`,
  `yt.playlists`, and friends.

## 3.1.0 (2026-05-18)

### Added

- **YouTube Analytics API completeness** — `AnalyticsGroup` model now exposes
  `snippet.publishedAt` and the full `contentDetails` block
  (`itemCount`, `itemType`), bringing the Dart model to parity with the
  YouTube Analytics API v2 Group resource.

### Security

- **OAuth interactive flow now uses explicit PKCE (RFC 7636 §4.1)** — a
  cryptographically random `code_verifier` is generated via `Random.secure()`
  and passed to `oauth2.AuthorizationCodeGrant`, hardening the loopback
  redirect against authorization-code interception.
- **Loopback callback uses an OS-allocated ephemeral port** when the
  registered redirect URI does not pin one, in line with RFC 8252 §7.3.
  Behavior is unchanged for redirect URIs that explicitly include a port.
- **Sanitized error messages from OAuth file parsing** — `ArgumentError`
  messages raised when `client_secrets.json` or `access_tokens.json` cannot
  be parsed now include only the exception runtime type, never the raw
  exception text, eliminating an information-leak vector.
- **Response body size cap added to `LoggingInterceptors`** — responses
  whose `Content-Length` exceeds `maxResponseBytes` (default 50 MiB) are
  rejected as `DioException(badResponse)` before reaching callers,
  bounding memory exposure from a misbehaving or hostile upstream.
- **Replaced bare `throw Exception(...)` with `ArgumentError`** in
  `Chat.insert` (empty `messageText`) and `YoutubeApiHelper.buildParts`
  (no part specified) for clearer programmer-error semantics.

### Removed

- **BREAKING**: `Chat.send` convenience helper and the `EmojiFormatter`
  utility have been removed. They were not part of any official YouTube API
  surface and added a hardcoded emoji-shortcode map that was never
  documented as stable. Callers should use `Chat.insert` directly with a
  `liveChatMessages.insert` request body.

## 3.0.2 (2026-05-19)

### Changed

- **Repository URL migrated** to `github.com/cdavis-code/yt_workspace` —
  `homepage`, `repository`, and `issue_tracker` fields in `pubspec.yaml`
  now point at the consolidated workspace monorepo. No code changes.

- **Tightened dev/transitive dependency constraints** following
  `dart pub upgrade --tighten`:

  | Dependency | Old | New |
  |------------|-----|-----|
  | `json_annotation` | `^4.11.0` | `^4.12.0` |
  | `json_serializable` (dev) | `^6.13.2` | `^6.14.0` |

## 3.0.1 (2026-05-18)

### Added

- **`GoogleOAuthCredentials` JsonSerializable model** — New typed model for
  parsing OAuth client secrets files downloaded from Google Cloud Console.
  Supports both `web` and `installed` formats with proper field mapping
  (`client_id`, `client_secret`, `auth_uri`, `token_uri`, `redirect_uris`,
  `project_id`). Includes secure `toString()` that masks the client secret.
  Exposed via `package:yt/yt.dart`.

- **Robust access tokens validation** — `OAuthAccessControlIo.init()` now
  validates that the access tokens file contains a valid JSON object before
  attempting to parse. Throws an `ArgumentError` with actionable guidance
  ("Delete the file and re-authorize with yt_cli") when the file is corrupted
  or contains invalid JSON, replacing cryptic type cast errors.

### Changed

- **BREAKING**: Replaced `googleapis_auth` dependency with the cross-platform
  `oauth2: ^2.0.5` package. All public OAuth APIs that previously used
  `googleapis_auth` types now use `package:oauth2` types directly.

  | Before (`googleapis_auth`) | After (`oauth2`) |
  |----------------------------|------------------|
  | `Yt.withOAuth({ClientId? oAuthClientId})` | `Yt.withOAuth({oauth2.Client? oauthClient})` |
  | `GoogleOAuthCredentials.toClientId() → ClientId` | `GoogleOAuthCredentials.toAuthorizationCodeGrant() → oauth2.AuthorizationCodeGrant` |
  | `OAuthCredentials.oAuthClientId` (getter) | `OAuthCredentials.toAuthorizationCodeGrant()` |
  | `OAuthAccessControl(ClientId?, AccessCredentials?)` | `OAuthAccessControl([oauth2.Client?])` |

- **BREAKING**: The on-disk access tokens file format has changed. Tokens are
  now serialized via `oauth2.Credentials.toJson()` instead of
  `googleapis_auth.AccessCredentials.toJson()`. Existing token files written by
  yt `< 3.0.0` (or yt_cli `< 3.0.0`) are no longer readable — users must
  delete the existing tokens file and re-run `yt authorize`.

- **BREAKING**: Renamed default OAuth credential filenames used by
  `OAuthAccessControlIo` and exposed via `Util`:

  | Constant | Old default | New default |
  |----------|-------------|-------------|
  | `Util.credentialsFilename` | `credentials.json` | `client_secrets.json` |
  | `Util.accessCredentialsFilename` | `access_credentials.json` | `access_tokens.json` |
  | `Util.defaultCredentialsFilePath` | `.yt/credentials.json` | `.yt/client_secrets.json` |
  | `Util.accessCredentialsFilePath` | `.yt/access_credentials.json` | `.yt/access_tokens.json` |

  Existing users who relied on the previous default filenames must either
  rename their files on disk or set `YT_CLIENT_SECRETS_FILE` /
  `YT_ACCESS_TOKENS_FILE` to point at the legacy locations.

- **`OAuthAccessControlIo`** now embeds the OAuth interactive flow directly:
  if no tokens file is present, it parses `client_secrets.json`, opens the
  browser, starts a local callback server (`HttpServer.bind`), and persists
  the resulting `oauth2.Credentials`. This removes the need for callers to
  pre-authorize externally.

- **Web stub** (`oauth_access_control_web.dart`) throws `UnsupportedError` —
  browser OAuth must be performed by the application and the resulting
  `oauth2.Client` passed to `Yt.withOAuth(oauthClient: ...)`.

### Fixed

- **Access tokens serialization** — `OAuthAccessControlIo` now properly
  serializes `AccessCredentials` via `.toJson()` instead of direct
  `json.encode()`, ensuring `accessToken` is written as a structured object
  (with `type`, `data`, `expiry`) rather than a plain string. This matches
  the format expected by `googleapis_auth.AccessCredentials.fromJson()`.

## Unreleased

## 2.3.1 (2026-05-17)

## 2.3.0 (2026-05-16)

### Added

- **Activities API** — Channel activity feeds including uploads, likes, favorites, subscriptions, and playlist additions via `yt.activities.list()`
- Workspace structure with multiple packages
- Added yt_cli, yt_js, yt_mcp, yt_mcp_js packages
- Enhanced documentation across all packages

### Changed

- Dependency updates

### Removed

- **BREAKING**: removed chatbot functionality (Chatbot, Dialog, Keyword classes)
- Removed experimental chatbot features from live chat

## 2.2.6+5

* publication readiness: funding link, topics, .pubignore updates

## 2.2.6+4

* README modernization (Quick Start, Features, Configuration table, Documentation, License sections)
* pana score improved to 160/160
* dependency version constraints tightened
* security hardening (credential sanitization in logs, safe toString() redaction)

## 2.2.6+1

* improved pub.dev listing

## 2.2.6

* dep bump
* remove flutter example
* new sdk
* new formatting

## 2.2.5+7

* Issue #11

## 2.2.5+7

* Issue #11

## 2.2.5+6

* Issue #11

## 2.2.5+6

* Issue #11

## 2.2.5+5

* dependency bump

## 2.2.5+4

* more nullable fields
* dependency bump

## 2.2.5+3

* better error handling&#x2F;messages

## 2.2.5+2

* fix pubspec

## 2.2.5+1

* dependency bump

## 2.2.5

* dependency bump

## 2.2.1

* remove dart:io dependency from library to enable web platform support
* api doc updates

## 2.2.0-dev.2

* remove dart:io dependency from library to enable web platform support
* api doc updates

## 2.2.0-dev.1

* new oauth implmentation that supports io versus browser usage

## 2.2.0-dev.1

* new oauth implmentation that supports io versus browser usage

## 2.1.0

* implements `commentThreads` (partial)
* implements `comments` (partial)
* manipulate dio interceptor order
* dependency bump
* update auth scope
* Authentication header in dio `Interceptor`
* updated scope

## 2.0.6+9

* badge update
* README tweaks

## 2.0.6+8

* more relevant flutter example
* close out http connection so cli code exits immediately
* superclasses to remove code repitition
* updated README for main project and flutter example

## 2.0.6+7

* switch to googleapis_auth package for cli
* cli is working again, even thoough if anyone noticed they didn&#x27;t submit an issue
* the error returned by the API server is now displayed when an exception is generated by a cli command
* added an overwrite credentials flag to the cli `authorize` command

## 2.0.6+6

* README changes
* support for `stream update`
* dependency bump

## 2.0.6+5

* auth by key doesn&#x27;t need &quot;async&quot;

## 2.0.6+4

* fix publishing tools

## 2.0.6+3

* adjustments

## 2.0.6+1

- dependency bump

## 2.0.6

- build tools

## 2.0.5

- fixing pub points

## 2.0.4

- remove deprecated dependency

## 2.0.3

- fix apiKey

## 2.0.2

- better chatbot docs

## 2.0.1

- added chatbot example, better docs

## 2.0.0

- Command line app provided, some functional updates

## 1.2.2

- Export CachePolicy

## 1.2.1

- Integration of dio cache interceptor. Default dont use DioCacheIntercepter.
- Fetch video details

## 1.1.4

- bugfix for flutter build web

## 1.1.3

- autostop is not required

## 1.1.2

- custom exception for authorization failure

## 1.1.1

- custom exception for authorization failure

## 1.1.0

- video upload actually works, refactored thumbnail upload and added support for the VideoCategories API

## 1.0.7

- correction for video upload, and dependency updates

## 1.0.6

- added the playlists API

## 1.0.5

- simplified OAuth2 now with persisted refresh token, and more API docs

## 1.0.4

- tweaked OAauth2 authentication and improved README

## 1.0.3

- still improving the api doc

## 1.0.2

- even more updated api doc, and more channels API

## 1.0.1

- updated api doc, and starting the channels API

## 1.0.0

- better support for Flutter apps, added a Flutter example

## 0.0.2

- improved README

## 0.0.1

- initial release
