import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionDataProvider {
  final String keyToken = "userApiToken";
  final String keyIsUser = "isUser";
  final storage = const FlutterSecureStorage();

  Future<void> saveUserData(String token, bool isEmployer) async {
    final prefs = await SharedPreferences.getInstance();
    await storage.write(key: keyToken, value: token);
    await prefs.setBool(keyIsUser, !isEmployer);
  }

  Future<bool> checkUserToken() async {
    return await storage.read(key: keyToken) != null;
  }

  Future<bool> checkIsUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsUser) ?? true;
  }

  Future<String> getUserToken() async {
    return await storage.read(key: keyToken) ?? "";
  }
}
