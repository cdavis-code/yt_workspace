# Publishing @unngh/youtube-cli

This package is a Dart-to-JavaScript npm package — the Dart source is compiled
via `dart2js`, then bundled with a TypeScript CLI wrapper via `tsup`.

## Prerequisites

- **Node.js** >= 18
- **Dart SDK** >= 3.8.0 (stable)
- **npm auth** — a granular access token with read+write access to the
  `@unngh` scope on npmjs.com. Verify with:
  ```bash
  npm whoami --scope=@unngh
  ```

## Pre-publish checklist

1. **Build passes clean:**
   ```bash
   cd packages/yt_cli_js
   dart analyze --fatal-infos
   npm run build          # dart2js + tsup
   ```

2. **Smoke test the CLI:**
   ```bash
   node dist/cli.js --help
   node dist/cli.js --version
   ```

3. **Version is bumped** — only `package.json` needs updating:
   - `"version": "1.2.0"`
   - The Dart runtime (`js_bindings.dart`) reads it at build time via `dart compile js -DYT_CLI_JS_VERSION=...`
   - The CLI banner (`cli.ts`) reads it at runtime from the same `package.json` via `createRequire`

4. **CHANGELOG.md** has an entry for the new version.

5. **Changes committed** and pushed to `main`.

## Manual publish

From the package directory:

```bash
cd packages/yt_cli_js
npm publish --access public
```

The `prepublishOnly` hook runs `npm run build` automatically, so `dist/` is
always up to date.

## CI publish (recommended)

Push a tag matching `youtube-cli-v*` and GitHub Actions will build and publish:

```bash
git tag youtube-cli-v1.2.0
git push origin youtube-cli-v1.2.0
```

The workflow (`.github/workflows/dart.yml`):
1. `yt_cli_js` job — compiles Dart → JS, bundles TypeScript CLI
2. `publish-yt-cli-js` job — publishes to npm using `NPM_TOKEN` secret

No local build or npm login required — CI handles everything.

### Required secret

| Secret | Purpose |
|--------|---------|
| `NPM_TOKEN` | npm automation token with publish permission for `@unngh` scope |

Set in the GitHub repo under **Settings > Secrets and variables > Actions**.

## Verify the published package

```bash
# Check the latest version on npm
npm view @unngh/youtube-cli version

# Install globally and test
npm install -g @unngh/youtube-cli
youtube-cli --help
```
