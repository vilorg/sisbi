import 'package:sisbi/domain/data_providers/card_media_data_provider.dart';
import 'package:sisbi/domain/data_providers/session_data_provider.dart';
import 'package:sisbi/models/user_graph_model.dart';
import 'package:sisbi/models/vacancy_model.dart';

class CardService {
  final CardMediaDataProvider _cardProvider = CardMediaDataProvider();
  final SessionDataProvider _sessionProvider = SessionDataProvider();

  Future<List<VacancyModel>> getActualVacancyList(int page) async {
    List<VacancyModel> cards = await _cardProvider.getActualVacancyList(page);
    return cards;
  }

  Future<void> starVacancy(String token, int vacancyId) async {
    return await _cardProvider.starVacancy(token, vacancyId);
  }

  Future respondVacancy(String token, int vacancyId, String text) async {
    return await _cardProvider.respondVacancy(token, vacancyId, text);
  }

  Future<UserGraphModel?> getUserGraph() async {
    String token = await _sessionProvider.getUserToken();
    return await _cardProvider.getUserGraph(token);
  }
}
