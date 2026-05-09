import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'memberships_levels.g.dart';

@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class MembershipsLevelsClient {
  factory MembershipsLevelsClient(Dio dio, {String baseUrl}) =
      _MembershipsLevelsClient;

  @GET('/membershipsLevels')
  Future<MembershipsLevelListResponse> list(
    @Header('Accept') String accept,
    @Query('part') String part,
  );
}