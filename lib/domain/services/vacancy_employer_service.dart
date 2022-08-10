import 'package:sisbi/domain/data_providers/session_data_provider.dart';
import 'package:sisbi/domain/data_providers/vacancy_employer_provider.dart';

class VacancyEmployerService {
  final VacancyEmployerProvider _vacancy = VacancyEmployerProvider();
  final SessionDataProvider _session = SessionDataProvider();
}
