import 'package:sisbi/domain/data_providers/card_employer_provider.dart';
import 'package:sisbi/domain/data_providers/session_data_provider.dart';
import 'package:sisbi/models/filter_model.dart';
import 'package:sisbi/models/object_id.dart';
import 'package:sisbi/models/user_data_model.dart';

class CardEmployerService {
  final CardEmployerDataProvider _cardProvider = CardEmployerDataProvider();
  final SessionDataProvider _sessionProvider = SessionDataProvider();

  Future<String> getToken() async => await _sessionProvider.getToken();

  Future<List<UserDataModel>> getActualResumeList(
      int page, FilterModel filter) async {
    String token = await _sessionProvider.getToken();
    List<UserDataModel> cards =
        await _cardProvider.getActualResumeList(page, filter, token);
    return cards;
  }

  Future<List<UserDataModel>> getFavouriteResumeList() async {
    String token = await _sessionProvider.getToken();
    List<UserDataModel> cards =
        await _cardProvider.getFavouriteResumeList(token);
    return cards;
  }

  Future<void> starResume(int resumeId) async {
    String token = await _sessionProvider.getToken();
    return await _cardProvider.starResume(token, resumeId);
  }

  Future<void> unstarResume(int resumeId) async {
    String token = await _sessionProvider.getToken();
    return await _cardProvider.unstarResume(token, resumeId);
  }

  Future respondVacancy(
      String token, int resumeId, int userId, String text) async {
    return await _cardProvider.respondResume(token, resumeId, userId, text);
  }

  Future<List<ObjectId>> getVacancies() async {
    String token = await _sessionProvider.getToken();
    return await _cardProvider.getVacancies(token);
  }

  Future<UserDataModel> getUserGraph() async {
    String token = await _sessionProvider.getToken();
    return await _cardProvider.getUserData(token);
  }
}
