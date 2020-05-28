import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:fluter_api_boilerplate/helper/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:synchronized/extension.dart';

JsonEncoder encoder = new JsonEncoder.withIndent('  ');

class AppInterceptors extends Interceptor {
  bool disableCache(RequestOptions options) {
    // blacklist cache for certain path
    return false;
  }

  showNoNetworkMessage() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        // handle no internet here
      } else {}
    } catch (e) {}
    return null;
  }

  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    synchronized(() => showNoNetworkMessage());

    options.headers.addAll({
      "HEADER_KEY": "HEADER_VALUE",
    });
    if (disableCache(options)) return options;
    return buildCacheOptions(
      Duration(days: 7), // how long to cache the
      options: options,
      forceRefresh: true,
    );
  }

  @override
  Future<dynamic> onError(DioError dioError) async {
    // handle unauthorized user or expired token.
    if (dioError.response != null && dioError.response.statusCode == 401) {
      NavigatorHelper.navigatorKey.currentState
          .pushNamedAndRemoveUntil("/", (Route<dynamic> route) => false);
    }

    return dioError;
  }

  @override
  Future<dynamic> onResponse(Response options) async {
    if (!options.request.path.contains("token") && options.statusCode == 200) {
      // store token
    }

    return options;
  }
}
