import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'groups.g.dart';

@RestApi(baseUrl: 'https://youtubeanalytics.googleapis.com/v2')
abstract class GroupsClient {
  factory GroupsClient(Dio dio, {String baseUrl}) = _GroupsClient;

  @GET('/groups')
  Future<AnalyticsGroupListResponse> list(
    @Header('Accept') String accept, {
    @Query('id') String? id,
    @Query('mine') bool? mine,
    @Query('pageToken') String? pageToken,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });

  @POST('/groups')
  Future<AnalyticsGroup> insert(
    @Header('Accept') String accept,
    @Header('Content-Type') String contentType,
    @Body() Map<String, dynamic> body, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });

  @PUT('/groups')
  Future<AnalyticsGroup> update(
    @Header('Accept') String accept,
    @Header('Content-Type') String contentType,
    @Body() Map<String, dynamic> body, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });

  @DELETE('/groups')
  Future<void> delete(
    @Header('Accept') String accept,
    @Query('id') String id, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });
}
