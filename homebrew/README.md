# Homebrew Tap for yt_cli

This directory contains the Homebrew formula for installing the `yt` CLI tool.

## Quick Start

```bash
# Add the tap
brew tap cdavis-code/yt

# Install the latest development version (HEAD build from source)
brew install --head yt

# Or, once a stable release is tagged:
brew install yt
```

## Formula Details

The formula at [`yt.rb`](yt.rb) installs the `yt` command-line tool — a CLI for interacting with the YouTube Data, Live Streaming, and Analytics APIs.

### Requirements

- [Dart SDK](https://dart.dev/get-dart) — automatically installed by Homebrew as a build dependency when installing from source

### How It Works

1. The formula clones the `yt_workspace` monorepo (or downloads a release tarball for stable installs)
2. Removes `resolution: workspace` from `packages/yt_cli/pubspec.yaml` so the package builds standalone
3. Runs `dart pub get` in `packages/yt_cli/` to resolve dependencies
4. Compiles `packages/yt_cli/bin/yt.dart` to a native binary with `dart compile exe`
5. Installs the resulting binary to `/usr/local/bin/yt`

## Releasing a Stable Version

1. Bump the version in `packages/yt_cli/pubspec.yaml`
2. Publish to pub.dev: `cd packages/yt_cli && dart pub publish`
3. Push a version tag (e.g. `git tag yt_cli-v2.2.7 && git push origin yt_cli-v2.2.7`)

The GitHub Actions workflow (`homebrew-release.yml`) is triggered automatically by the tag and handles everything else:

- Compiles native binaries for macOS (ARM64 + x64) and Linux (x64)
- Creates a GitHub Release with all binaries and a `checksums.txt` file
- Computes the source tarball SHA256 and updates `homebrew/yt.rb` (version, URL, SHA256)
- Pushes the updated formula to the `cdavis-code/homebrew-yt` tap repository

No manual SHA256 computation or formula update steps are required.

### Required GitHub Secret

The `HOMEBREW_TAP_TOKEN` secret must be configured in **Settings > Secrets and variables > Actions** — it should be a GitHub PAT with write access to the `cdavis-code/homebrew-yt` repository.

### Manual Fallback

If you need to update the formula outside of the automated workflow (e.g. for testing or fixing a failed run):

```bash
melos run homebrew
# or directly:
./tool/homebrew_release.sh
```

## Setting Up the Tap Repository

This `homebrew/` directory is the source for your Homebrew tap. The `cdavis-code/homebrew-yt` repository should contain a `Formula/yt.rb` file that mirrors this formula. The release workflow automatically syncs formula updates to the tap.

Users install via: `brew tap cdavis-code/yt && brew install yt`
