import 'package:yt/src/youtube_api_helper.dart';

import 'provider/data/analytics/reports.dart';
import 'provider/data/analytics/groups.dart';
import 'provider/data/analytics/group_items.dart';
import 'model/analytics/analytics_report.dart';
import 'model/analytics/analytics_group.dart';
import 'model/analytics/analytics_group_list_response.dart';
import 'model/analytics/analytics_group_item.dart';
import 'model/analytics/analytics_group_item_list_response.dart';

class Analytics extends YouTubeApiHelper {
  final ReportsClient _reportsClient;
  final GroupsClient _groupsClient;
  final GroupItemsClient _groupItemsClient;

  Analytics({required super.dio})
    : _reportsClient = ReportsClient(dio),
      _groupsClient = GroupsClient(dio),
      _groupItemsClient = GroupItemsClient(dio),
      super(apiKey: null);

  // -- Reports --

  Future<AnalyticsReport> query({
    required String ids,
    required String startDate,
    required String endDate,
    required String metrics,
    String? dimensions,
    String? filters,
    int? maxResults,
    String? sort,
    int? startIndex,
    String? currency,
    bool? includeHistoricalChannelData,
  }) async {
    return _reportsClient.query(
      accept,
      ids,
      startDate,
      endDate,
      metrics,
      dimensions: dimensions,
      filters: filters,
      maxResults: maxResults,
      sort: sort,
      startIndex: startIndex,
      currency: currency,
      includeHistoricalChannelData: includeHistoricalChannelData,
    );
  }

  // -- Groups --

  Future<AnalyticsGroupListResponse> groupsList({
    String? id,
    bool? mine,
    String? pageToken,
    String? onBehalfOfContentOwner,
  }) async {
    return _groupsClient.list(
      accept,
      id: id,
      mine: mine,
      pageToken: pageToken,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
  }

  Future<AnalyticsGroup> groupsInsert({
    required Map<String, dynamic> body,
    String? onBehalfOfContentOwner,
  }) async {
    return _groupsClient.insert(
      accept,
      contentType,
      body,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
  }

  Future<AnalyticsGroup> groupsUpdate({
    required Map<String, dynamic> body,
    String? onBehalfOfContentOwner,
  }) async {
    return _groupsClient.update(
      accept,
      contentType,
      body,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
  }

  Future<void> groupsDelete({
    required String id,
    String? onBehalfOfContentOwner,
  }) async {
    await _groupsClient.delete(
      accept,
      id,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
  }

  // -- Group Items --

  Future<AnalyticsGroupItemListResponse> groupItemsList({
    String? groupId,
    String? id,
    String? pageToken,
    String? onBehalfOfContentOwner,
  }) async {
    return _groupItemsClient.list(
      accept,
      groupId: groupId,
      id: id,
      pageToken: pageToken,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
  }

  Future<AnalyticsGroupItem> groupItemsInsert({
    required Map<String, dynamic> body,
    String? onBehalfOfContentOwner,
  }) async {
    return _groupItemsClient.insert(
      accept,
      contentType,
      body,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
  }

  Future<void> groupItemsDelete({
    required String id,
    String? onBehalfOfContentOwner,
  }) async {
    await _groupItemsClient.delete(
      accept,
      id,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
  }
}
