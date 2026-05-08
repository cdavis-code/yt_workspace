/**
 * yt_js — public TypeScript API.
 *
 * This facade wraps the dart2js-compiled `yt` core, exposing an idiomatic
 * JavaScript API: Promise-based methods for YouTube Data and Live Streaming
 * operations, with typed sub-APIs (channels, videos, playlists, search, etc.).
 */

import type { DartRuntimeLoader } from './runtime.js';
import { getRuntime } from './runtime.js';
import type {
  YtJsHandle,
  YtJsNamespace,
  ConnectOptions,
} from './types.js';

export * from './types.js';

export class Yt {
  private constructor(private readonly handle: YtJsHandle) {}

  /**
   * Create a Yt client using an API key (read-only access to public data).
   */
  static async withApiKey(
    apiKey: string,
    opts: ConnectOptions = {},
    loader?: DartRuntimeLoader,
  ): Promise<Yt> {
    if (!loader) {
      throw new Error(
        'No Dart runtime loader provided. Import from ' +
          "'@unngh/yt-js/browser' or '@unngh/yt-js/node' instead.",
      );
    }
    const ns = await getRuntime(loader);
    const handle = await ns.withApiKey(apiKey, opts.logLevel);
    return new Yt(handle);
  }

  /**
   * Create a Yt client using OAuth (requires pre-configured credentials).
   */
  static async withOAuth(
    opts: ConnectOptions = {},
    loader?: DartRuntimeLoader,
  ): Promise<Yt> {
    if (!loader) {
      throw new Error(
        'No Dart runtime loader provided. Import from ' +
          "'@unngh/yt-js/browser' or '@unngh/yt-js/node' instead.",
      );
    }
    const ns = await getRuntime(loader);
    const handle = await ns.withOAuth(opts.logLevel);
    return new Yt(handle);
  }

  /** Search for YouTube videos, channels, and playlists. */
  searchList(params: {
    q: string;
    part?: string;
    type?: string;
    maxResults?: number;
  }): Promise<Record<string, any>> {
    return this.handle.searchList(
      params.q,
      params.part,
      params.type,
      params.maxResults,
    );
  }

  /** List channels. */
  channelsList(params: {
    part?: string;
    id?: string;
    forUsername?: string;
    maxResults?: number;
  }): Promise<Record<string, any>> {
    return this.handle.channelsList(
      params.part,
      params.id,
      params.forUsername,
      params.maxResults,
    );
  }

  /** List videos. */
  videosList(params: {
    id?: string;
    chart?: string;
    part?: string;
    maxResults?: number;
  }): Promise<Record<string, any>> {
    return this.handle.videosList(
      params.id,
      params.chart,
      params.part,
      params.maxResults,
    );
  }

  /** List playlists. */
  playlistsList(params: {
    channelId?: string;
    id?: string;
    part?: string;
    maxResults?: number;
  }): Promise<Record<string, any>> {
    return this.handle.playlistsList(
      params.channelId,
      params.id,
      params.part,
      params.maxResults,
    );
  }

  /** Close the underlying HTTP client. */
  async close(): Promise<void> {
    this.handle.close();
  }
}
