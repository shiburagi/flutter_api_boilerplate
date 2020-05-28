import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:fluter_api_boilerplate/api/interceptor/app.dart';
import 'package:flutter/foundation.dart';


abstract class BaseApi {
  BaseApi._(); // disable constructor

  static Dio _dio = initDio();
  static Dio initDio() {
    return Dio()
      ..interceptors.addAll([
        AppInterceptors(),
        LogInterceptor(
            responseBody: kDebugMode,
            requestBody: kDebugMode,
            logPrint: (s) => log(s, name: "DIO")),
      ]);
  }

  Dio get dio {
    return _dio;
  }

  /*
   * Set Base URL
   * Example : http://rest.api/
   */
  static setBaseUrl(url) {
    _dio = initDio();
    _dio.options.baseUrl = url;
    _dio.interceptors
        .add(DioCacheManager(CacheConfig(baseUrl: url)).interceptor);
  }

  get path;
}
