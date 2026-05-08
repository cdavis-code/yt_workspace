/// dart2js entry point for the yt_js npm package.
///
/// When this module is loaded in a JavaScript environment, `main()` installs
/// a `globalThis.YtJs` namespace with a minimal, interop-friendly surface
/// (init, search, videos, channels, playlists, etc.).
/// The rich, typed API is layered on top in TypeScript (see `src/index.ts`).
library;

import 'package:yt_js/src/js_bindings.dart' as bindings;

void main() {
  bindings.install();
}
