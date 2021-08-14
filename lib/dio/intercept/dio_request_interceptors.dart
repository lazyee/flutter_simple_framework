import 'package:dio/dio.dart';
import 'package:flutter_simple_framework/dio/dio_intercept.dart';

class RequestInterceptors extends InterceptorsWrapper {
  DioIntercept? intercept;
  RequestInterceptors({this.intercept}) : super();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Map<String, dynamic> headers = {};

    headers['ts'] = DateTime.now().millisecondsSinceEpoch;
    intercept?.interceptHeader(headers);

    options.headers = mergeMap(options.headers, headers);

    // if (options.method == 'GET') {
    // options.queryParameters =
    //     mergeMap(options.queryParameters, DioManager.getCommonHeaders());
    // } else if (options.method == 'POST') {
    // options.data = mergeMap(options.data, DioManager.getCommonHeaders());
    // }
    super.onRequest(options, handler);
  }

  Map<String, dynamic> mergeMap(
      Map<String, dynamic>? sourceMap, Map<String, dynamic>? map) {
    if (map == null) {
      return sourceMap!;
    }
    if (sourceMap == null) {
      return map;
    }

    sourceMap.addAll(map);
    return sourceMap;
  }
}
