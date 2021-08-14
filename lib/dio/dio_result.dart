import 'package:dio/dio.dart';

class DioResult {
  dynamic code;
  dynamic msg;
  dynamic data;

  List<String> get codeKeys => ['code', 'rtnCode'];
  List<String> get msgkeys => ['msg', 'message'];
  List<String> get dataKeys => ['data', 'content'];

  DioResult({this.code, this.msg, this.data});

  DioResult.fromJson(Map<String, dynamic> json) {
    for (int i = 0; i < codeKeys.length; i++) {
      if (json[codeKeys[i]] != null) {
        code = json[codeKeys[i]];
        break;
      }
    }

    for (int i = 0; i < msgkeys.length; i++) {
      if (json[msgkeys[i]] != null) {
        msg = json[msgkeys[i]];
        break;
      }
    }

    for (int i = 0; i < dataKeys.length; i++) {
      if (json[dataKeys[i]] != null) {
        data = json[dataKeys[i]];
        break;
      }
    }
  }

  DioResult.responseError(Response? response) {
    code = response?.statusCode ?? -1;
    msg = response?.statusMessage ?? '[NULL]';
  }

  DioResult.error(DioError error) {
    if (error.response != null) {
      code = error.response!.statusCode;
    } else {
      code = -1;
    }
    msg = error.message;
  }

  @override
  String toString() => 'DioResult(code: $code, msg: $msg, data: $data)';
}
