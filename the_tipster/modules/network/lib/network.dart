library golador_network;

import 'dart:convert';

import 'package:flutter/foundation.dart';

export 'api_manager/api_manager.dart';
export 'common/api_call_response.dart';
export 'common/loader_state.dart';
export 'common/requestable.dart';
export 'network.dart';

class Environment {
  static String get baseUrl {
    return kDebugMode
        ? 'https://beta-golador-news.azurewebsites.net'
        : 'https://beta-golador-news.azurewebsites.net';
  }

  static String get apiKey {
    return kDebugMode ? "" : "";
  }
}

class NetworkParams {
  static final NetworkParams _singleton = NetworkParams._internal();

  factory NetworkParams() {
    return _singleton;
  }

  NetworkParams._internal();
  String? bearerToken;
}

class Network {
  static String get baseUrl => Environment.baseUrl;

  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': '*/*',
    'locale': 'PT',
    'Authorization': 'Bearer ${NetworkParams().bearerToken}' ?? ''
  };

  static Map<String, String> noAuthHeaders = {
    'Content-Type': 'application/json',
    'Accept': '*/*',
    'locale': 'PT',
    'X-Authorization-ClientKey': Environment.apiKey,
  };
}

String serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
