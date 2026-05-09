import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'members.g.dart';

@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class MembersClient {
  factory MembersClient(Dio dio, {String baseUrl}) = _MembersClient;

  @GET('/members')
  Future<MemberListResponse> list(
    @Header('Accept') String accept,
    @Query('part') String part, {
    @Query('mode') String? mode,
    @Query('maxResults') int? maxResults,
    @Query('pageToken') String? pageToken,
  });
}