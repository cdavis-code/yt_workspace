// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter

class _SearchClient implements SearchClient {
  _SearchClient(this._dio, {this.baseUrl, this.errorLogger}) {
    baseUrl ??= 'https://www.googleapis.com/youtube/v3';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<SearchListResponse> list(
    String? apiKey,
    String accept,
    String? parts, {
    String? channelId,
    String? channelType,
    String? eventType,
    bool? forContentOwner,
    bool? forDeveloper,
    bool? forMine,
    String? location,
    String? locationRadius,
    int? maxResults,
    String? onBehalfOfContentOwner,
    String? order,
    String? pageToken,
    String? publishedAfter,
    String? publishedBefore,
    String? q,
    String? regionCode,
    String? relevanceLanguage,
    String? safeSearch,
    String? topicId,
    String? type,
    String? videoCaption,
    String? videoCategoryId,
    String? videoDefinition,
    String? videoDimension,
    String? videoDuration,
    String? videoEmbeddable,
    String? videoLicense,
    String? videoSyndicated,
    String? videoType,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': apiKey,
      r'part': parts,
      r'channelId': channelId,
      r'channelType': channelType,
      r'eventType': eventType,
      r'forContentOwner': forContentOwner,
      r'forDeveloper': forDeveloper,
      r'forMine': forMine,
      r'location': location,
      r'locationRadius': locationRadius,
      r'maxResults': maxResults,
      r'onBehalfOfContentOwner': onBehalfOfContentOwner,
      r'order': order,
      r'pageToken': pageToken,
      r'publishedAfter': publishedAfter,
      r'publishedBefore': publishedBefore,
      r'q': q,
      r'regionCode': regionCode,
      r'relevanceLanguage': relevanceLanguage,
      r'safeSearch': safeSearch,
      r'topicId': topicId,
      r'type': type,
      r'videoCaption': videoCaption,
      r'videoCategoryId': videoCategoryId,
      r'videoDefinition': videoDefinition,
      r'videoDimension': videoDimension,
      r'videoDuration': videoDuration,
      r'videoEmbeddable': videoEmbeddable,
      r'videoLicense': videoLicense,
      r'videoSyndicated': videoSyndicated,
      r'videoType': videoType,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Accept': accept};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<SearchListResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/search',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late SearchListResponse _value;
    try {
      _value = SearchListResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

// dart format on
