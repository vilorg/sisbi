import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sisbi/constants.dart';
import 'package:sisbi/models/user_graph_model.dart';
import 'package:sisbi/models/vacancy_model.dart';

class CardMediaDataProvider {
  Future<List<VacancyModel>> getActualVacancyList(int page) async {
    List<VacancyModel> data = [];
    Uri uri = Uri.parse(getVacancyUri);
    var response = await http.get(uri);
    if (response.statusCode != 200) throw Exception();
    List dirtyData = jsonDecode(response.body)["payload"];
    for (var i in dirtyData) {
      VacancyModel vacancy = VacancyModel.fromMap(i);
      data.add(vacancy);
    }
    return data;
  }

  Future<void> starVacancy(String token, int vacancyId) async {
    Uri uri = Uri.parse(starVacancyUri);
    await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "favorite_vacancy": {"vacancy_id": vacancyId}
        }));
  }

  Future respondVacancy(String token, int vacancyId, String text) async {
    Uri uri = Uri.parse(respondVacancyUri);
    return await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "response": {
            "vacancy_id": vacancyId,
            "message": text,
          }
        }));
  }

  Future<UserGraphModel?> getUserGraph(String token) async {
    Uri _uri = Uri.parse(getUserUri);
    final _response = await http.get(
      _uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (_response.statusCode != 200) throw Exception();

    final _decoded = jsonDecode(_response.body)["payload"];

    try {
      String experience = _decoded["experience"];
      String? city = _decoded["city"];
      List schedulesDatas = _decoded["schedules"];
      List<String> schedules = [];
      for (var i in schedulesDatas) {
        schedules.add(i["name"]);
      }
      return UserGraphModel(
          experience: experience, schedules: schedules, city: city);
    } catch (e) {
      return null;
    }
  }
}
