import 'package:sisbi/domain/data_providers/auth_api_provider.dart';
import 'package:sisbi/domain/data_providers/session_data_provider.dart';

class AuthService {
  final AuthApiProvider _authApiProvider = AuthApiProvider();
  final SessionDataProvider _sessionDataProvider = SessionDataProvider();

  Future<bool> checkAuth() async {
    return false;
  }

  Future<void> getLoginCode(bool isEmployer, String phone) async {
    return await _authApiProvider.getLoginCode(isEmployer, phone);
  }

  Future<void> checkLoginCode(
      bool isEmployer, String phone, String code) async {
    String token = await _authApiProvider.checkSmsCode(isEmployer, phone, code);
    return await _sessionDataProvider.saveToken(token);
  }

  Future<void> registerUser(bool isEmployer, String phone) async {
    await _authApiProvider.registerUser(isEmployer, phone);
    return await _authApiProvider.getLoginCode(isEmployer, phone);
  }
}
