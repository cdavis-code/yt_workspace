/**
 * TypeScript types for yt_cli_js.
 *
 * These mirror the JS interop surface exposed by the Dart `js_bindings.dart`.
 */

/** Handle returned by `withApiKey` / `withOAuth` — wraps a Yt instance. */
export interface YtCliJsHandle {
  searchList(
    q: string,
    part?: string,
    type?: string,
    maxResults?: number,
    pageToken?: string,
  ): Promise<Record<string, any>>;

  channelsList(
    part?: string,
    id?: string,
    forUsername?: string,
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

  // Broadcast (Live Streaming)
  broadcastList(
    part?: string,
    broadcastStatus?: string,
    broadcastType?: string,
    id?: string,
    maxResults?: number,
  ): Promise<Record<string, any>>;

  broadcastInsert(
    part?: string,
    body?: Record<string, any>,
  ): Promise<Record<string, any>>;

  broadcastUpdate(
    part?: string,
    body?: Record<string, any>,
  ): Promise<Record<string, any>>;

  broadcastDelete(id: string): Promise<Record<string, any>>;

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

  streamInsert(
    part?: string,
    body?: Record<string, any>,
  ): Promise<Record<string, any>>;

  streamUpdate(
    part?: string,
    body?: Record<string, any>,
  ): Promise<Record<string, any>>;

  streamDelete(id: string): Promise<Record<string, any>>;

  // Chat
  chatListMessages(
    liveChatId: string,
    part?: string,
    maxResults?: number,
    pageToken?: string,
  ): Promise<Record<string, any>>;

  chatInsertMessage(
    part?: string,
    body?: Record<string, any>,
  ): Promise<Record<string, any>>;

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

  commentsInsert(
    part?: string,
    body?: Record<string, any>,
  ): Promise<Record<string, any>>;

  commentsUpdate(
    part?: string,
    body?: Record<string, any>,
  ): Promise<Record<string, any>>;

  commentsDelete(id: string): Promise<Record<string, any>>;

  commentsSetModerationStatus(
    id: string,
    moderationStatus: string,
    banAuthor?: boolean,
  ): Promise<Record<string, any>>;

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

  commentThreadsInsert(
    part?: string,
    body?: Record<string, any>,
  ): Promise<Record<string, any>>;

  // Subscriptions
  subscriptionsList(
    part?: string,
    channelId?: string,
    mine?: boolean,
    maxResults?: number,
    pageToken?: string,
  ): Promise<Record<string, any>>;

  subscriptionsInsert(
    part?: string,
    body?: Record<string, any>,
  ): Promise<Record<string, any>>;

  subscriptionsDelete(id: string): Promise<Record<string, any>>;

  // PlaylistItems
  playlistItemsList(
    part?: string,
    playlistId?: string,
    id?: string,
    maxResults?: number,
    pageToken?: string,
  ): Promise<Record<string, any>>;

  playlistItemsInsert(
    part?: string,
    body?: Record<string, any>,
  ): Promise<Record<string, any>>;

  playlistItemsUpdate(
    part?: string,
    body?: Record<string, any>,
  ): Promise<Record<string, any>>;

  playlistItemsDelete(id: string): Promise<Record<string, any>>;

  // Thumbnails
  thumbnailsSet(
    videoId: string,
    filePath: string,
  ): Promise<Record<string, any>>;

  // Watermarks
  watermarksSet(
    channelId: string,
    body?: Record<string, any>,
  ): Promise<Record<string, any>>;

  watermarksUnset(channelId: string): Promise<Record<string, any>>;

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
    body?: Record<string, any>,
    onBehalfOfContentOwner?: string,
  ): Promise<Record<string, any>>;

  analyticsGroupsUpdate(
    body?: Record<string, any>,
    onBehalfOfContentOwner?: string,
  ): Promise<Record<string, any>>;

  analyticsGroupsDelete(
    id: string,
    onBehalfOfContentOwner?: string,
  ): Promise<Record<string, any>>;

  analyticsGroupItemsList(
    groupId?: string,
    id?: string,
    pageToken?: string,
    onBehalfOfContentOwner?: string,
  ): Promise<Record<string, any>>;

  analyticsGroupItemsInsert(
    body?: Record<string, any>,
    onBehalfOfContentOwner?: string,
  ): Promise<Record<string, any>>;

  analyticsGroupItemsDelete(
    id: string,
    onBehalfOfContentOwner?: string,
  ): Promise<Record<string, any>>;

  close(): void;
}

/** The namespace installed on `globalThis.YtCliJs` by the dart2js runtime. */
export interface YtCliJsNamespace {
  withApiKey(apiKey: string, logLevel?: string): Promise<YtCliJsHandle>;
  withOAuth(
    accessTokensPath?: string,
    clientSecretsPath?: string,
    logLevel?: string,
  ): Promise<YtCliJsHandle>;
  version: string;
}
