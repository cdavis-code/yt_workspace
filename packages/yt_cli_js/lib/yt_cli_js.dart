/// dart2js entry point for the yt_cli_js npm package.
///
/// When this module is loaded in a JavaScript environment, `main()` installs
/// a `globalThis.YtCliJs` namespace with an interop-friendly surface
/// (init, search, videos, channels, playlists, activities, etc.).
/// The rich, typed API is layered on top in TypeScript (see `src/index.ts`).
library;

import 'package:yt_cli_js/src/js_bindings.dart' as bindings;

void main() {
  bindings.install();
}
