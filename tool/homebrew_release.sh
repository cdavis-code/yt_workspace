#!/usr/bin/env bash
set -euo pipefail

# Homebrew release helper for yt_cli.
# Run AFTER pushing a yt_cli-v* tag and the GitHub Release has been created
# by the homebrew-release workflow.
#
# Usage: dart run melos run homebrew

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
PACKAGE_DIR="${WORKSPACE_DIR}/packages/yt_cli"
FORMULA="${WORKSPACE_DIR}/homebrew/yt.rb"
TAP_DIR="${WORKSPACE_DIR}/../homebrew-yt"

# 1. Extract version from pubspec.yaml
FULL_VERSION=$(grep '^version:' "${PACKAGE_DIR}/pubspec.yaml" | sed 's/version: //')
VERSION="${FULL_VERSION%+*}"           # strip build number (e.g. "2.2.6+5" → "2.2.6")
TAG="yt_cli-v${VERSION}"

echo "==> Version: ${VERSION} (full: ${FULL_VERSION})"
echo "==> Tag:     ${TAG}"

# 2. Construct tarball URL
TARBALL_URL="https://github.com/cdavis-code/yt_workspace/archive/refs/tags/${TAG}.tar.gz"

# 3. Download tarball and compute SHA256
echo "==> Downloading tarball..."
SHA256=$(curl -sL "${TARBALL_URL}" | shasum -a 256 | cut -d' ' -f1)

if [ -z "$SHA256" ]; then
  echo "ERROR: Failed to download tarball. Has the GitHub Release for ${TAG} been created yet?"
  echo "       URL: ${TARBALL_URL}"
  exit 1
fi

echo "==> SHA256:  ${SHA256}"

# 4. Update homebrew/yt.rb
echo "==> Updating ${FORMULA}"

# Update version
sed -i '' "s/version \"[^\"]*\"/version \"${VERSION}\"/" "${FORMULA}"

# Update URL
sed -i '' "s|url \"https://github.com/cdavis-code/yt_workspace/archive/refs/tags/[^\"]*\"|url \"${TARBALL_URL}\"|" "${FORMULA}"

# Update SHA256
awk -v sha="$SHA256" '
  /sha256/ && !done {
    sub(/"[^"]*"/, "\"" sha "\"")
    done=1
  }
  { print }
' "${FORMULA}" > "${FORMULA}.tmp" && mv "${FORMULA}.tmp" "${FORMULA}"

echo "==> Formula updated:"
grep -E '(version|url|sha256)' "${FORMULA}"

# 5. Sync to tap repo
if [ -d "${TAP_DIR}/Formula" ]; then
  echo "==> Copying formula to tap repo: ${TAP_DIR}"
  cp "${FORMULA}" "${TAP_DIR}/Formula/yt.rb"

  echo "==> Committing and pushing to homebrew-yt"
  cd "${TAP_DIR}"
  git add Formula/yt.rb
  git commit -m "yt_cli v${VERSION}" || echo "No changes to commit"
  git push origin main
else
  echo "==> Tap repo not found at ${TAP_DIR}"
  echo "    Formula updated locally. Manually sync to your tap repo with:"
  echo "    cp homebrew/yt.rb ../homebrew-yt/Formula/yt.rb"
  echo "    cd ../homebrew-yt && git commit -am \"yt_cli v${VERSION}\" && git push"
fi

echo "==> Done."
