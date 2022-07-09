import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sisbi/constants.dart';
import 'package:sisbi/models/filter_vacancy_model.dart';
import 'package:sisbi/models/object_id.dart';
import 'package:sisbi/models/user_data_model.dart';
import 'package:sisbi/models/vacancy_model.dart';

class CardMediaDataProvider {
  Future<List<VacancyModel>> getActualVacancyList(
      int page, FilterVacancyModel filter, String token) async {
    String uriString = getVacancyUri + "?";
    List<String> params = [];

    if (filter.post != "") {
      params.add("q[description_or_title_cont]=${filter.post}");
    }
    if (filter.region.value != "") {
      params.add("q[city_id_eq]=${filter.region.id}");
    }
    if (filter.coast != 0) {
      params.add("q[salary_gteq]=${filter.coast}");
    }
    if (filter.expierence != Expierence.notChosed) {
      params.add("q[experience_eq]=${filter.expierence}");
    }

    if (filter.jobCategory != []) {
      for (var value in filter.jobCategory) {
        params.add("q[job_category_id_in][]=${value.id}");
      }
    }
    if (filter.typeEmployments != []) {
      for (var value in filter.typeEmployments) {
        params.add("q[type_employments_id_in][]=${value.id}");
      }
    }
    if (filter.schedules != []) {
      for (var value in filter.schedules) {
        params.add("q[schedules_id_in][]=${value.id}");
      }
    }
    params.add("page=$page");

    Uri uri = Uri.parse(uriString + params.join("&"));
    var response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) throw Exception();

    List dirtyData = jsonDecode(response.body)["payload"];

    List<VacancyModel> data = [];

    for (var i in dirtyData) {
      VacancyModel vacancy = VacancyModel.fromMap(i);
      data.add(vacancy);
    }
    return data;
  }

  Future<List<VacancyModel>> getFavouriteVacancyList(String token) async {
    String uriString = getFavouriteVacancyUri;
    Uri uri = Uri.parse(uriString);
    var response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) throw Exception();

    List dirtyData = jsonDecode(response.body)["payload"];
    List<VacancyModel> data = [];

    for (var i in dirtyData) {
      VacancyModel vacancy = VacancyModel.fromMap(i);
      data.add(vacancy);
    }
    return data;
  }

  Future<void> starVacancy(String token, int vacancyId) async {
    Uri uri = Uri.parse(getFavouriteVacancyUri);
    await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "favorite_vacancy": {"vacancy_id": vacancyId}
        }));
  }

  Future<void> unstarVacancy(String token, int vacancyId) async {
    Uri uri = Uri.parse("$getFavouriteVacancyUri/$vacancyId");
    await http.delete(uri, headers: {'Authorization': 'Bearer $token'});
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

  Future<UserDataModel> getUserGraph(String token) async {
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
      final String experience = _decoded["experience"];
      final String? city = _decoded["city"];
      final List schedulesDatas = _decoded["schedules"];
      final List typeEmploymentsDatas = _decoded["type_employments"];
      final String skills = _decoded["skills"];
      final int coast = _decoded["min_salary"];

      List<ObjectId> schedules = [];
      for (var i in schedulesDatas) {
        schedules.add(ObjectId(i["id"] as int, i["name"] as String));
      }

      List<ObjectId> typeEmployments = [];
      for (var i in typeEmploymentsDatas) {
        typeEmployments.add(ObjectId(i["id"] as int, i["name"] as String));
      }

      return UserDataModel(
        experience: Expierence.values
            .firstWhere((e) => e.toString() == "Expierence." + experience),
        schedules: schedules,
        region: ObjectId(0, city ?? ""),
        post: skills,
        coast: coast,
        typeEmployments: typeEmployments,
      );
    } catch (e) {
      return UserDataModel.deffault();
    }
  }
}
