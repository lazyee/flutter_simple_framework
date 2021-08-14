import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioLogInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('==================== REQUEST ====================');
    debugPrint('- URL:${options.baseUrl + options.path}');
    debugPrint('- METHOD: ${options.method}');
    debugPrint('- HEADER:${options.headers}');

    final data = options.data;
    if (data != null) {
      if (data is Map)
        debugPrint('- BODY:$data');
      else if (data is FormData) {
        final formDataMap = Map()
          ..addEntries(data.fields)
          ..addEntries(data.files);
        debugPrint('- BODY:$formDataMap');
      } else
        debugPrint('- BODY:${data.toString()}');
    }

    final queryParameters = options.queryParameters;
    if (queryParameters.isNotEmpty) {
      debugPrint('- QUERY:$queryParameters');
    }
    super.onRequest(options, handler);
  }
}
