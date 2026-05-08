/**
 * Browser entrypoint for yt_js.
 *
 * Loads the dart2js runtime and re-exports the public API.
 */

import { Yt as Base } from './index.js';
import type { ConnectOptions } from './types.js';

export * from './index.js';

/**
 * In production builds, `../build/dart/yt_js.js` is emitted by
 * dart2js and bundled alongside the TS output by tsup. The dynamic import
 * lets bundlers (vite/webpack/rollup) split it into a separate chunk.
 */
const loadDart = async () => {
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
}
