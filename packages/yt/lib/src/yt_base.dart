import 'package:dio/dio.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

import 'package:loggy/loggy.dart';
import 'package:yt/oauth.dart';

import 'package:yt/yt.dart';

class Yt with UiLoggy {
  static final dio = Dio();
  static final tokenExpiry = DateTime(2000, 0, 0);
  static final _interceptors = <Interceptor>[];

  static RefreshTokenGenerator? refreshTokenGenerator;

  static final String _moduleUnavailableMessage =
      'This feature is not available when using API Key authentication';

  Broadcast? _broadcast;
  Channels? _channels;
  Comments? _comments;
  CommentThreads? _commentThreads;
  LiveStream? _liveStream;
  Playlists? _playlists;
  PlaylistItems? _playlistItems;
  Search? _search;
  Subscriptions? _subscriptions;
  Thumbnails? _thumbnails;
  Videos? _videos;
  VideoCategories? _videoCategories;
  Watermarks? _watermarks;
  Chat? _chat;
  Members? _members;
  MembershipsLevels? _membershipsLevels;
  VideoAbuseReportReasons? _videoAbuseReportReasons;
  Analytics? _analytics;
  Activities? _activities;

  Broadcast get broadcast => _broadcast == null
      ? throw Exception(_moduleUnavailableMessage)
      : _broadcast!;

  Channels get channels => _channels!;

  Comments get comments => _comments!;

  CommentThreads get commentThreads => _commentThreads!;

  LiveStream get liveStream => _liveStream == null
      ? throw Exception(_moduleUnavailableMessage)
      : _liveStream!;

  Playlists get playlists => _playlists!;

  PlaylistItems get playlistItems => _playlistItems!;

  Search get search => _search!;

  Subscriptions get subscriptions => _subscriptions == null
      ? throw Exception(_moduleUnavailableMessage)
      : _subscriptions!;

  Thumbnails get thumbnails => _thumbnails == null
      ? throw Exception(_moduleUnavailableMessage)
      : _thumbnails!;

  Videos get videos =>
      _videos == null ? throw Exception(_moduleUnavailableMessage) : _videos!;

  VideoCategories get videoCategories => _videoCategories == null
      ? throw Exception(_moduleUnavailableMessage)
      : _videoCategories!;

  Watermarks get watermarks => _watermarks == null
      ? throw Exception(_moduleUnavailableMessage)
      : _watermarks!;

  Chat get chat =>
      _chat == null ? throw Exception(_moduleUnavailableMessage) : _chat!;

  Members get members =>
      _members == null ? throw Exception(_moduleUnavailableMessage) : _members!;

  MembershipsLevels get membershipsLevels => _membershipsLevels == null
      ? throw Exception(_moduleUnavailableMessage)
      : _membershipsLevels!;

  VideoAbuseReportReasons get videoAbuseReportReasons =>
      _videoAbuseReportReasons == null
      ? throw Exception(_moduleUnavailableMessage)
      : _videoAbuseReportReasons!;

  Analytics get analytics => _analytics == null
      ? throw Exception(_moduleUnavailableMessage)
      : _analytics!;

  Activities get activities => _activities!;

  Yt({
    LogOptions logOptions = const LogOptions(
      LogLevel.error,
      stackTraceLevel: LogLevel.off,
    ),
    LoggyPrinter printer = const PrettyPrinter(showColors: false),
  }) {
    Loggy.initLoggy(logPrinter: printer, logOptions: logOptions);

    addInterceptor(LoggingInterceptors(), position: ListPosition.end);
  }

  static Yt withApiKey({
    String? apiKey,
    Map<String, String>? additionalHeaders,
  }) {
    final resolvedKey = apiKey ?? CredentialsPath.resolveValue(Util.envYtApiKey);

    if (resolvedKey == null || resolvedKey.isEmpty) {
      throw ArgumentError(
        'No API key provided. Pass it directly or set the '
        '${Util.envYtApiKey} environment variable (or add it to a .env file).',
      );
    }

    final yt = Yt();

    yt.setModules(apiKey: resolvedKey);

    if (additionalHeaders != null) {
      dio.options.headers.addAll(additionalHeaders);
    }

    dio.interceptors.addAll(_interceptors);

    return yt;
  }

