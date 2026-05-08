/**
 * Loads the dart2js-compiled runtime and returns the `YtJs`
 * namespace installed on `globalThis`. Dispatch is platform-specific — see
 * `browser.ts` and `node.ts` for the actual loader implementations.
 */

import type { YtJsNamespace } from './types.js';

let cached: YtJsNamespace | undefined;

export type DartRuntimeLoader = () => Promise<void>;

export async function getRuntime(
  loader: DartRuntimeLoader,
): Promise<YtJsNamespace> {
  if (cached) return cached;
  await loader();
  const ns = (globalThis as any).YtJs as YtJsNamespace | undefined;
  if (!ns) {
    throw new Error(
      'yt_js runtime failed to initialise: ' +
        'globalThis.YtJs was not installed.',
    );
  }
  cached = ns;
  return ns;
}
