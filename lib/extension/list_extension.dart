import 'dart:convert';

///列表的拓展方法
extension ListExtension<T> on List {
  T? find<T>(bool test(T item)) {
    for (dynamic item in this) {
      if (item is T) {
        if (test(item)) return item;
      }
    }
    return null;
  }

  List<T> filter<T>(bool test(T item)) {
    List<T> result = [];
    for (dynamic item in this) {
      if (item is T) {
        if (test(item)) {
          result.add(item);
        }
      }
    }
    return result;
  }
}
