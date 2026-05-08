#!/usr/bin/env bash
# Compiles the Dart interop entry point into JavaScript using dart2js.
#
# Output: build/dart/yt_js.js (ES module installing globalThis.YtJs)

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
  -o build/dart/yt_js.js \
  lib/yt_js.dart

# Remove the sibling .deps file that dart2js emits (not needed in dist).
rm -f build/dart/yt_js.js.deps

# Copy to dist/ so tsup-external dynamic imports resolve at runtime.
mkdir -p dist
cp build/dart/yt_js.js dist/yt_js.runtime.js

echo "==> Dart runtime built: $(du -h build/dart/yt_js.js | cut -f1)"
