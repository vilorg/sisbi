import 'package:sisbi/domain/data_providers/card_media_data_provider.dart';
import 'package:sisbi/domain/data_providers/session_data_provider.dart';
import 'package:sisbi/models/filter_vacancy_model.dart';
import 'package:sisbi/models/user_data_model.dart';
import 'package:sisbi/models/vacancy_model.dart';

class CardEmployeeService {
  final CardMediaDataProvider _cardProvider = CardMediaDataProvider();
  final SessionDataProvider _sessionProvider = SessionDataProvider();

  Future<List<VacancyModel>> getActualVacancyList(
      int page, FilterVacancyModel filter) async {
    String token = await _sessionProvider.getUserToken();
    List<VacancyModel> cards =
        await _cardProvider.getActualVacancyList(page, filter, token);
    return cards;
  }

  Future<List<VacancyModel>> getFavouriteVacancyList() async {
    String token = await _sessionProvider.getUserToken();
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
    String token = await _sessionProvider.getUserToken();
    return await _cardProvider.getUserData(token);
  }
}
