class BaseModel {
  ///安全的获取字符串
  String? getString(dynamic json, String key, {String? defVal = ''}) {
    dynamic value = json[key];
    if (value == null) return defVal;
    if (value is String) return value;
    return value.toString();
  }

  ///安全的获取布尔值
  bool getBool(dynamic json, String key, {bool defVal = false}) {
    dynamic value = json[key];
    if (value == null) return defVal;
    if (value is bool) return value;
    return defVal;
  }

  ///安全的获取int值
  int? getInt(dynamic json, String key, {int? defVal = 0}) {
    dynamic value = json[key];
    if (value == null) return defVal;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      try {
        return double.parse(value).toInt();
      } catch (e) {
        return defVal;
      }
    }
    return defVal;
  }

  ///安全的获取double值
  double? getDouble(dynamic json, String key, {double? defVal = 0}) {
    dynamic value = json[key];
    if (value == null) return defVal;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        return defVal;
      }
    }
    return defVal;
  }
}
