import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionDataProvider {
  final String _keyToken = "userApiToken";
  final String _keyIsUser = "isUser";
  final _storage = const FlutterSecureStorage();

  Future<void> saveUserData(String token, bool isEmployer) async {
    final _prefs = await SharedPreferences.getInstance();
    await _storage.write(key: _keyToken, value: token);
    await _prefs.setBool(_keyIsUser, !isEmployer);
  }

  Future<bool> checkUserToken() async {
    return await _storage.read(key: _keyToken) != null;
  }

  Future<bool> checkIsUser() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(_keyIsUser) ?? true;
  }

  Future<String> getUserToken() async {
    return await _storage.read(key: _keyToken) ?? "";
  }

  Future<void> logout() async => await _storage.delete(key: _keyToken);
}
