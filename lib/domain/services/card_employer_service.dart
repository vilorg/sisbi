import 'package:sisbi/domain/data_providers/card_employer_provider.dart';
import 'package:sisbi/domain/data_providers/session_data_provider.dart';
import 'package:sisbi/models/filter_model.dart';
import 'package:sisbi/models/user_data_model.dart';
import 'package:sisbi/models/vacancy_model.dart';

class CardEmployerService {
  final CardEmployerDataProvider _cardProvider = CardEmployerDataProvider();
  final SessionDataProvider _sessionProvider = SessionDataProvider();

  Future<List<UserDataModel>> getActualResumeList(
      int page, FilterModel filter) async {
    String token = await _sessionProvider.getToken();
    List<UserDataModel> cards =
        await _cardProvider.getActualVacancyList(page, filter, token);
    return cards;
  }

  Future<List<VacancyModel>> getFavouriteVacancyList() async {
    String token = await _sessionProvider.getToken();
    List<VacancyModel> cards =
        await _cardProvider.getFavouriteVacancyList(token);
    return cards;
  }

  Future<void> starVacancy(String token, int vacancyId) async {
    return await _cardProvider.starVacancy(token, vacancyId);
  }

  Future<void> unstarVacancy(String token, int vacancyId) async {
    return await _cardProvider.unstarVacancy(token, vacancyId);
  }

  Future respondVacancy(String token, int vacancyId, String text) async {
    return await _cardProvider.respondVacancy(token, vacancyId, text);
  }

  Future<UserDataModel> getUserGraph() async {
    String token = await _sessionProvider.getToken();
    return await _cardProvider.getUserData(token);
  }
}
