import 'package:sisbi/domain/data_providers/session_data_provider.dart';
import 'package:sisbi/domain/data_providers/vacancy_employer_provider.dart';
import 'package:sisbi/ui/pages/employer/pages/profile/create_vacancy_page.dart';

class VacancyEmployerService {
  final VacancyEmployerProvider _vacancy = VacancyEmployerProvider();
  final SessionDataProvider _session = SessionDataProvider();

  Future<void> saveVacancy(VacancyState state) async {
    String token = await _session.getToken();
    await _vacancy.saveVacancy(state, token);
  }

  Future<void> updateVacancy(
      int chatId, VacancyState state, bool isAvatar) async {
    String token = await _session.getToken();
    await _vacancy.updateVacancy(chatId, state, isAvatar, token);
  }
}
