import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static final SharedPrefHelper _instance = SharedPrefHelper._internal();
  factory SharedPrefHelper() => _instance;
  SharedPrefHelper._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async {
    return _prefs?.setString(key, value) ?? Future.value(false);
  }

  Future<bool> setBool(String key, bool value) async {
    return _prefs?.setBool(key, value) ?? Future.value(false);
  }

  Future<bool> setInt(String key, int value) async {
    return _prefs?.setInt(key, value) ?? Future.value(false);
  }

  Future<bool> setDouble(String key, double value) async {
    return _prefs?.setDouble(key, value) ?? Future.value(false);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return _prefs?.setStringList(key, value) ?? Future.value(false);
  }

  String? getString(String key) => _prefs?.getString(key);
  bool? getBool(String key) => _prefs?.getBool(key);
  int? getInt(String key) => _prefs?.getInt(key);
  double? getDouble(String key) => _prefs?.getDouble(key);
  List<String>? getStringList(String key) => _prefs?.getStringList(key);

  Future<bool> remove(String key) async {
    return _prefs?.remove(key) ?? Future.value(false);
  }

  Future<bool> clearAll() async {
    return _prefs?.clear() ?? Future.value(false);
  }

  // Check if key exists
  bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }
}
