import 'package:yt/yt.dart';

void main() async {
  final yt = Yt.withOAuth(
      oAuthClientId:
          OAuthCredentials.fromYaml('credentials.yaml').oAuthClientId);

  final searchListResponse = await yt.search
      .list(q: 'reddit', part: 'snippet', type: 'video'); //the Flutter channel

  print('\nSearch:');
  for (SearchResult searchResult in searchListResponse.items) {
    print('''title: ${searchResult.snippet?.title}, 
thumbnail: ${searchResult.snippet?.thumbnails.thumbnailsDefault.url}
channel title: ${searchResult.snippet?.channelTitle}''');
  }

  print('Playlist: [a playlist id]');
  final playlistResponse = await yt.playlists.list(id: '[a playlist id]');

  for (Playlist playlist in playlistResponse.items) {
    print('''title: ${playlist.snippet?.title},
thumbnail: ${playlist.snippet?.thumbnails.thumbnailsDefault.url}''');
  }

  final channelsResponse = await yt.channels.list(
      id: '[a channel id]',
      part: 'snippet,contentDetails'); //the Flutter channel

  print('\nChannel: [a channel id]');
  for (ChannelItem channelItem in channelsResponse.items) {
    print('''title: ${channelItem.snippet?.title},
thumbnail: ${channelItem.snippet?.thumbnails?.thumbnailsDefault.url}
relatedPlaylists: ${channelItem.contentDetails?.relatedPlaylists.uploads}''');
  }

  final liveBroadcastResponse = await yt.broadcast.list(
      mine: true, part: 'snippet,contentDetails,status'); //the Flutter channel

  print('\nBroadcasts:');
  for (LiveBroadcastItem broadcastItem in liveBroadcastResponse.items) {
    print('''title: ${broadcastItem.snippet?.title},
thumbnail: ${broadcastItem.snippet?.thumbnails?.thumbnailsDefault.url}
status: ${broadcastItem.status?.lifeCycleStatus}''');
  }
}
