#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."

echo "==> Cleaning old dist/"
rm -rf dist

echo "==> Installing Dart dependencies"
dart pub get

echo "==> Compiling Dart to JavaScript"
mkdir -p build/dart
dart compile js -O4 -o build/dart/yt_mcp_server.js lib/yt_mcp_js.dart

echo "==> Copying to dist/"
mkdir -p dist
cp build/dart/yt_mcp_server.js dist/yt_mcp_server.runtime.js

# Also copy the .js.map file if it exists (for debugging)
if [ -f build/dart/yt_mcp_server.js.map ]; then
  cp build/dart/yt_mcp_server.js.map dist/yt_mcp_server.runtime.js.map
fi

echo "==> Verifying build output"
if [ ! -f dist/yt_mcp_server.runtime.js ]; then
  echo "ERROR: dist/yt_mcp_server.runtime.js not found"
  exit 1
fi

MIN_SIZE=100000
case "$(uname -s)" in
  Darwin)   ACTUAL_SIZE=$(stat -f%z dist/yt_mcp_server.runtime.js) ;;
  Linux)    ACTUAL_SIZE=$(stat -c%s dist/yt_mcp_server.runtime.js) ;;
  *)        ACTUAL_SIZE=$(wc -c < dist/yt_mcp_server.runtime.js | tr -d ' ') ;;
esac

if [ "$ACTUAL_SIZE" -lt "$MIN_SIZE" ]; then
  echo "ERROR: dist/yt_mcp_server.runtime.js too small ($ACTUAL_SIZE bytes, minimum $MIN_SIZE)"
  exit 1
fi

echo "==> Build verified: $(wc -c < dist/yt_mcp_server.runtime.js | tr -d ' ') bytes"
echo "Build complete!"
