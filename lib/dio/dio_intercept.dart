abstract class DioIntercept {
  Map<String, dynamic> interceptHeader(Map<String, dynamic> header);
  bool interceptErrorCode(dynamic code);
  List<dynamic> get successCodes;
  List<dynamic> get errorCodes;
}
