import 'package:shared_preferences/shared_preferences.dart';

///sp
class SPManager {
  late SharedPreferences _sp;
  static SPManager? _instance;
  static SPManager getInstance() {
    if (_instance == null) {
      _instance = SPManager._();
    }
    return _instance!;
  }

  SPManager._() {
    SharedPreferences.getInstance().then((sp) {
      _sp = sp;
    });
  }

  String? getString(String key) {
    return _sp.getString(key);
  }

  bool? getBool(String key) {
    return _sp.getBool(key);
  }

  int? getInt(String key) {
    return _sp.getInt(key);
  }

  double? getDouble(String key) {
    return _sp.getDouble(key);
  }

  Object? get(String key) {
    return _sp.get(key);
  }

  List<String>? getStringList(String key) {
    return _sp.getStringList(key);
  }

  Set<String> getKeys() {
    return _sp.getKeys();
  }
}
