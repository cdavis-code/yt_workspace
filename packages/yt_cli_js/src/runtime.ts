/**
 * Loads the dart2js-compiled runtime and returns the `YtCliJs`
 * namespace installed on `globalThis`.
 *
 * dart2js output targets the browser — it expects `self` and `window`
 * globals. We polyfill these before loading the compiled module.
 */

import type { YtCliJsNamespace } from './types.js';

let cached: YtCliJsNamespace | undefined;

const ensurePolyfills = () => {
  const g = globalThis as any;
  if (!g.self) g.self = g;
  if (!g.window) g.window = g;
};

export async function getRuntime(): Promise<YtCliJsNamespace> {
  if (cached) return cached;

  ensurePolyfills();

  // @ts-expect-error -- resolved at build time; present in dist/.
  await import('../build/dart/yt_cli_js.js');

  const ns = (globalThis as any).YtCliJs as YtCliJsNamespace | undefined;
  if (!ns) {
    throw new Error(
      'yt_cli_js runtime failed to initialise: ' +
        'globalThis.YtCliJs was not installed.',
    );
  }

  cached = ns;
  return ns;
}
