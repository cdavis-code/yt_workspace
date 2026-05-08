/**
 * Shared TypeScript types for yt_js.
 *
 * These mirror the response DTOs from the Dart `yt` package.
 */

export interface ConnectOptions {
  logLevel?: 'all' | 'debug' | 'info' | 'warning' | 'error';
}

export interface Thumbnail {
  url: string;
  width: number;
  height: number;
}

export interface ResourceId {
  kind: string;
  videoId?: string;
  channelId?: string;
  playlistId?: string;
}

export interface SearchResult {
  kind: string;
  etag: string;
  id: ResourceId;
  snippet?: {
    publishedAt: string;
    channelId: string;
    title: string;
    description: string;
    thumbnails: Record<string, Thumbnail>;
    channelTitle: string;
    liveBroadcastContent?: string;
  };
}

export interface VideoItem {
  kind: string;
  etag: string;
  id: string;
  snippet?: {
    publishedAt: string;
    channelId: string;
    title: string;
    description: string;
    thumbnails: Record<string, Thumbnail>;
    channelTitle: string;
    tags?: string[];
    categoryId?: string;
    liveBroadcastContent?: string;
  };
  contentDetails?: Record<string, any>;
  statistics?: {
    viewCount: string;
    likeCount: string;
    dislikeCount: string;
    favoriteCount: string;
    commentCount: string;
  };
}

export interface ChannelItem {
  kind: string;
  etag: string;
  id: string;
  snippet?: {
    title: string;
    description: string;
    customUrl?: string;
    publishedAt: string;
    thumbnails: Record<string, Thumbnail>;
  };
  statistics?: {
    viewCount: string;
    subscriberCount: string;
    hiddenSubscriberCount: boolean;
    videoCount: string;
  };
}

export interface Playlist {
  kind: string;
  etag: string;
  id: string;
  snippet?: {
    publishedAt: string;
    channelId: string;
    title: string;
    description: string;
    thumbnails: Record<string, Thumbnail>;
    channelTitle: string;
  };
  contentDetails?: {
    itemCount: number;
  };
}

/** Low-level handle exposed by the dart2js runtime. Internal use. */
export interface YtJsHandle {
  channelsList(
    part?: string,
    id?: string,
    forUsername?: string,
    maxResults?: number,
  ): Promise<Record<string, any>>;
  searchList(
    q: string,
    part?: string,
    type?: string,
    maxResults?: number,
  ): Promise<Record<string, any>>;
  videosList(
    id?: string,
    chart?: string,
    part?: string,
    maxResults?: number,
  ): Promise<Record<string, any>>;
  playlistsList(
    channelId?: string,
    id?: string,
    part?: string,
    maxResults?: number,
  ): Promise<Record<string, any>>;
  close(): void;
}

export interface YtJsNamespace {
  withApiKey(
    apiKey: string,
    logLevel?: string,
  ): Promise<YtJsHandle>;
  withOAuth(logLevel?: string): Promise<YtJsHandle>;
  version: string;
}
