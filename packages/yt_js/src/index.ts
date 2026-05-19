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
  ConnectOptions,
} from './types.js';

export * from './types.js';

export class Yt {
  protected constructor(private readonly handle: YtJsHandle) {}

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

  // ---------------------------------------------------------------------------
  // Search
  // ---------------------------------------------------------------------------

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

  // ---------------------------------------------------------------------------
  // Channels
  // ---------------------------------------------------------------------------

  /** List channels. */
  channelsList(params: {
    part?: string;
    id?: string;
    forUsername?: string;
    maxResults?: number;
  } = {}): Promise<Record<string, any>> {
    return this.handle.channelsList(
      params.part,
      params.id,
      params.forUsername,
      params.maxResults,
    );
  }

  /** Update a channel. */
  async channelsUpdate(opts: {
    part?: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.channelsUpdate(opts.part ?? 'contentDetails,id,localizations,player,snippet,status', opts.body);
  }

  // ---------------------------------------------------------------------------
  // Videos
  // ---------------------------------------------------------------------------

  /** List videos. */
  videosList(params: {
    id?: string;
    chart?: string;
    part?: string;
    maxResults?: number;
  } = {}): Promise<Record<string, any>> {
    return this.handle.videosList(
      params.id,
      params.chart,
      params.part,
      params.maxResults,
    );
  }

  /** Upload a video. */
  async videosInsert(opts: {
    part?: string;
    body: Record<string, any>;
    filePath: string;
  }): Promise<Record<string, any>> {
    return this.handle.videosInsert(opts.part ?? 'snippet,status,contentDetails', opts.body, opts.filePath);
  }

  /** Update a video's metadata. */
  async videosUpdate(opts: {
    part?: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.videosUpdate(opts.part ?? 'snippet,status,contentDetails', opts.body);
  }

  /** Rate a video (like/dislike/none). */
  async videosRate(opts: {
    id: string;
    rating: string;
  }): Promise<void> {
    return this.handle.videosRate(opts.id, opts.rating);
  }

  /** Get the rating the authorized user gave to a video. */
  async videosGetRating(opts: {
    id: string;
  }): Promise<Record<string, any>> {
    return this.handle.videosGetRating(opts.id);
  }

  /** Report a video for abusive content. */
  async videosReportAbuse(opts: {
    body: Record<string, any>;
  }): Promise<void> {
    return this.handle.videosReportAbuse(opts.body);
  }

  /** Delete a video. */
  async videosDelete(opts: { id: string }): Promise<void> {
    return this.handle.videosDelete(opts.id);
  }

  // ---------------------------------------------------------------------------
  // Playlists
  // ---------------------------------------------------------------------------

  /** List playlists. */
  playlistsList(params: {
    channelId?: string;
    id?: string;
    part?: string;
    maxResults?: number;
  } = {}): Promise<Record<string, any>> {
    return this.handle.playlistsList(
      params.channelId,
      params.id,
      params.part,
      params.maxResults,
    );
  }

  /** Create a playlist. */
  async playlistsInsert(opts: {
    part?: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.playlistsInsert(
      opts.part ?? 'contentDetails,id,localizations,player,snippet,status',
      opts.body,
    );
  }

  /** Update a playlist. */
  async playlistsUpdate(opts: {
    part?: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.playlistsUpdate(
      opts.part ?? 'contentDetails,id,localizations,player,snippet,status',
      opts.body,
    );
  }

  /** Delete a playlist. */
  async playlistsDelete(opts: { id: string }): Promise<void> {
    return this.handle.playlistsDelete(opts.id);
  }

  // ---------------------------------------------------------------------------
  // Broadcast (Live Streaming)
  // ---------------------------------------------------------------------------

  /** List live broadcasts. */
  async broadcastList(opts: {
    part?: string;
    broadcastStatus?: string;
    broadcastType?: string;
    id?: string;
    maxResults?: number;
  } = {}): Promise<Record<string, any>> {
    return this.handle.broadcastList(
      opts.part,
      opts.broadcastStatus,
      opts.broadcastType,
      opts.id,
      opts.maxResults,
    );
  }

  /** Insert a live broadcast. */
  async broadcastInsert(opts: {
    part?: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.broadcastInsert(opts.part ?? 'snippet', opts.body);
  }

  /** Update a live broadcast. */
  async broadcastUpdate(opts: {
    part?: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.broadcastUpdate(opts.part ?? 'snippet', opts.body);
  }

  /** Delete a live broadcast. */
  async broadcastDelete(opts: { id: string }): Promise<void> {
    return this.handle.broadcastDelete(opts.id);
  }

  /** Transition a live broadcast to a new status. */
  async broadcastTransition(opts: {
    id: string;
    broadcastStatus?: string;
    part?: string;
  }): Promise<Record<string, any>> {
    return this.handle.broadcastTransition(
      opts.id,
      opts.broadcastStatus,
      opts.part,
    );
  }

  /** Bind a broadcast to a stream. */
  async broadcastBind(opts: {
    id: string;
    part?: string;
    streamId?: string;
  }): Promise<Record<string, any>> {
    return this.handle.broadcastBind(opts.id, opts.part, opts.streamId);
  }

  /** Insert a cuepoint into a live broadcast. */
  async broadcastCuepoint(opts: {
    id: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.broadcastCuepoint(opts.id, opts.body);
  }

  // ---------------------------------------------------------------------------
  // LiveStream
  // ---------------------------------------------------------------------------

  /** List live streams. */
  async streamList(opts: {
    part?: string;
    id?: string;
    mine?: boolean;
    maxResults?: number;
    pageToken?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.streamList(
      opts.part,
      opts.id,
      opts.mine,
      opts.maxResults,
      opts.pageToken,
    );
  }

  /** Insert a live stream. */
  async streamInsert(opts: {
    part?: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.streamInsert(opts.part ?? 'snippet,cdn', opts.body);
  }

  /** Update a live stream. */
  async streamUpdate(opts: {
    part?: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.streamUpdate(opts.part ?? 'snippet,cdn', opts.body);
  }

  /** Delete a live stream. */
  async streamDelete(opts: { id: string }): Promise<void> {
    return this.handle.streamDelete(opts.id);
  }

  // ---------------------------------------------------------------------------
  // Chat
  // ---------------------------------------------------------------------------

  /** List live chat messages. */
  async chatListMessages(opts: {
    liveChatId: string;
    part?: string;
    maxResults?: number;
    pageToken?: string;
  }): Promise<Record<string, any>> {
    return this.handle.chatListMessages(
      opts.liveChatId,
      opts.part,
      opts.maxResults,
      opts.pageToken,
    );
  }

  /** Insert a live chat message. */
  async chatInsertMessage(opts: {
    part?: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.chatInsertMessage(
      opts.part ?? 'snippet',
      opts.body,
    );
  }

  /** Delete a chat message. */
  async chatDeleteMessage(opts: { id: string }): Promise<void> {
    return this.handle.chatDeleteMessage(opts.id);
  }

  // ---------------------------------------------------------------------------
  // Comments
  // ---------------------------------------------------------------------------

  /** List comments. */
  async commentsList(opts: {
    part?: string;
    id?: string;
    parentId?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.commentsList(opts.part, opts.id, opts.parentId);
  }

  /** List comments by multiple IDs. */
  async commentsListByIds(opts: {
    ids?: string;
    maxResults?: number;
    pageToken?: string;
    textFormat?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.commentsListByIds(
      opts.ids,
      opts.maxResults,
      opts.pageToken,
      opts.textFormat,
    );
  }

  /** List a single comment by ID. */
  async commentsListById(opts: {
    id?: string;
    textFormat?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.commentsListById(opts.id, opts.textFormat);
  }

  /** Insert a comment. */
  async commentsInsert(opts: {
    part?: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.commentsInsert(opts.part ?? 'snippet', opts.body);
  }

  /** Update a comment. */
  async commentsUpdate(opts: {
    part?: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.commentsUpdate(opts.part ?? 'snippet', opts.body);
  }

  /** Delete a comment. */
  async commentsDelete(opts: { id: string }): Promise<void> {
    return this.handle.commentsDelete(opts.id);
  }

  /** Set moderation status of a comment. */
  async commentsSetModerationStatus(opts: {
    id: string;
    moderationStatus: string;
    banAuthor?: boolean;
  }): Promise<void> {
    return this.handle.commentsSetModerationStatus(
      opts.id,
      opts.moderationStatus,
      opts.banAuthor,
    );
  }

  // ---------------------------------------------------------------------------
  // CommentThreads
  // ---------------------------------------------------------------------------

  /** List comment threads. */
  async commentThreadsList(opts: {
    part?: string;
    videoId?: string;
    channelId?: string;
    id?: string;
    maxResults?: number;
    pageToken?: string;
    order?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.commentThreadsList(
      opts.part,
      opts.videoId,
      opts.channelId,
      opts.id,
      opts.maxResults,
      opts.pageToken,
      opts.order,
    );
  }

  /** List a single comment thread by ID. */
  async commentThreadsListById(opts: {
    id?: string;
    part?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.commentThreadsListById(opts.id, opts.part);
  }

  /** Insert a comment thread. */
  async commentThreadsInsert(opts: {
    part?: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.commentThreadsInsert(
      opts.part ?? 'snippet',
      opts.body,
    );
  }

  // ---------------------------------------------------------------------------
  // Subscriptions
  // ---------------------------------------------------------------------------

  /** List subscriptions. */
  async subscriptionsList(opts: {
    part?: string;
    channelId?: string;
    mine?: boolean;
    maxResults?: number;
    pageToken?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.subscriptionsList(
      opts.part,
      opts.channelId,
      opts.mine,
      opts.maxResults,
      opts.pageToken,
    );
  }

  /** Insert a subscription. */
  async subscriptionsInsert(opts: {
    part?: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.subscriptionsInsert(
      opts.part ?? 'snippet',
      opts.body,
    );
  }

  /** Delete a subscription. */
  async subscriptionsDelete(opts: { id: string }): Promise<void> {
    return this.handle.subscriptionsDelete(opts.id);
  }

  // ---------------------------------------------------------------------------
  // PlaylistItems
  // ---------------------------------------------------------------------------

  /** List playlist items. */
  async playlistItemsList(opts: {
    part?: string;
    playlistId?: string;
    id?: string;
    maxResults?: number;
    pageToken?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.playlistItemsList(
      opts.part,
      opts.playlistId,
      opts.id,
      opts.maxResults,
      opts.pageToken,
    );
  }

  /** Insert a playlist item. */
  async playlistItemsInsert(opts: {
    part?: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.playlistItemsInsert(
      opts.part ?? 'snippet',
      opts.body,
    );
  }

  /** Update a playlist item. */
  async playlistItemsUpdate(opts: {
    part?: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.playlistItemsUpdate(
      opts.part ?? 'snippet',
      opts.body,
    );
  }

  /** Delete a playlist item. */
  async playlistItemsDelete(opts: { id: string }): Promise<void> {
    return this.handle.playlistItemsDelete(opts.id);
  }

  // ---------------------------------------------------------------------------
  // Thumbnails
  // ---------------------------------------------------------------------------

  /** Set a video thumbnail. */
  async thumbnailsSet(opts: {
    videoId: string;
    filePath: string;
  }): Promise<Record<string, any>> {
    return this.handle.thumbnailsSet(opts.videoId, opts.filePath);
  }

  // ---------------------------------------------------------------------------
  // Watermarks
  // ---------------------------------------------------------------------------

  /** Set a channel watermark. */
  async watermarksSet(opts: {
    channelId: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.watermarksSet(opts.channelId, opts.body);
  }

  /** Unset a channel watermark. */
  async watermarksUnset(opts: { channelId: string }): Promise<void> {
    return this.handle.watermarksUnset(opts.channelId);
  }

  // ---------------------------------------------------------------------------
  // VideoCategories
  // ---------------------------------------------------------------------------

  /** List video categories. */
  async videoCategoriesList(opts: {
    part?: string;
    id?: string;
    regionCode?: string;
    hl?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.videoCategoriesList(
      opts.part,
      opts.id,
      opts.regionCode,
      opts.hl,
    );
  }

  // ---------------------------------------------------------------------------
  // Members
  // ---------------------------------------------------------------------------

  /** List channel members. */
  async membersList(opts: {
    part?: string;
    mode?: string;
    maxResults?: number;
    pageToken?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.membersList(
      opts.part,
      opts.mode,
      opts.maxResults,
      opts.pageToken,
    );
  }

  // ---------------------------------------------------------------------------
  // MembershipsLevels
  // ---------------------------------------------------------------------------

  /** List memberships levels. */
  async membershipsLevelsList(opts: {
    part?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.membershipsLevelsList(opts.part);
  }

  // ---------------------------------------------------------------------------
  // VideoAbuseReportReasons
  // ---------------------------------------------------------------------------

  /** List video abuse report reasons. */
  async videoAbuseReportReasonsList(opts: {
    part?: string;
    hl?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.videoAbuseReportReasonsList(opts.part, opts.hl);
  }

  // ---------------------------------------------------------------------------
  // Analytics
  // ---------------------------------------------------------------------------

  /** Query YouTube Analytics data. */
  async analyticsQuery(opts: {
    ids: string;
    startDate: string;
    endDate: string;
    metrics: string;
    dimensions?: string;
    filters?: string;
    sort?: string;
    maxResults?: number;
    startIndex?: number;
    currency?: string;
    includeHistoricalChannelData?: boolean;
  }): Promise<Record<string, any>> {
    return this.handle.analyticsQuery(
      opts.ids,
      opts.startDate,
      opts.endDate,
      opts.metrics,
      opts.dimensions,
      opts.filters,
      opts.sort,
      opts.maxResults,
      opts.startIndex,
      opts.currency,
      opts.includeHistoricalChannelData,
    );
  }

  /** List analytics groups. */
  async analyticsGroupsList(opts: {
    id?: string;
    mine?: boolean;
    pageToken?: string;
    onBehalfOfContentOwner?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.analyticsGroupsList(
      opts.id,
      opts.mine,
      opts.pageToken,
      opts.onBehalfOfContentOwner,
    );
  }

  /** Insert an analytics group. */
  async analyticsGroupsInsert(opts: {
    body: Record<string, any>;
    onBehalfOfContentOwner?: string;
  }): Promise<Record<string, any>> {
    return this.handle.analyticsGroupsInsert(
      opts.body,
      opts.onBehalfOfContentOwner,
    );
  }

  /** Update an analytics group. */
  async analyticsGroupsUpdate(opts: {
    body: Record<string, any>;
    onBehalfOfContentOwner?: string;
  }): Promise<Record<string, any>> {
    return this.handle.analyticsGroupsUpdate(
      opts.body,
      opts.onBehalfOfContentOwner,
    );
  }

  /** Delete an analytics group. */
  async analyticsGroupsDelete(opts: {
    id: string;
    onBehalfOfContentOwner?: string;
  }): Promise<void> {
    return this.handle.analyticsGroupsDelete(
      opts.id,
      opts.onBehalfOfContentOwner,
    );
  }

  /** List analytics group items. */
  async analyticsGroupItemsList(opts: {
    groupId?: string;
    id?: string;
    pageToken?: string;
    onBehalfOfContentOwner?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.analyticsGroupItemsList(
      opts.groupId,
      opts.id,
      opts.pageToken,
      opts.onBehalfOfContentOwner,
    );
  }

  /** Insert an analytics group item. */
  async analyticsGroupItemsInsert(opts: {
    body: Record<string, any>;
    onBehalfOfContentOwner?: string;
  }): Promise<Record<string, any>> {
    return this.handle.analyticsGroupItemsInsert(
      opts.body,
      opts.onBehalfOfContentOwner,
    );
  }

  /** Delete an analytics group item. */
  async analyticsGroupItemsDelete(opts: {
    id: string;
    onBehalfOfContentOwner?: string;
  }): Promise<void> {
    return this.handle.analyticsGroupItemsDelete(
      opts.id,
      opts.onBehalfOfContentOwner,
    );
  }

  // ---------------------------------------------------------------------------
  // Activities
  // ---------------------------------------------------------------------------

  /** List activities. */
  async activitiesList(opts: {
    channelId?: string;
    mine?: boolean;
    part?: string;
    maxResults?: number;
    pageToken?: string;
    publishedAfter?: string;
    publishedBefore?: string;
    regionCode?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.activitiesList(
      opts.channelId,
      opts.mine,
      opts.part,
      opts.maxResults,
      opts.pageToken,
      opts.publishedAfter,
      opts.publishedBefore,
      opts.regionCode,
    );
  }

  // ---------------------------------------------------------------------------
  // Captions
  // ---------------------------------------------------------------------------

  /** List caption tracks for a video. */
  async captionsList(opts: {
    videoId: string;
    part?: string;
    id?: string;
  }): Promise<Record<string, any>> {
    return this.handle.captionsList(opts.videoId, opts.part, opts.id);
  }

  /** Upload a caption track. */
  async captionsInsert(opts: {
    part?: string;
    body: Record<string, any>;
    filePath: string;
  }): Promise<Record<string, any>> {
    return this.handle.captionsInsert(opts.part ?? 'snippet', opts.body, opts.filePath);
  }

  /** Update a caption track. */
  async captionsUpdate(opts: {
    part?: string;
    body: Record<string, any>;
    filePath: string;
  }): Promise<Record<string, any>> {
    return this.handle.captionsUpdate(opts.part ?? 'snippet', opts.body, opts.filePath);
  }

  /** Delete a caption track. */
  async captionsDelete(opts: { id: string }): Promise<void> {
    return this.handle.captionsDelete(opts.id);
  }

  /** Download a caption track. */
  async captionsDownload(opts: {
    id: string;
    tfmt?: string;
    tlang?: string;
  }): Promise<string> {
    return this.handle.captionsDownload(opts.id, opts.tfmt, opts.tlang);
  }

  // ---------------------------------------------------------------------------
  // ChannelBanners
  // ---------------------------------------------------------------------------

  /** Upload a channel banner image. */
  async channelBannersInsert(opts: {
    filePath: string;
  }): Promise<Record<string, any>> {
    return this.handle.channelBannersInsert(opts.filePath);
  }

  // ---------------------------------------------------------------------------
  // ChannelSections
  // ---------------------------------------------------------------------------

  /** List channel sections. */
  async channelSectionsList(opts: {
    part?: string;
    channelId?: string;
    id?: string;
    mine?: boolean;
    hl?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.channelSectionsList(
      opts.part,
      opts.channelId,
      opts.id,
      opts.mine,
      opts.hl,
    );
  }

  /** Insert a channel section. */
  async channelSectionsInsert(opts: {
    part?: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.channelSectionsInsert(
      opts.part ?? 'contentDetails,id,localizations,snippet',
      opts.body,
    );
  }

  /** Update a channel section. */
  async channelSectionsUpdate(opts: {
    part?: string;
    body: Record<string, any>;
  }): Promise<Record<string, any>> {
    return this.handle.channelSectionsUpdate(
      opts.part ?? 'contentDetails,id,localizations,snippet',
      opts.body,
    );
  }

  /** Delete a channel section. */
  async channelSectionsDelete(opts: { id: string }): Promise<void> {
    return this.handle.channelSectionsDelete(opts.id);
  }

  // ---------------------------------------------------------------------------
  // I18nLanguages
  // ---------------------------------------------------------------------------

  /** List supported application languages. */
  async i18nLanguagesList(opts: {
    part?: string;
    hl?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.i18nLanguagesList(opts.part, opts.hl);
  }

  // ---------------------------------------------------------------------------
  // I18nRegions
  // ---------------------------------------------------------------------------

  /** List supported content regions. */
  async i18nRegionsList(opts: {
    part?: string;
    hl?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.i18nRegionsList(opts.part, opts.hl);
  }

  // ---------------------------------------------------------------------------
  // PlaylistImages
  // ---------------------------------------------------------------------------

  /** List playlist images. */
  async playlistImagesList(opts: {
    parent: string;
    part?: string;
    maxResults?: number;
    pageToken?: string;
  }): Promise<Record<string, any>> {
    return this.handle.playlistImagesList(
      opts.parent,
      opts.part,
      opts.maxResults,
      opts.pageToken,
    );
  }

  /** Upload a playlist image. */
  async playlistImagesInsert(opts: {
    parent: string;
    filePath: string;
    part?: string;
  }): Promise<Record<string, any>> {
    return this.handle.playlistImagesInsert(
      opts.parent,
      opts.filePath,
      opts.part,
    );
  }

  /** Update a playlist image. */
  async playlistImagesUpdate(opts: {
    filePath: string;
    part?: string;
  }): Promise<Record<string, any>> {
    return this.handle.playlistImagesUpdate(opts.filePath, opts.part);
  }

  /** Delete a playlist image. */
  async playlistImagesDelete(opts: { id: string }): Promise<void> {
    return this.handle.playlistImagesDelete(opts.id);
  }

  // ---------------------------------------------------------------------------
  // ThirdPartyLinks
  // ---------------------------------------------------------------------------

  /** List third-party links. */
  async thirdPartyLinksList(opts: {
    part?: string;
    linkingToken?: string;
    type?: string;
    externalChannelId?: string;
  } = {}): Promise<Record<string, any>> {
    return this.handle.thirdPartyLinksList(
      opts.part,
      opts.linkingToken,
      opts.type,
      opts.externalChannelId,
    );
  }

  /** Insert a third-party link. */
  async thirdPartyLinksInsert(opts: {
    part?: string;
    body: Record<string, any>;
    externalChannelId?: string;
  }): Promise<Record<string, any>> {
    return this.handle.thirdPartyLinksInsert(
      opts.part ?? 'snippet,status',
      opts.body,
      opts.externalChannelId,
    );
  }

  /** Update a third-party link. */
  async thirdPartyLinksUpdate(opts: {
    part?: string;
    body: Record<string, any>;
    externalChannelId?: string;
  }): Promise<Record<string, any>> {
    return this.handle.thirdPartyLinksUpdate(
      opts.part ?? 'snippet,status',
      opts.body,
      opts.externalChannelId,
    );
  }

  /** Delete a third-party link. */
  async thirdPartyLinksDelete(opts: {
    linkingToken: string;
    type: string;
  }): Promise<void> {
    return this.handle.thirdPartyLinksDelete(opts.linkingToken, opts.type);
  }

  // ---------------------------------------------------------------------------
  // Close
  // ---------------------------------------------------------------------------

  /** Close the underlying HTTP client. */
  async close(): Promise<void> {
    this.handle.close();
  }
}
