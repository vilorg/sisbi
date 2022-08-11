import 'package:sisbi/domain/data_providers/session_data_provider.dart';
import 'package:sisbi/domain/data_providers/profile_employer_provider.dart';
import 'package:sisbi/domain/data_providers/vacancy_employer_provider.dart';
import 'package:sisbi/models/employer_data_model.dart';
import 'package:sisbi/models/vacancy_model.dart';

class ProfileEmployerService {
  Future<String> getEmployerToken() async => await _session.getToken();

  final SessionDataProvider _session = SessionDataProvider();
  final ProfileEmployerProvider _profileData = ProfileEmployerProvider();
  final VacancyEmployerProvider _vacancyData = VacancyEmployerProvider();

  Future<EmployerDataModel> getEmployerData(String token) async =>
      await _profileData.getEmployerData(token);

  Future<void> uploadAvatar(String path, String token) async =>
      await _profileData.uploadAvatar(path, token);

  Future<void> saveEmail(String email, String token) async =>
      await _profileData.saveEmail(email, token);

  Future<void> saveAbout(String about, String token) async =>
      await _profileData.saveAbout(about, token);

  Future<List<VacancyModel>> getEmployerVacancies(String token) async =>
      await _vacancyData.getEmployerVacancies(token);

  Future<void> deleteVacancy(int chatId, String token) async =>
      await _vacancyData.deleteVacancy(chatId, token);

  Future<void> logout() async => await _session.logout();
}
