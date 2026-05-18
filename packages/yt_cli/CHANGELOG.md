# Changelog

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
