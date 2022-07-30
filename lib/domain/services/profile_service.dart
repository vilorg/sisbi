import 'package:sisbi/domain/data_providers/card_media_data_provider.dart';
import 'package:sisbi/domain/data_providers/profile_media_provider.dart';
import 'package:sisbi/domain/data_providers/session_data_provider.dart';
import 'package:sisbi/models/object_id.dart';
import 'package:sisbi/models/user_data_model.dart';

class ProfileService {
  final SessionDataProvider _sessionProvider = SessionDataProvider();
  final CardMediaDataProvider _cardProvider = CardMediaDataProvider();
  final ProfileMediaProvider _profileProvider = ProfileMediaProvider();

  Future<String> getUserToken() async => await _sessionProvider.getUserToken();

  Future<UserDataModel> getUserData(String token) async {
    return await _cardProvider.getUserData(token);
  }

  Future<void> uploadAvatar(String path, String token) async =>
      await _profileProvider.uploadAvatar(path, token);

  Future<void> saveName(String name, String avatar, String token) async =>
      await _profileProvider.saveName(name, avatar, token);

  Future<void> saveGenro(bool isMale, String token) async =>
      await _profileProvider.saveGenro(isMale, token);

  Future<void> saveBirthday(DateTime birthday, String token) async =>
      await _profileProvider.saveBirthday(birthday, token);

  Future<void> saveEmail(String email, String token) async =>
      await _profileProvider.saveEmail(email, token);

  Future<void> saveCity(ObjectId city, String token) async =>
      await _profileProvider.saveCity(city, token);

  Future<List<ObjectId>> getCities(String search) async =>
      await _cardProvider.getCities(search);

  Future<void> logout() async => await _sessionProvider.logout();
}