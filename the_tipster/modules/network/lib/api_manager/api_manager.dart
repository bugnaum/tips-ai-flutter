import 'dart:convert';
import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../common/api_call_response.dart';

export '../common/api_call_response.dart';
export 'api_manager.dart';

enum ApiCallType {
  get,
  post,
  delete,
  put,
  patch,
}

enum BodyType {
  none,
  json,
  text,
  x_www_form_url_encoded,
}

class ApiCallRecord extends Equatable {
  const ApiCallRecord(this.callName, this.apiUrl, this.headers, this.params,
      this.body, this.bodyType);
  final String callName;
  final String apiUrl;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> params;
  final String? body;
  final BodyType? bodyType;

  @override
  List<Object?> get props =>
      [callName, apiUrl, headers, params, body, bodyType];
}

class ApiManager {
  ApiManager._();
  static final Map<ApiCallRecord, ApiCallResponse> _apiCache = {};

  static ApiManager? _instance;
  static ApiManager get instance => _instance ??= ApiManager._();

  static void clearCache(String callName) => _apiCache.keys
      .toSet()
      .forEach((k) => k.callName == callName ? _apiCache.remove(k) : null);

  static Map<String, String> toStringMap(Map map) =>
      map.map((key, value) => MapEntry(key.toString(), value.toString()));

  static String asqueryParameters(Map<String, dynamic> map) =>
      map.entries.map((e) => "${e.key}=${e.value}").join('&');

  static Future<ApiCallResponse> urlRequest(
    ApiCallType callType,
    String apiUrl,
    Map<String, dynamic> headers,
    Map<String, dynamic> params,
    bool returnBody,
    bool decodeUtf8,
  ) async {
    if (params.isNotEmpty) {
      final lastUriPart = apiUrl.split('/').last;
      final needsParamSpecifier = !lastUriPart.contains('?');
      apiUrl =
          '$apiUrl${needsParamSpecifier ? '?' : ''}${asqueryParameters(params)}';
    }
    final makeRequest = callType == ApiCallType.get ? http.get : http.delete;
    final response =
        await makeRequest(Uri.parse(apiUrl), headers: toStringMap(headers))
            .timeout(const Duration(seconds: 60));
    return ApiCallResponse.fromHttpResponse(response, returnBody, decodeUtf8);
  }

  static Future<ApiCallResponse> requestWithBody(
    ApiCallType type,
    String apiUrl,
    Map<String, dynamic> headers,
    Map<String, dynamic> params,
    String? body,
    BodyType? bodyType,
    bool returnBody,
    bool encodeBodyUtf8,
    bool decodeUtf8,
  ) async {
    assert(
      {
        ApiCallType.post,
        ApiCallType.put,
        ApiCallType.patch,
      }.contains(type),
      'Invalid ApiCallType $type for request with body',
    );
    final postBody =
        createBody(headers, params, body, bodyType, encodeBodyUtf8);

    final requestFn = {
      ApiCallType.post: http.post,
      ApiCallType.put: http.put,
      ApiCallType.patch: http.patch,
    }[type]!;
    final response = await requestFn(Uri.parse(apiUrl),
        headers: toStringMap(headers), body: postBody);
    return ApiCallResponse.fromHttpResponse(response, returnBody, decodeUtf8);
  }

  static dynamic createBody(
    Map<String, dynamic> headers,
    Map<String, dynamic>? params,
    String? body,
    BodyType? bodyType,
    bool encodeBodyUtf8,
  ) {
    String? contentType;
    dynamic postBody;
    switch (bodyType) {
      case BodyType.json:
        contentType = 'application/json';
        postBody = body ?? json.encode(params ?? {});
        break;
      case BodyType.text:
        contentType = 'text/plain';
        postBody = body ?? json.encode(params ?? {});
        break;
      case BodyType.x_www_form_url_encoded:
        contentType = 'application/x-www-form-urlencoded';
        postBody = toStringMap(params ?? {});
        break;
      case BodyType.none:
      case null:
        break;
    }
    if (contentType != null &&
        !headers.keys.any((h) => h.toLowerCase() == 'content-type')) {
      headers['Content-Type'] = contentType;
    }
    return encodeBodyUtf8 && postBody is String
        ? utf8.encode(postBody)
        : postBody;
  }

  Future<ApiCallResponse> makeApiCall({
    required String callName,
    required String apiUrl,
    required ApiCallType callType,
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> params = const {},
    String? body,
    BodyType? bodyType,
    bool returnBody = true,
    bool encodeBodyUtf8 = false,
    bool decodeUtf8 = false,
    bool cache = false,
  }) async {
    final callRecord =
        ApiCallRecord(callName, apiUrl, headers, params, body, bodyType);

    ApiCallResponse? result;
    for (var retry = 0; retry < 3; retry++) {
      if (!apiUrl.startsWith('http')) {
        apiUrl = 'https://$apiUrl';
      }

      if (cache && _apiCache.containsKey(callRecord)) {
        return _apiCache[callRecord]!;
      }

      switch (callType) {
        case ApiCallType.get:
        case ApiCallType.delete:
          result = await urlRequest(
            callType,
            apiUrl,
            headers,
            params,
            returnBody,
            decodeUtf8,
          );
          break;
        case ApiCallType.post:
        case ApiCallType.put:
        case ApiCallType.patch:
          result = await requestWithBody(
            callType,
            apiUrl,
            headers,
            params,
            body,
            bodyType,
            returnBody,
            encodeBodyUtf8,
            decodeUtf8,
          );
          break;
      }

      if (result.statusCode >= 200 && result.statusCode < 300) {
        if (cache) {
          _apiCache[callRecord] = result;
        }
        return result;
      }
      return result;
    }

    return const ApiCallResponse(null, {}, 500);
  }
}
