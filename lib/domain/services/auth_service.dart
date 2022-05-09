import 'package:sisbi/domain/data_providers/auth_api_provider.dart';
import 'package:sisbi/domain/data_providers/session_data_provider.dart';

class AuthService {
  final AuthApiProvider _authApiProvider = AuthApiProvider();
  final SessionDataProvider _sessionDataProvider = SessionDataProvider();

  Future<bool> checkAuth() async {
    return false;
  }

  Future<void> getLoginCode(bool isLogin, String phone) async {
    return await _authApiProvider.getLoginCode(isLogin, phone);
  }
}
