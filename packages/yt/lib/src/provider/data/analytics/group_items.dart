import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'group_items.g.dart';

@RestApi(baseUrl: 'https://youtubeanalytics.googleapis.com/v2')
abstract class GroupItemsClient {
  factory GroupItemsClient(Dio dio, {String baseUrl}) = _GroupItemsClient;

  @GET('/groupItems')
  Future<AnalyticsGroupItemListResponse> list(
    @Header('Accept') String accept, {
    @Query('groupId') String? groupId,
    @Query('id') String? id,
    @Query('pageToken') String? pageToken,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });

  @POST('/groupItems')
  Future<AnalyticsGroupItem> insert(
    @Header('Accept') String accept,
    @Header('Content-Type') String contentType,
    @Body() Map<String, dynamic> body, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });

  @DELETE('/groupItems')
  Future<void> delete(
    @Header('Accept') String accept,
    @Query('id') String id, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });
}
