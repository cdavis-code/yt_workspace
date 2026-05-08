/**
 * Node.js entrypoint for yt_js.
 *
 * dart2js output targets the browser runtime — it expects `self` and `window`
 * globals. We polyfill these before loading the compiled module.
 */

import { Yt as Base } from './index.js';
import type { ConnectOptions } from './types.js';

export * from './index.js';

const ensurePolyfills = async () => {
  const g = globalThis as any;
  if (!g.self) g.self = g;
  if (!g.window) g.window = g;
};

const loadDart = async () => {
  await ensurePolyfills();
  // @ts-expect-error -- resolved at build time; present in dist/.
  await import('../build/dart/yt_js.js');
};

export class Yt extends Base {
  static override async withApiKey(
    apiKey: string,
    opts: ConnectOptions = {},
  ): Promise<Yt> {
    return (await Base.withApiKey(apiKey, opts, loadDart)) as Yt;
  }

  static override async withOAuth(
    opts: ConnectOptions = {},
  ): Promise<Yt> {
    return (await Base.withOAuth(opts, loadDart)) as Yt;
  }

  /**
   * Convenience: create using `process.env.YT_API_KEY`. Returns `null` if
   * `YT_API_KEY` is not set. Node-only (browsers have no `process`).
   */
  static async fromEnv(
    opts: ConnectOptions = {},
  ): Promise<Yt | null> {
    const apiKey = process.env.YT_API_KEY;
    if (!apiKey) return null;
    return Yt.withApiKey(apiKey, opts);
  }
}
