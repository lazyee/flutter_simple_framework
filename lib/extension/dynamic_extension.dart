extension DynamicExtension on dynamic {
  ///安全的获取字符串
  String? getString(dynamic key, {String? defVale}) {
    dynamic value = this[key];
    if (value == null) return defVale;
    if (value is String) return value;
    return value.toString();
  }

  ///安全的获取布尔值
  bool getBool(dynamic key, {bool defVal = false}) {
    dynamic value = this[key];
    if (value == null) return defVal;
    if (value is bool) return value;
    return defVal;
  }

  ///安全的获取int值
  int? getInt(dynamic key, {int? defVal}) {
    dynamic value = this[key];
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
  double? getDouble(dynamic key, {double? defVal}) {
    dynamic value = this[key];
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
