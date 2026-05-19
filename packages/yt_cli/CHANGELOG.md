# Changelog

## 3.2.0

### Added

- **Full CLI parity with the `yt` package** — added top-level commands
  for the eight remaining services that previously had no CLI surface:
  - `yt playlist-items` — list / insert / update / delete playlist items
  - `yt channel-banners` — upload a channel banner image
  - `yt channel-sections` — list / insert / update / delete channel sections
  - `yt captions` — list / insert / update / delete / download caption tracks
  - `yt i18n-languages` — list YouTube application languages
  - `yt i18n-regions` — list YouTube content regions
  - `yt playlist-images` — list / insert / update / delete custom playlist images
  - `yt third-party-links` — list / insert / update / delete third-party links

  Every subcommand follows the existing `--body` JSON / `--file` upload
  conventions and routes errors through `DioExceptionUsageException` so
  output is consistent with the rest of the CLI.

### Changed

- **Bumped `yt` dependency to `^3.2.0`** to pick up the new
  `Yt.captions` getter that exposes the existing `Captions` service on
  the `Yt` facade.

## 3.1.0

### Changed

- **Bumped `yt` dependency to `^3.1.0`** to pick up the latest upstream
  changes:
  - **`AnalyticsGroup` model completeness** — `snippet.publishedAt` and the
    full `contentDetails` block (`itemCount`, `itemType`) are now exposed,
    bringing parity with the YouTube Analytics API v2 Group resource.
  - **OAuth interactive flow now uses explicit PKCE (RFC 7636 §4.1)** with
    a cryptographically random `code_verifier`, hardening the loopback
    redirect against authorization-code interception.
  - **Loopback callback uses an OS-allocated ephemeral port** when the
    registered redirect URI does not pin one (RFC 8252 §7.3).
  - **Sanitized error messages from OAuth file parsing** — raw exception
    text is no longer surfaced when `client_secrets.json` or
    `access_tokens.json` cannot be parsed.
  - **Response body size cap added to `LoggingInterceptors`** — responses
    whose `Content-Length` exceeds 50 MiB are rejected as
    `DioException(badResponse)` before reaching callers.
  - **`Chat.insert` and `YoutubeApiHelper.buildParts`** now throw
    `ArgumentError` (instead of bare `Exception`) for clearer
    programmer-error semantics.

### Removed

- **BREAKING (transitive)**: The upstream `yt` package removed the
  `Chat.send` convenience helper and the `EmojiFormatter` utility. The
  `yt_cli` does not invoke either symbol, so no CLI command surface is
  affected; this is documented for downstream library consumers only.

## 3.0.2

### Changed

- **Bumped `yt` dependency to `^3.0.2`** to pick up the upstream repository URL
  migration (`github.com/cdavis-code/yt` → `github.com/cdavis-code/yt_workspace`)
  and tightened `json_annotation` / `json_serializable` constraints. No code
  or behavioral changes in `yt_cli`.

## 3.0.1

### Added

- **Configurable credential file paths** — `yt authorize` and all CLI
  commands now honor two new environment variables that point at the exact
  file path for each credential file:

  | Variable | Default |
  |----------|---------|
  | `YT_CLIENT_SECRETS_FILE` | `./client_secret.json` (current working directory) |
  | `YT_ACCESS_TOKENS_FILE`  | `./youtube_server_tokens.json` (current working directory) |

  Each variable is resolved from the runtime environment first, then from a
  `.env` file in the current working directory. Leading `~` is expanded
  against the user's home directory. Either variable may be set
  independently — unset variables keep the existing default location, so
  behavior is fully backward compatible. An explicit `--credentials-file`
  argument always takes precedence over `YT_CLIENT_SECRETS_FILE`.

- **`--tokens-file` flag for `yt authorize`** — A new `-t` / `--tokens-file`
  option lets users specify exactly where the OAuth token file should be
  written, overriding `YT_ACCESS_TOKENS_FILE` for a single invocation. This
  complements the existing `--credentials-file` (`-c`) option and enables
  convenient multi-account workflows.

### Changed

- **BREAKING**: Replaced `googleapis_auth` dependency with the cross-platform
  `oauth2: ^2.0.5` package. Aligns with the same change in `yt: ^3.0.1`.

- **BREAKING**: The on-disk access tokens file format has changed. `yt
  authorize` now writes tokens via `oauth2.Credentials.toJson()`. Existing
  token files written by `yt_cli < 3.0.0` are no longer readable — re-run
  `yt authorize` with `--overwrite-credentials` (`-o`) to force a new flow:

  ```sh
  yt authorize \
    --credentials-file ~/.yt/client_secrets.json \
    --tokens-file ~/.yt/access_tokens.json \
    --overwrite-credentials
  ```

- **`youtube_helper_command`** now builds an `oauth2.Client` from the stored
  credentials and passes it to `Yt.withOAuth(oauthClient: ...)`. The custom
  `_ServerTokenGenerator` interceptor has been removed; refresh and header
  injection are handled inside the library.

- **`youtube_authorize_command`** persists `client.credentials.toJson()`
  directly — the previous conversion to `googleapis_auth.AccessCredentials`
  is no longer required.

## 2.3.0+1

### Changed
- Security hardening: path validation, token file permissions, credential JSON schema validation, OAuth callback validation
- example/ replaced with README.md showing CLI usage examples

## 2.3.0

### Added
- Activities API command (`yt activities list`)

### Changed
- Depends on yt ^2.3.0

## 2.2.6+5

* publication readiness: LICENSE, .pubignore, topics, funding, version sync
* YouTube Analytics, members/memberships, video abuse report reasons support

## [2.2.6] - 2025-05-08

### Added
- Initial release as separate package from yt
- Full CLI support for YouTube Data and Live Streaming APIs
- OAuth2 authorization flow
- Commands for all supported YouTube APIs

### Notes
- Extracted from yt package version 2.2.6
- Depends on yt ^2.2.6
