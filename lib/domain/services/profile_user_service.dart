import 'package:sisbi/domain/data_providers/card_user_data_provider.dart';
import 'package:sisbi/domain/data_providers/profile_user_provider.dart';
import 'package:sisbi/domain/data_providers/session_data_provider.dart';
import 'package:sisbi/models/enum_classes.dart';
import 'package:sisbi/models/object_id.dart';
import 'package:sisbi/models/user_data_model.dart';

class ProfileUserService {
  final SessionDataProvider _sessionProvider = SessionDataProvider();
  final CardUserDataProvider _cardProvider = CardUserDataProvider();
  final ProfileUserProvider _profileProvider = ProfileUserProvider();

  Future<String> getUserToken() async => await _sessionProvider.getToken();

  Future<UserDataModel> getUserData(String token) async {
    final UserDataModel _userData = await _cardProvider.getUserData(token);
    // print(_userData.firstName);
    // print(_userData.surname);
    return _userData;
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

  Future<void> saveCareer(
          String vacancy, int coast, int jobCategoryId, String token) async =>
      await _profileProvider.saveCareer(vacancy, coast, jobCategoryId, token);

  Future<void> saveSkills(List<String> skills, String token) async =>
      await _profileProvider.saveSkills(skills, token);

  Future<void> saveExp(Expierence exp, String token) async =>
      await _profileProvider.saveExp(exp, token);

  Future<void> saveEducation(Education education, String token) async =>
      await _profileProvider.saveEducation(education, token);

  Future<void> saveTypeEmployments(List<int> schedules, String token) async =>
      await _profileProvider.saveTypeEmployments(schedules, token);

  Future<void> saveSchedules(List<int> typeEmployments, String token) async =>
      await _profileProvider.saveSchedules(typeEmployments, token);

  Future<void> saveLicences(List<String> licences, String token) async =>
      await _profileProvider.saveLicences(licences, token);

  Future<void> saveMission(List<bool> missions, String token) async =>
      await _profileProvider.saveMission(missions, token);

  Future<List<ObjectId>> getCities(String search) async =>
      await _cardProvider.getCities(search);

  Future<List<String>> getNamedVacancies(String text) async =>
      await _cardProvider.getNameVacancies(text);

  Future<List<ObjectId>> getNamedJobCategories() async =>
      await _cardProvider.getNamedJobCategories();

  Future<void> logout() async => await _sessionProvider.logout();
}

//TODO: объединить user и employer в один сервис