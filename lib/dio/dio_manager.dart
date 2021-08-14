import 'dart:async';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_simple_framework/dio/dio_intercept.dart';

import 'dio_result.dart';
import 'intercept/dio_log_interceptors.dart';
import 'intercept/dio_request_interceptors.dart';

const kContentTypeUrlencoded =
    'application/x-www-form-urlencoded; charset=utf-8';
const kContentTypeJson = 'application/json; charset=utf-8';
const kContentTypeHtml = 'text/html; charset=utf-8';

class DioManager {
  late Dio _dioInstance;
  DioIntercept? intercept;

  ///初始化
  DioManager.init(
      {String baseUrl = '',
      String? proxy,
      String contentType = kContentTypeJson,
      DioIntercept? intercept}) {
    this.intercept = intercept;
    _dioInstance = new Dio(BaseOptions(
      baseUrl: baseUrl,
      contentType: contentType,
      // sendTimeout: 60 * 1000,
      // connectTimeout: 60 * 1000,
      // receiveTimeout: 60 * 1000,
    ));
    _dioInstance.interceptors.add(RequestInterceptors(intercept: intercept));
    _dioInstance.interceptors.add(DioLogInterceptors());

    if (!kReleaseMode && proxy != null) {
      (_dioInstance.httpClientAdapter as DefaultHttpClientAdapter)
          .onHttpClientCreate = (HttpClient client) {
        client.findProxy = (uri) {
          return "PROXY $proxy";
        };
      };
    }
  }

  ///get 请求
  Future<DioResult> get(String path,
      {Map<String, dynamic>? queryParameters, CancelToken? cancelToken}) {
    return _handleResquest(_dioInstance.get(path,
        queryParameters: queryParameters, cancelToken: cancelToken));
  }

  ///post 请求
  Future<DioResult> post(String path,
      {Map<String, dynamic>? data, CancelToken? cancelToken}) {
    return _handleResquest(
        _dioInstance.post(path, data: data, cancelToken: cancelToken));
  }

  ///delete 请求
  Future<DioResult> delete(String path,
      {Map<String, dynamic>? queryParameters, CancelToken? cancelToken}) {
    return _handleResquest(_dioInstance.delete(path,
        queryParameters: queryParameters, cancelToken: cancelToken));
  }

  Future<DioResult> _handleResquest(Future<Response> future) {
    Completer<DioResult> completer = Completer();
    future.then((response) {
      ///请求发生异常
      if (response.statusCode != 200) {
        completer.completeError(DioResult.responseError(response));
      } else {
        DioResult result = DioResult.fromJson(response.data);

        ///没有拦截
        if (intercept == null) {
          completer.complete(result);
        } else {
          ///存在拦截,根据成功码和错误码进行业务处理
          if (intercept!.successCodes.contains(result.code)) {
            completer.complete(result);
          } else {
            if (intercept!.errorCodes.contains(result.code) &&
                !intercept!.interceptErrorCode(result.code)) {
              completer.completeError(result);
            }
          }
        }
      }
    }).catchError((e) {
      completer.completeError(DioResult.error(e));
    });

    return completer.future;
  }
}
