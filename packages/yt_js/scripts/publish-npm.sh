#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${PKG_DIR}"

BUMP="${1:-}"
if [ -z "$BUMP" ]; then
  echo "Usage: $0 <patch|minor|major|<version>>"
  echo "  e.g. $0 patch"
  echo "  e.g. $0 2.3.0"
  exit 1
fi

# Bump version in package.json only (we create our own git tag below).
echo "==> Bumping version: $BUMP"
npm version "$BUMP" --no-git-tag-version

NEW_VERSION=$(node -p 'require("./package.json").version')
TAG="youtube-api-v${NEW_VERSION}"

echo "==> Publishing @unngh/youtube-api@${NEW_VERSION} to npm"

npm run build
npm publish --access public

git add package.json
git commit -m "chore(yt_js): bump version to ${NEW_VERSION}"
git tag "$TAG"
git push origin main --tags

echo "==> Published and tagged $TAG"
