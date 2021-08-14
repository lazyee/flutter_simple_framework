import 'package:intl/intl.dart';

///num的拓展方法
extension NumExtension<T> on num? {
  ///显示数字
  String toDisplayNumber({bool isShowSeparator = true}) {
    if (this == null) return '0';
    String pattern = isShowSeparator ? '#,##' : '###';

    List<String> arr = this.toString().split('\.');

    if (arr.length > 1) {
      if (arr[1].length >= 2) {
        if (arr[1] == '00') {
          pattern = "${pattern}0";
        } else {
          pattern = "${pattern}0.00";
        }
      } else {
        if (arr[1] == '0') {
          pattern = "${pattern}0";
        } else {
          pattern = "${pattern}0.0";
        }
      }
    } else {
      pattern = "${pattern}0";
    }

    return NumberFormat(pattern, "en_US").format(this);
  }
}