  @Deprecated('Use withApiKey instead')
  static Yt withKey(String apiKey, {Map<String, String>? additionalHeaders}) =>
      withApiKey(apiKey: apiKey, additionalHeaders: additionalHeaders);

  static Yt withOAuth({
    ClientId? oAuthClientId,
    LogOptions logOptions = const LogOptions(
      LogLevel.error,
      stackTraceLevel: LogLevel.off,
    ),
  }) {
    final yt = Yt(
      logOptions: logOptions,
      printer: const PrettyPrinter(showColors: false),
    );

    addInterceptor(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final oauthAccessControl = OAuthAccessControl(oAuthClientId);

          await oauthAccessControl.checkAccessToken();

          options.headers['Authorization'] =
              'Bearer ${oauthAccessControl.token}';

          return handler.next(options);
        },
      ),
    );

    yt.setModules(useTokenAuth: true);

    dio.interceptors.addAll(_interceptors);

    return yt;
  }

  static Future<Yt> withGenerator(
    RefreshTokenGenerator refreshTokenGenerator, {
    LogOptions logOptions = const LogOptions(
      LogLevel.error,
      stackTraceLevel: LogLevel.off,
    ),
  }) async {
    final yt = Yt(logOptions: logOptions);

    Token token = await refreshTokenGenerator.generate();

    addInterceptor(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Authorization'] = 'Bearer ${token.accessToken}';

          return handler.next(options);
        },
      ),
    );

    yt.setModules(useTokenAuth: true);

    dio.interceptors.addAll(_interceptors);

    return yt;
  }

  static void addInterceptor(
    Interceptor interceptor, {
    ListPosition position = ListPosition.start,
  }) {
    switch (position) {
      case ListPosition.start:
        _interceptors.insert(0, interceptor);

        break;
      case ListPosition.end:
        _interceptors.add(interceptor);

        break;
    }
  }

  void setModules({bool? useTokenAuth, String? apiKey}) {
    if (useTokenAuth != null && useTokenAuth) {
      /// A liveBroadcast resource represents an event that will be streamed, via live video, on YouTube.
      _broadcast = Broadcast(dio: dio);

      ///A liveStream resource contains information about the video stream that you are transmitting to YouTube. The stream provides the content that will be broadcast to YouTube users. Once created, a [LiveStreamItem] resource can be bound to one or more [LiveBroadcastItem] resources.
      _liveStream = LiveStream(dio: dio);

      /// A subscription resource contains information about a YouTube user subscription. A subscription notifies a user when new videos are added to a channel or when another user takes one of several actions on YouTube, such as uploading a video, rating a video, or commenting on a video.
      _subscriptions = Subscriptions(dio: dio);

      /// A [Thumbnail] resource identifies different thumbnail image sizes associated with a resource. Please note the following characteristics of thumbnail images:
      ///
      /// - A resource's Snippet.thumbnails property is an object that identifies the thumbnail images available for that resource.
      /// - A thumbnail resource contains a series of objects. The name of each object (default, medium, high, etc.) refers to the thumbnail image size.
      /// - Different types of resources may support different thumbnail image sizes.
      /// - Different types of resources may define different sizes for thumbnail images with the same name. For example, the default thumbnail image for a video resource is typically 120px by 90px, and the default thumbnail image for a channel resource is typically 88px by 88px.
      /// - Resources of the same type may still have different thumbnail image sizes for certain images depending on the resolution of the original image or content uploaded to YouTube. For example, an HD video may support higher resolution thumbnails than non-HD videos.
      /// - Each object that contains information about a thumbnail image size has a width property and a height property. However, the width and height properties may not be returned for that image.
      /// - If an uploaded thumbnail image does not match the required dimensions, the image is resized to match the correct size without changing its aspect ratio. The image is not cropped, but may include black bars so that the size is correct.
      _thumbnails = Thumbnails(dio: dio);

      /// A video resource represents a YouTube video.
      _videos = Videos(dio: dio);

      /// A videoCategory resource identifies a category that has been or could be associated with uploaded videos.
      _videoCategories = VideoCategories(dio: dio);

      /// A [Watermark] resource identifies an image that displays during playbacks of
      /// a specified channel's videos. You can also specify a target channel to which
      /// the image will link as well as timing details that determine when the
      /// watermark appears during video playbacks and the length of time it is
      /// visible.
      _watermarks = Watermarks(dio: dio);

      /// A liveChatMessage resource represents a chat message in a YouTube live chat.
      _chat = Chat(dio: dio);

      /// A member resource represents a YouTube channel member who provides recurring
      /// monetary support to a creator and receives special benefits.
      _members = Members(dio: dio);

      /// A membershipsLevel resource identifies a pricing level managed by the creator.
      _membershipsLevels = MembershipsLevels(dio: dio);

      /// A videoAbuseReportReason resource contains information about a reason
      /// that a video would be flagged for containing abusive content.
      _videoAbuseReportReasons = VideoAbuseReportReasons(dio: dio);

      /// An analytics resource provides access to YouTube Analytics reports,
      /// groups, and group items.
      _analytics = Analytics(dio: dio);
    }

    /// A channel resource contains information about a YouTube channel.
    _channels = Channels(apiKey: apiKey, dio: dio);

    /// A comment resource contains information about a single YouTube comment. A comment resource can represent a comment about either a video or a channel. In addition, the comment could be a top-level comment or a reply to a top-level comment.
    _comments = Comments(apiKey: apiKey, dio: dio);

    /// A commentThread resource contains information about a YouTube comment thread, which comprises a top-level comment and replies, if any exist, to that comment. A commentThread resource can represent comments about either a video or a channel.
    _commentThreads = CommentThreads(apiKey: apiKey, dio: dio);

    /// A playlist resource represents a YouTube playlist. A playlist is a collection of videos that can be viewed sequentially and shared with other users. By default, playlists are publicly visible to other users, but playlists can be public or private.
    ///
    /// YouTube also uses playlists to identify special collections of videos for a channel, such as:
    ///
    /// - uploaded videos
    /// - positively rated (liked) videos
    /// To be more specific, these lists are associated with a channel, which is a collection of a person, group, or company's videos, playlists, and other YouTube information. You can retrieve the playlist IDs for each of these lists from the channel resource for a given channel.
    ///
    /// You can then use the playlistItems.list method to retrieve any of those lists. You can also add or remove items from those lists by calling the playlistItems.insert and playlistItems.delete methods.
    _playlists = Playlists(apiKey: apiKey, dio: dio);

    /// A playlistItem resource identifies another resource, such as a video, that is included in a playlist. In addition, the playlistItem resource contains details about the included resource that pertain specifically to how that resource is used in that playlist.
    ///
    /// YouTube also uses a playlist to identify a channel's list of uploaded videos, with each playlistItem in that list representing one uploaded video. You can retrieve the playlist ID for that list from the channel resource for a given channel. You can then use the playlistItems.list method to the list.
    _playlistItems = PlaylistItems(apiKey: apiKey, dio: dio);

    /// A search result contains information about a YouTube video, channel, or playlist that matches the search parameters specified in an API request. While a search result points to a uniquely identifiable resource, like a video, it does not have its own persistent data.
    _search = Search(apiKey: apiKey, dio: dio);

    /// An activity resource contains information about an action that a particular
    /// channel, or user, has taken on YouTube.
    _activities = Activities(apiKey: apiKey, dio: dio);
  }

  void close() => dio.close();
}
