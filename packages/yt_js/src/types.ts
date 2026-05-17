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
  // Channels
  channelsList(
    part?: string,
    id?: string,
    forUsername?: string,
    maxResults?: number,
  ): Promise<Record<string, any>>;

  // Search
  searchList(
    q: string,
    part?: string,
    type?: string,
    maxResults?: number,
  ): Promise<Record<string, any>>;

  // Videos
  videosList(
    id?: string,
    chart?: string,
    part?: string,
    maxResults?: number,
  ): Promise<Record<string, any>>;

  // Playlists
  playlistsList(
    channelId?: string,
    id?: string,
    part?: string,
    maxResults?: number,
  ): Promise<Record<string, any>>;

  // Broadcast (Live Streaming)
  broadcastList(
    part?: string,
    broadcastStatus?: string,
    broadcastType?: string,
    id?: string,
    maxResults?: number,
  ): Promise<Record<string, any>>;
  broadcastInsert(part: string, body: any): Promise<Record<string, any>>;
  broadcastUpdate(part: string, body: any): Promise<Record<string, any>>;
  broadcastDelete(id: string): Promise<void>;
  broadcastTransition(
    id: string,
    broadcastStatus?: string,
    part?: string,
  ): Promise<Record<string, any>>;
  broadcastBind(
    id: string,
    part?: string,
    streamId?: string,
  ): Promise<Record<string, any>>;

  // LiveStream
  streamList(
    part?: string,
    id?: string,
    mine?: boolean,
    maxResults?: number,
    pageToken?: string,
  ): Promise<Record<string, any>>;
  streamInsert(part: string, body: any): Promise<Record<string, any>>;
  streamUpdate(part: string, body: any): Promise<Record<string, any>>;
  streamDelete(id: string): Promise<void>;

  // Chat
  chatListMessages(
    liveChatId: string,
    part?: string,
    maxResults?: number,
    pageToken?: string,
  ): Promise<Record<string, any>>;
  chatInsertMessage(part: string, body: any): Promise<Record<string, any>>;

  // Comments
  commentsList(
    part?: string,
    id?: string,
    parentId?: string,
  ): Promise<Record<string, any>>;
  commentsListByIds(
    ids?: string,
    maxResults?: number,
    pageToken?: string,
    textFormat?: string,
  ): Promise<Record<string, any>>;
  commentsListById(
    id?: string,
    textFormat?: string,
  ): Promise<Record<string, any>>;
  commentsInsert(part: string, body: any): Promise<Record<string, any>>;
  commentsUpdate(part: string, body: any): Promise<Record<string, any>>;
  commentsDelete(id: string): Promise<void>;
  commentsSetModerationStatus(
    id: string,
    moderationStatus: string,
    banAuthor?: boolean,
  ): Promise<void>;

  // CommentThreads
  commentThreadsList(
    part?: string,
    videoId?: string,
    channelId?: string,
    id?: string,
    maxResults?: number,
    pageToken?: string,
    order?: string,
  ): Promise<Record<string, any>>;
  commentThreadsListById(
    id?: string,
    part?: string,
  ): Promise<Record<string, any>>;
  commentThreadsInsert(part: string, body: any): Promise<Record<string, any>>;

  // Subscriptions
  subscriptionsList(
    part?: string,
    channelId?: string,
    mine?: boolean,
    maxResults?: number,
    pageToken?: string,
  ): Promise<Record<string, any>>;
  subscriptionsInsert(part: string, body: any): Promise<Record<string, any>>;
  subscriptionsDelete(id: string): Promise<void>;

  // PlaylistItems
  playlistItemsList(
    part?: string,
    playlistId?: string,
    id?: string,
    maxResults?: number,
    pageToken?: string,
  ): Promise<Record<string, any>>;
  playlistItemsInsert(part: string, body: any): Promise<Record<string, any>>;
  playlistItemsUpdate(part: string, body: any): Promise<Record<string, any>>;
  playlistItemsDelete(id: string): Promise<void>;

  // Thumbnails
  thumbnailsSet(
    videoId: string,
    filePath: string,
  ): Promise<Record<string, any>>;

  // Watermarks
  watermarksSet(channelId: string, body: any): Promise<Record<string, any>>;
  watermarksUnset(channelId: string): Promise<void>;

  // VideoCategories
  videoCategoriesList(
    part?: string,
    id?: string,
    regionCode?: string,
    hl?: string,
  ): Promise<Record<string, any>>;

  // Members
  membersList(
    part?: string,
    mode?: string,
    maxResults?: number,
    pageToken?: string,
  ): Promise<Record<string, any>>;

  // MembershipsLevels
  membershipsLevelsList(part?: string): Promise<Record<string, any>>;

  // VideoAbuseReportReasons
  videoAbuseReportReasonsList(
    part?: string,
    hl?: string,
  ): Promise<Record<string, any>>;

  // Analytics
  analyticsQuery(
    ids: string,
    startDate: string,
    endDate: string,
    metrics: string,
    dimensions?: string,
    filters?: string,
    sort?: string,
    maxResults?: number,
    startIndex?: number,
    currency?: string,
    includeHistoricalChannelData?: boolean,
  ): Promise<Record<string, any>>;
  analyticsGroupsList(
    id?: string,
    mine?: boolean,
    pageToken?: string,
    onBehalfOfContentOwner?: string,
  ): Promise<Record<string, any>>;
  analyticsGroupsInsert(
    body: any,
    onBehalfOfContentOwner?: string,
  ): Promise<Record<string, any>>;
  analyticsGroupsUpdate(
    body: any,
    onBehalfOfContentOwner?: string,
  ): Promise<Record<string, any>>;
  analyticsGroupsDelete(
    id: string,
    onBehalfOfContentOwner?: string,
  ): Promise<void>;
  analyticsGroupItemsList(
    groupId?: string,
    id?: string,
    pageToken?: string,
    onBehalfOfContentOwner?: string,
  ): Promise<Record<string, any>>;
  analyticsGroupItemsInsert(
    body: any,
    onBehalfOfContentOwner?: string,
  ): Promise<Record<string, any>>;
  analyticsGroupItemsDelete(
    id: string,
    onBehalfOfContentOwner?: string,
  ): Promise<void>;

  // Activities
  activitiesList(
    channelId?: string,
    mine?: boolean,
    part?: string,
    maxResults?: number,
    pageToken?: string,
    publishedAfter?: string,
    publishedBefore?: string,
    regionCode?: string,
  ): Promise<Record<string, any>>;

  // Close
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
