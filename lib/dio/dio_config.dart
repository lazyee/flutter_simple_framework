const kContentTypeUrlencoded =
    'application/x-www-form-urlencoded; charset=utf-8';
const kContentTypeJson = 'application/json; charset=utf-8';
const kContentTypeHtml = 'text/html; charset=utf-8';

class DioConfig {
  String baseUrl;
  String? contentType;
  String? proxy;
  List<dynamic> interceptCodes;

  DioConfig(
      {required this.baseUrl,
      required this.interceptCodes,
      this.proxy,
      this.contentType});
}
