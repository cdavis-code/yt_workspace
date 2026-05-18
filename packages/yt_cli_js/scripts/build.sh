#!/usr/bin/env bash
# Compiles the Dart CLI entry point into JavaScript using dart2js,
# then bundles the TypeScript CLI wrapper with tsup.
#
# Output: dist/cli.js (Node.js ESM CLI) + dist/yt_cli_js.runtime.js (Dart runtime)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${PKG_DIR}"

echo "==> Fetching Dart dependencies"
dart pub get

mkdir -p build/dart

echo "==> Compiling Dart -> JavaScript (dart2js -O4)"
dart compile js \
  -O4 \
  -o build/dart/yt_cli_js.js \
  lib/yt_cli_js.dart

# Remove the sibling .deps file that dart2js emits (not needed in dist).
rm -f build/dart/yt_cli_js.js.deps

echo "==> Installing npm dependencies"
npm install

echo "==> Bundling TypeScript CLI with tsup"
npx tsup

# Copy Dart runtime to dist/ so the CLI can load it at runtime.
mkdir -p dist
cp build/dart/yt_cli_js.js dist/yt_cli_js.runtime.js

echo "==> Build complete: $(du -h build/dart/yt_cli_js.js | cut -f1)"
