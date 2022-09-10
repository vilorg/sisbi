import 'package:sisbi/domain/data_providers/card_user_data_provider.dart';
import 'package:sisbi/domain/data_providers/session_data_provider.dart';
import 'package:sisbi/models/filter_model.dart';
import 'package:sisbi/models/user_data_model.dart';
import 'package:sisbi/models/vacancy_model.dart';

class CardEmployeeService {
  final CardUserDataProvider _cardProvider = CardUserDataProvider();
  final SessionDataProvider _sessionProvider = SessionDataProvider();

  Future<List<VacancyModel>> getActualVacancyList(
      int page, FilterModel filter) async {
    String token = await _sessionProvider.getToken();
    List<VacancyModel> cards =
        await _cardProvider.getActualVacancyList(page, filter, token);
    return cards;
  }

  Future<List<VacancyModel>> getFavouriteVacancyList() async {
    String token = await _sessionProvider.getToken();
    List<VacancyModel> cards =
        await _cardProvider.getFavouriteVacancyList(token);
    return cards;
  }

  Future<void> starVacancy(int vacancyId) async {
    String token = await _sessionProvider.getToken();
    return await _cardProvider.starVacancy(token, vacancyId);
  }

  Future<void> unstarVacancy(int vacancyId) async {
    String token = await _sessionProvider.getToken();
    return await _cardProvider.unstarVacancy(token, vacancyId);
  }

  Future respondVacancy(int vacancyId, String text) async {
    String token = await _sessionProvider.getToken();
    return await _cardProvider.respondVacancy(token, vacancyId, text);
  }

  Future<UserDataModel> getUserGraph() async {
    String token = await _sessionProvider.getToken();
    return await _cardProvider.getUserData(token);
  }
}
