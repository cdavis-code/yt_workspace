#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${PKG_DIR}"

CURRENT=$(node -p 'require("./package.json").version')
TAG="yt_mcp_js-v${CURRENT}"

echo "==> Publishing @unngh/yt-mcp@${CURRENT} to npm"

if git tag -l "$TAG" | grep -q "$TAG"; then
  echo "Tag $TAG already exists. Remove it first if you want to re-publish."
  exit 1
fi

npm run build
npm publish --access public

git tag "$TAG"
git push origin "$TAG"

echo "==> Published and tagged $TAG"
