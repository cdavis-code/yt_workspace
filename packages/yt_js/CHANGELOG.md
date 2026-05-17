# Changelog

## Unreleased

### Documentation
- README updated to document the new `YT_CLIENT_SECRETS_FILE` and
  `YT_ACCESS_TOKENS_FILE` environment variables for overriding individual
  OAuth credential file paths. Behavior is inherited from the underlying
  `yt` Dart package — no JS-side code changes.

## [2.3.0] - 2025-05-16

### Added
- YouTube Activities API (channel activity feeds) via updated yt ^2.3.0 dependency

### Notes
- Compiled from yt package version 2.3.0

## [2.2.6] - 2025-05-08

### Added
- Initial release as separate package
- JavaScript/TypeScript bindings for yt Dart package
- dart2js compilation for browser and Node.js support
- npm package distribution

### Notes
- Compiled from yt package version 2.2.6
- Depends on yt ^2.2.6
