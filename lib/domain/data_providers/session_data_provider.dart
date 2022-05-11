import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionDataProvider {
  final String keyToken = "userApiToken";
  final storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await storage.write(key: keyToken, value: token);
  }

  Future<bool> chechUserToken() async {
    return await storage.read(key: keyToken) != null;
  }

  Future<String?> getUserToken() async {
    return await storage.read(key: keyToken);
  }
}
