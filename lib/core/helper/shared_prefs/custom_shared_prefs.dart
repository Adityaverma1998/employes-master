
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomSharedPref {
  CustomSharedPref._();
  static CustomSharedPref? _instance;

  static CustomSharedPref get instance {
    _instance ??= CustomSharedPref._();
    return _instance!;
  }

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> saveString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> getString(String key) async {
    return _storage.read(key: key);
  }

  static Future<void> saveInt(String key, int value) async {
    await _storage.write(key: key, value: value.toString());
  }

  static Future<int?> getInt(String key) async {
    final String? value = await _storage.read(key: key);
    return value != null ? int.parse(value) : null;
  }

  static Future<void> saveDouble(String key, double value) async {
    await _storage.write(key: key, value: value.toString());
  }

  static Future<double?> getDouble(String key) async {
    final String? value = await _storage.read(key: key);
    return value != null ? double.parse(value) : null;
  }

  static Future<void> saveDateTime(String key, DateTime value) async {
    await _storage.write(key: key, value: value.toIso8601String());
  }

  static Future<DateTime?> getDateTime(String key) async {
    final String? value = await _storage.read(key: key);
    return value != null ? DateTime.parse(value) : null;
  }

  static Future<void> saveBool(String key, bool value) async {
    await _storage.write(key: key, value: value.toString()); // "true" or "false"
  }

  static Future<bool> getBool(String key) async {
    final String? value = await _storage.read(key: key);
    return value != null ? value.toLowerCase() == 'true' : false;
  }

  static Future<void> removeData(String key) async {
    await _storage.delete(key: key);
  }

  static Future<void> clearData() async {
    await _storage.deleteAll();
  }
}
