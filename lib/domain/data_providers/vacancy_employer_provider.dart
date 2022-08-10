import 'package:http/http.dart' as http;
import 'package:sisbi/constants.dart';
import 'package:sisbi/models/vacancy_model.dart';

class VacancyEmployerProvider {
  Future<List<VacancyModel>> getEmployerVacancies(String token) async {
    Uri _uri = Uri.parse(getEmployerVacanciesUri);
    final _response = await http.get(
      _uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (_response.statusCode != 200) throw Exception();

    //final _decoded = jsonDecode(_response.body)["payload"];

    try {
      final List<VacancyModel> _vacancies =
          VacancyModel.getVacanciesFromListJson(_response.body);
      return _vacancies;
    } catch (e) {
      throw Exception();
    }
  }
}
