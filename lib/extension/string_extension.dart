import 'dart:convert';

///字符串拓展方法
extension StringExtension on String {
/*
  * Base64加密
  */
  String encodeBase64() {
    var content = utf8.encode(this);
    var digest = base64.encode(content);
    return digest;
  }

/*
  * Base64解密
  */
  String decodeBase64() {
    return String.fromCharCodes(base64Decode(this));
  }

  ///大陆手机号码11位数，匹配格式：前三位固定格式+后8位任意数
  /// 此方法中前三位格式有：
  /// 13+任意数 * 15+除4的任意数 * 18+除1和4的任意数 * 17+除9的任意数 * 147
  bool get isChinaPhoneLegal => RegExp(
          '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
      .hasMatch(this);

  ///是否是合法密码,数字+字母,最小长度6位
  bool get isPasswordLegal =>
      RegExp('(?![0-9]+\$)(?![a-zA-Z+Z]+\$)[0-9A-Za-z]{6,}\$').hasMatch(this);

  ///隐藏中国手机号码
  String? hideChinaMobile() {
    if (isEmpty) return this;
    if (length < 11) return this;
    return substring(0, 3) + '*****' + substring(7);
  }
}
