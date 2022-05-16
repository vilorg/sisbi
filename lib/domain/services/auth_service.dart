import 'package:sisbi/domain/data_providers/auth_api_provider.dart';
import 'package:sisbi/domain/data_providers/session_data_provider.dart';

class AuthService {
  final AuthApiProvider _authApiProvider = AuthApiProvider();
  final SessionDataProvider _sessionDataProvider = SessionDataProvider();

  Future<bool> checkAuth() async {
    return await _sessionDataProvider.checkUserToken();
  }

  Future<void> getLoginCode(bool isEmployer, String phone) async {
    return await _authApiProvider.getLoginCode(isEmployer, phone);
  }

  Future<void> registerUser(bool isEmployer, String phone) async {
    await _authApiProvider.registerUser(isEmployer, phone);
    return await _authApiProvider.getLoginCode(isEmployer, phone);
  }

  Future<void> checkLoginCode(
      bool isEmployer, String phone, String code) async {
    String token = await _authApiProvider.checkSmsCode(isEmployer, phone, code);
    return await _sessionDataProvider.saveUserData(token, isEmployer);
  }

  Future<void> saveUser({
    required bool isUser,
    required String firstName,
    required String surName,
    required String skills,
    required String email,
    required bool isMale,
    required String comanyName,
    required DateTime birthDay,
    required int experience,
    required List<int> typeEmployments,
    required List<int> schedules,
  }) async {
    String token = await _sessionDataProvider.getUserToken();
    await _authApiProvider.saveUser(
      token,
      isUser,
      firstName,
      surName,
      comanyName,
      email,
      birthDay,
      isMale,
      experience,
    );
    if (isUser) {
      await _authApiProvider.saveSchedules(token, schedules);
      await _authApiProvider.saveTypeEmployments(token, typeEmployments);
    }
  }
}
