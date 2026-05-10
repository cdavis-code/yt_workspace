import 'package:args/command_runner.dart';
import 'package:universal_io/io.dart';
import 'package:yt/yt.dart';

abstract class YtHelperCommand extends Command<void> {
  late final Yt _yt;

  Broadcast get broadcast => _yt.broadcast;

  Chat get chat => _yt.chat;

  LiveStream get liveStream => _yt.liveStream;

  Channels get channels => _yt.channels;

  Comments get comments => _yt.comments;

  CommentThreads get commentThreads => _yt.commentThreads;

  Playlists get playlists => _yt.playlists;

  Search get search => _yt.search;

  Subscriptions get subscriptions => _yt.subscriptions;

  Thumbnails get thumbnails => _yt.thumbnails;

  Videos get videos => _yt.videos;

  VideoCategories get videoCategories => _yt.videoCategories;

  Watermarks get watermarks => _yt.watermarks;

  Members get members => _yt.members;

  MembershipsLevels get membershipsLevels => _yt.membershipsLevels;

  VideoAbuseReportReasons get videoAbuseReportReasons =>
      _yt.videoAbuseReportReasons;

  Future<void> initializeYt() async {
    _yt = Yt.withOAuth(
      logOptions: Util.convertToLogOptions(globalResults!['log-level']),
    );
  }

  void close() {
    _yt.close();

    exit(0);
  }
}
