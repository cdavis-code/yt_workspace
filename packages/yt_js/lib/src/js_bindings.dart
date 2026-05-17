/// JS-interop bindings that expose a minimal `yt` surface to JavaScript.
///
/// The TypeScript wrapper layer (src/index.ts) consumes these to provide a
/// typed, Promise-based API for YouTube Data and Live Streaming operations.
library;

import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:loggy/loggy.dart';
import 'package:universal_io/io.dart';
import 'package:yt/yt.dart';

@JS('globalThis')
external JSObject get _globalThis;

/// Installs the interop namespace on `globalThis.YtJs`.
/// Called once from the dart2js `main()`.
void install() {
  final ns = JSObject();
  ns.setProperty('withApiKey'.toJS, _withApiKey.toJS);
  ns.setProperty('withOAuth'.toJS, _withOAuth.toJS);
  ns.setProperty('version'.toJS, '2.2.6'.toJS);
  _globalThis.setProperty('YtJs'.toJS, ns);
}

/// Creates a Yt instance with an API key and returns a JS handle.
///
/// JS signature:
///   `YtJs.withApiKey(apiKey, logLevel?)`
/// Returns: `Promise<YtJsHandle>`.
JSPromise<JSObject> _withApiKey(JSString apiKey, JSString? logLevel) {
  final future = () async {
    final logOpts = _parseLogLevel(logLevel?.toDart);
    Loggy.initLoggy(
      logPrinter: const PrettyPrinter(showColors: false),
      logOptions: logOpts,
    );

    final yt = Yt.withApiKey(apiKey.toDart);
    return _wrap(yt);
  }();

  return future.toJS;
}

/// Creates a Yt instance with OAuth and returns a JS handle.
///
/// JS signature:
///   `YtJs.withOAuth(logLevel?)`
/// Returns: `Promise<YtJsHandle>`.
JSPromise<JSObject> _withOAuth(JSString? logLevel) {
  final future = () async {
    final logOpts = _parseLogLevel(logLevel?.toDart);
    Loggy.initLoggy(
      logPrinter: const PrettyPrinter(showColors: false),
      logOptions: logOpts,
    );

    final yt = Yt.withOAuth(logOptions: logOpts);
    return _wrap(yt);
  }();

  return future.toJS;
}

LogOptions _parseLogLevel(String? level) {
  switch (level) {
    case 'all':
      return const LogOptions(LogLevel.all);
    case 'debug':
      return const LogOptions(LogLevel.debug);
    case 'info':
      return const LogOptions(LogLevel.info);
    case 'warning':
      return const LogOptions(LogLevel.warning);
    case 'error':
      return const LogOptions(LogLevel.error);
    default:
      return const LogOptions(LogLevel.error, stackTraceLevel: LogLevel.off);
  }
}

