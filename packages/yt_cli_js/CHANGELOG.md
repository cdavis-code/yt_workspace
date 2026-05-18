# Changelog

## [1.1.0] - 2026-05-20

### Added — full command parity with Dart `yt_cli`

- **`channels update`** — update a channel resource (OAuth).
- **`videos insert`** — upload a new video file with metadata (OAuth).
- **`videos update`** — modify a video resource (OAuth).
- **`videos delete`** — delete a video by ID (OAuth).
- **`videos rate`** — like / dislike / clear rating on a video (OAuth).
- **`playlists insert`** — create a new playlist (OAuth).
- **`playlists update`** — modify an existing playlist (OAuth).
- **`playlists delete`** — delete a playlist by ID (OAuth).
- **`comments list-by-parent-id`** — list replies under a parent comment.
- **`comments add`** — helper to reply to a parent comment (textOriginal).
- **`comments change`** — helper to modify a comment's text (textOriginal).
- **`comment-threads list-by-video-id`** — list threads for a specific video.
- **`comment-threads list-by-channel-id`** — list all threads on a channel.
- **`comment-threads list-by-ids`** — list threads by comma-separated IDs.
- **`comment-threads add`** — helper to post a top-level comment on a video.

### Changed

- **Renamed** `runtime-version` → **`version`** to match the Dart CLI.
- **Bumped** Commander program version + runtime namespace version to `1.1.0`.

### Notes

- All write/mutating commands accept the same OAuth options as the rest of the
  CLI: `--access-tokens-file`, `--client-secrets-file`, or the corresponding
  `YT_ACCESS_TOKENS_FILE` / `YT_CLIENT_SECRETS_FILE` env vars (auto-loaded from
  a `.env` file in the current working directory).
- Insert/update commands accept a raw JSON resource via `--body '<json>'`.
- `videos insert` additionally takes `--video-file <path>` for the upload.

## [1.0.1] - 2026-05-19

### Changed

- **Bumped underlying Dart packages to `3.0.2`**: rebuilt against `yt` and
  `yt_cli` 3.0.2, picking up the repository URL migration to
  `github.com/cdavis-code/yt_workspace` and tightened `json_annotation` /
  `json_serializable` constraints. No JS-facing API or behavioral changes.

## [1.0.0] - 2026-05-17

### Added
- Initial release
- YouTube Search API (search list)
- YouTube Channels API (channels list)
- YouTube Videos API (videos list)
- YouTube Playlists API (playlists list)
- YouTube Activities API (activities list)
- API key and OAuth2 authentication
- JSON output to stdout