/// Wraps a [Yt] instance in an opaque JS object exposing only the methods
/// the TypeScript layer needs.
JSObject _wrap(Yt yt) {
  final handle = JSObject();

  // -----------------------------------------------------------------------
  // Channels
  // -----------------------------------------------------------------------
  handle.setProperty(
    'channelsList'.toJS,
    ((
      JSString? part,
      JSString? id,
      JSString? forUsername,
      JSNumber? maxResults,
    ) {
      final future = () async {
        final response = await yt.channels.list(
          part: part?.toDart ?? 'snippet',
          id: id?.toDart,
          forUsername: forUsername?.toDart,
          maxResults: maxResults?.toDartInt ?? 5,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // Search
  // -----------------------------------------------------------------------
  handle.setProperty(
    'searchList'.toJS,
    ((JSString q, JSString? part, JSString? type, JSNumber? maxResults) {
      final future = () async {
        final response = await yt.search.list(
          q: q.toDart,
          part: part?.toDart ?? 'snippet',
          type: type?.toDart,
          maxResults: maxResults?.toDartInt ?? 5,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // Videos
  // -----------------------------------------------------------------------
  handle.setProperty(
    'videosList'.toJS,
    ((JSString? id, JSString? chart, JSString? part, JSNumber? maxResults) {
      final future = () async {
        final response = await yt.videos.list(
          id: id?.toDart,
          chart: chart?.toDart,
          part: part?.toDart ?? 'snippet',
          maxResults: maxResults?.toDartInt ?? 5,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // Playlists
  // -----------------------------------------------------------------------
  handle.setProperty(
    'playlistsList'.toJS,
    ((
      JSString? channelId,
      JSString? id,
      JSString? part,
      JSNumber? maxResults,
    ) {
      final future = () async {
        final response = await yt.playlists.list(
          channelId: channelId?.toDart,
          id: id?.toDart,
          part: part?.toDart ?? 'snippet',
          maxResults: maxResults?.toDartInt ?? 5,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // Broadcast (Live Streaming)
  // -----------------------------------------------------------------------
  handle.setProperty(
    'broadcastList'.toJS,
    ((
      JSString? part,
      JSString? broadcastStatus,
      JSString? broadcastType,
      JSString? id,
      JSNumber? maxResults,
    ) {
      final future = () async {
        final response = await yt.broadcast.list(
          part: part?.toDart ?? 'snippet',
          broadcastStatus: broadcastStatus?.toDart,
          broadcastType: broadcastType?.toDart,
          id: id?.toDart,
          maxResults: maxResults?.toDartInt,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'broadcastInsert'.toJS,
    ((JSString part, JSAny body) {
      final future = () async {
        final response = await yt.broadcast.insert(
          part: part.toDart,
          body: _jsToDartMap(body),
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'broadcastUpdate'.toJS,
    ((JSString part, JSAny body) {
      final future = () async {
        final response = await yt.broadcast.update(
          part: part.toDart,
          body: _jsToDartMap(body),
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'broadcastDelete'.toJS,
    ((JSString id) {
      final future = () async {
        await yt.broadcast.delete(id: id.toDart);
        return JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'broadcastTransition'.toJS,
    ((JSString id, JSString? broadcastStatus, JSString? part) {
      final future = () async {
        final response = await yt.broadcast.transition(
          id: id.toDart,
          broadcastStatus: broadcastStatus?.toDart,
          part: part?.toDart ?? 'snippet',
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'broadcastBind'.toJS,
    ((JSString id, JSString? part, JSString? streamId) {
      final future = () async {
        final response = await yt.broadcast.bind(
          id: id.toDart,
          part: part?.toDart ?? 'snippet',
          streamId: streamId?.toDart,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // LiveStream
  // -----------------------------------------------------------------------
  handle.setProperty(
    'streamList'.toJS,
    ((
      JSString? part,
      JSString? id,
      JSBoolean? mine,
      JSNumber? maxResults,
      JSString? pageToken,
    ) {
      final future = () async {
        final response = await yt.liveStream.list(
          part: part?.toDart ?? 'snippet',
          id: id?.toDart,
          mine: mine?.toDart,
          maxResults: maxResults?.toDartInt,
          pageToken: pageToken?.toDart,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'streamInsert'.toJS,
    ((JSString part, JSAny body) {
      final future = () async {
        final response = await yt.liveStream.insert(
          part: part.toDart,
          body: _jsToDartMap(body),
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'streamUpdate'.toJS,
    ((JSString part, JSAny body) {
      final future = () async {
        final response = await yt.liveStream.update(
          part: part.toDart,
          body: _jsToDartMap(body),
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'streamDelete'.toJS,
    ((JSString id) {
      final future = () async {
        await yt.liveStream.delete(id: id.toDart);
        return JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // Chat
  // -----------------------------------------------------------------------
  handle.setProperty(
    'chatListMessages'.toJS,
    ((
      JSString liveChatId,
      JSString? part,
      JSNumber? maxResults,
      JSString? pageToken,
    ) {
      final future = () async {
        final response = await yt.chat.list(
          liveChatId: liveChatId.toDart,
          part: part?.toDart ?? 'snippet,authorDetails',
          maxResults: maxResults?.toDartInt,
          pageToken: pageToken?.toDart,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'chatInsertMessage'.toJS,
    ((JSString part, JSAny body) {
      final future = () async {
        final response = await yt.chat.insert(
          part: part.toDart,
          body: _jsToDartMap(body),
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // Comments
  // -----------------------------------------------------------------------
  handle.setProperty(
    'commentsList'.toJS,
    ((JSString? part, JSString? id, JSString? parentId) {
      final future = () async {
        final response = await yt.comments.list(
          part: part?.toDart ?? 'snippet',
          id: id?.toDart,
          parentId: parentId?.toDart,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'commentsListByIds'.toJS,
    ((
      JSString? ids,
      JSNumber? maxResults,
      JSString? pageToken,
      JSString? textFormat,
    ) {
      final future = () async {
        final idList =
            ids?.toDart.split(',').where((s) => s.isNotEmpty).toList() ?? [];
        final response = await yt.comments.listByIds(
          ids: idList,
          maxResults: maxResults?.toDartInt,
          pageToken: pageToken?.toDart,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'commentsListById'.toJS,
    ((JSString? id, JSString? textFormat) {
      final future = () async {
        final response = await yt.comments.listById(id: id?.toDart ?? '');
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'commentsInsert'.toJS,
    ((JSString part, JSAny body) {
      final future = () async {
        final response = await yt.comments.insert(
          part: part.toDart,
          body: _jsToDartMap(body),
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'commentsUpdate'.toJS,
    ((JSString part, JSAny body) {
      final future = () async {
        final response = await yt.comments.update(
          part: part.toDart,
          body: _jsToDartMap(body),
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'commentsDelete'.toJS,
    ((JSString id) {
      final future = () async {
        await yt.comments.delete(id: id.toDart);
        return JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'commentsSetModerationStatus'.toJS,
    ((JSString id, JSString moderationStatus, JSBoolean? banAuthor) {
      final future = () async {
        final status = ModerationStatus.values.firstWhere(
          (e) => e.name == moderationStatus.toDart,
          orElse: () => ModerationStatus.published,
        );
        await yt.comments.setModerationStatus(
          id: id.toDart,
          moderationStatus: status,
          banAuthor: banAuthor?.toDart,
        );
        return JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // CommentThreads
  // -----------------------------------------------------------------------
  handle.setProperty(
    'commentThreadsList'.toJS,
    ((
      JSString? part,
      JSString? videoId,
      JSString? channelId,
      JSString? id,
      JSNumber? maxResults,
      JSString? pageToken,
      JSString? order,
    ) {
      final future = () async {
        final response = await yt.commentThreads.list(
          part: part?.toDart ?? 'snippet',
          videoId: videoId?.toDart,
          channelId: channelId?.toDart,
          id: id?.toDart,
          maxResults: maxResults?.toDartInt,
          pageToken: pageToken?.toDart,
          order: order?.toDart,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'commentThreadsListById'.toJS,
    ((JSString? id, JSString? part) {
      final future = () async {
        final response = await yt.commentThreads.listById(
          id: id?.toDart ?? '',
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'commentThreadsInsert'.toJS,
    ((JSString part, JSAny body) {
      final future = () async {
        final response = await yt.commentThreads.insert(
          part: part.toDart,
          body: _jsToDartMap(body),
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // Subscriptions
  // -----------------------------------------------------------------------
  handle.setProperty(
    'subscriptionsList'.toJS,
    ((
      JSString? part,
      JSString? channelId,
      JSBoolean? mine,
      JSNumber? maxResults,
      JSString? pageToken,
    ) {
      final future = () async {
        final response = await yt.subscriptions.list(
          part: part?.toDart ?? 'snippet',
          channelId: channelId?.toDart,
          mine: mine?.toDart,
          maxResults: maxResults?.toDartInt,
          pageToken: pageToken?.toDart,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'subscriptionsInsert'.toJS,
    ((JSString part, JSAny body) {
      final future = () async {
        final response = await yt.subscriptions.insert(
          part: part.toDart,
          body: _jsToDartMap(body),
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'subscriptionsDelete'.toJS,
    ((JSString id) {
      final future = () async {
        await yt.subscriptions.delete(id: id.toDart);
        return JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // PlaylistItems
  // -----------------------------------------------------------------------
  handle.setProperty(
    'playlistItemsList'.toJS,
    ((
      JSString? part,
      JSString? playlistId,
      JSString? id,
      JSNumber? maxResults,
      JSString? pageToken,
    ) {
      final future = () async {
        final response = await yt.playlistItems.list(
          part: part?.toDart ?? 'snippet',
          playlistId: playlistId?.toDart,
          id: id?.toDart,
          maxResults: maxResults?.toDartInt,
          pageToken: pageToken?.toDart,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'playlistItemsInsert'.toJS,
    ((JSString part, JSAny body) {
      final future = () async {
        final response = await yt.playlistItems.insert(
          part: part.toDart,
          body: _jsToDartMap(body),
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'playlistItemsUpdate'.toJS,
    ((JSString part, JSAny body) {
      final future = () async {
        final response = await yt.playlistItems.update(
          part: part.toDart,
          body: _jsToDartMap(body),
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'playlistItemsDelete'.toJS,
    ((JSString id) {
      final future = () async {
        await yt.playlistItems.delete(id: id.toDart);
        return JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // Thumbnails
  // -----------------------------------------------------------------------
  handle.setProperty(
    'thumbnailsSet'.toJS,
    ((JSString videoId, JSString filePath) {
      final future = () async {
        final response = await yt.thumbnails.set(
          videoId: videoId.toDart,
          thumbnail: File(filePath.toDart),
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // Watermarks
  // -----------------------------------------------------------------------
  handle.setProperty(
    'watermarksSet'.toJS,
    ((JSString channelId, JSAny body) {
      final future = () async {
        final map = _jsToDartMap(body);
        final resource = WatermarksResource.fromJson(map);
        final result = await yt.watermarks.set(
          channelId: channelId.toDart,
          watermarksResource: resource,
        );
        return _dartToJs({'success': result}) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'watermarksUnset'.toJS,
    ((JSString channelId) {
      final future = () async {
        await yt.watermarks.unset(channelId: channelId.toDart);
        return JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // VideoCategories
  // -----------------------------------------------------------------------
  handle.setProperty(
    'videoCategoriesList'.toJS,
    ((JSString? part, JSString? id, JSString? regionCode, JSString? hl) {
      final future = () async {
        final response = await yt.videoCategories.list(
          part: part?.toDart ?? 'snippet',
          id: id?.toDart,
          regionCode: regionCode?.toDart,
          hl: hl?.toDart,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // Members
  // -----------------------------------------------------------------------
  handle.setProperty(
    'membersList'.toJS,
    ((JSString? part, JSString? mode, JSNumber? maxResults, JSString? pageToken) {
      final future = () async {
        final response = await yt.members.list(
          part: part?.toDart ?? 'snippet',
          mode: mode?.toDart,
          maxResults: maxResults?.toDartInt,
          pageToken: pageToken?.toDart,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // MembershipsLevels
  // -----------------------------------------------------------------------
  handle.setProperty(
    'membershipsLevelsList'.toJS,
    ((JSString? part) {
      final future = () async {
        final response = await yt.membershipsLevels.list(
          part: part?.toDart ?? 'id,snippet',
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // VideoAbuseReportReasons
  // -----------------------------------------------------------------------
  handle.setProperty(
    'videoAbuseReportReasonsList'.toJS,
    ((JSString? part, JSString? hl) {
      final future = () async {
        final response = await yt.videoAbuseReportReasons.list(
          part: part?.toDart ?? 'id,snippet',
          hl: hl?.toDart,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // Analytics
  // -----------------------------------------------------------------------
  handle.setProperty(
    'analyticsQuery'.toJS,
    ((
      JSString ids,
      JSString startDate,
      JSString endDate,
      JSString metrics,
      JSString? dimensions,
      JSString? filters,
      JSString? sort,
      JSNumber? maxResults,
      JSNumber? startIndex,
      JSString? currency,
      JSBoolean? includeHistoricalChannelData,
    ) {
      final future = () async {
        final response = await yt.analytics.query(
          ids: ids.toDart,
          startDate: startDate.toDart,
          endDate: endDate.toDart,
          metrics: metrics.toDart,
          dimensions: dimensions?.toDart,
          filters: filters?.toDart,
          sort: sort?.toDart,
          maxResults: maxResults?.toDartInt,
          startIndex: startIndex?.toDartInt,
          currency: currency?.toDart,
          includeHistoricalChannelData: includeHistoricalChannelData?.toDart,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'analyticsGroupsList'.toJS,
    ((
      JSString? id,
      JSBoolean? mine,
      JSString? pageToken,
      JSString? onBehalfOfContentOwner,
    ) {
      final future = () async {
        final response = await yt.analytics.groupsList(
          id: id?.toDart,
          mine: mine?.toDart,
          pageToken: pageToken?.toDart,
          onBehalfOfContentOwner: onBehalfOfContentOwner?.toDart,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'analyticsGroupsInsert'.toJS,
    ((JSAny body, JSString? onBehalfOfContentOwner) {
      final future = () async {
        final response = await yt.analytics.groupsInsert(
          body: _jsToDartMap(body),
          onBehalfOfContentOwner: onBehalfOfContentOwner?.toDart,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'analyticsGroupsUpdate'.toJS,
    ((JSAny body, JSString? onBehalfOfContentOwner) {
      final future = () async {
        final response = await yt.analytics.groupsUpdate(
          body: _jsToDartMap(body),
          onBehalfOfContentOwner: onBehalfOfContentOwner?.toDart,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'analyticsGroupsDelete'.toJS,
    ((JSString id, JSString? onBehalfOfContentOwner) {
      final future = () async {
        await yt.analytics.groupsDelete(
          id: id.toDart,
          onBehalfOfContentOwner: onBehalfOfContentOwner?.toDart,
        );
        return JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'analyticsGroupItemsList'.toJS,
    ((
      JSString? groupId,
      JSString? id,
      JSString? pageToken,
      JSString? onBehalfOfContentOwner,
    ) {
      final future = () async {
        final response = await yt.analytics.groupItemsList(
          groupId: groupId?.toDart,
          id: id?.toDart,
          pageToken: pageToken?.toDart,
          onBehalfOfContentOwner: onBehalfOfContentOwner?.toDart,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'analyticsGroupItemsInsert'.toJS,
    ((JSAny body, JSString? onBehalfOfContentOwner) {
      final future = () async {
        final response = await yt.analytics.groupItemsInsert(
          body: _jsToDartMap(body),
          onBehalfOfContentOwner: onBehalfOfContentOwner?.toDart,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  handle.setProperty(
    'analyticsGroupItemsDelete'.toJS,
    ((JSString id, JSString? onBehalfOfContentOwner) {
      final future = () async {
        await yt.analytics.groupItemsDelete(
          id: id.toDart,
          onBehalfOfContentOwner: onBehalfOfContentOwner?.toDart,
        );
        return JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // Activities
  // -----------------------------------------------------------------------
  handle.setProperty(
    'activitiesList'.toJS,
    ((
      JSString? channelId,
      JSBoolean? mine,
      JSString? part,
      JSNumber? maxResults,
      JSString? pageToken,
      JSString? publishedAfter,
      JSString? publishedBefore,
      JSString? regionCode,
    ) {
      final future = () async {
        final response = await yt.activities.list(
          channelId: channelId?.toDart,
          mine: mine?.toDart,
          part: part?.toDart ?? 'snippet,contentDetails',
          maxResults: maxResults?.toDartInt,
          pageToken: pageToken?.toDart,
          publishedAfter: publishedAfter?.toDart,
          publishedBefore: publishedBefore?.toDart,
          regionCode: regionCode?.toDart,
        );
        return _dartToJs(response.toJson()) ?? JSObject();
      }();
      return future.toJS;
    }).toJS,
  );

  // -----------------------------------------------------------------------
  // Close
  // -----------------------------------------------------------------------
  handle.setProperty(
    'close'.toJS,
    (() {
      yt.close();
      return JSObject();
    }).toJS,
  );

  return handle;
}

// -------------------------------------------------------------------------
// JSON <-> JS value conversion (round-trip via JSON for fidelity)
// -------------------------------------------------------------------------

JSObject get _json => _globalThis.getProperty<JSObject>('JSON'.toJS);

/// Converts a plain Dart value (from `dart:convert` JSON) to a JS value.
JSAny? _dartToJs(Object? value) {
  if (value == null) return null;
  final encoded = jsonEncode(value);
  return _json.callMethod<JSAny?>('parse'.toJS, encoded.toJS);
}

/// Converts a JS value to a Dart `Map<String, dynamic>` via JSON round-trip.
Map<String, dynamic> _jsToDartMap(JSAny body) {
  final encoded = _json.callMethod<JSString>('stringify'.toJS, body);
  return jsonDecode(encoded.toDart) as Map<String, dynamic>;
}
