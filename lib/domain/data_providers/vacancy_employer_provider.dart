import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sisbi/constants.dart';
import 'package:sisbi/models/object_id.dart';
import 'package:sisbi/models/vacancy_model.dart';
import 'package:sisbi/ui/pages/employer/pages/profile/create_vacancy_page.dart';

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

  Future<void> saveVacancy(VacancyState state, String token) async {
    String phone = state.phone;
    phone = phone.replaceAll("-", "");
    phone = "8" + phone;

    final _response1 = await http.post(
      Uri.parse(getEmployerVacanciesUri),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'vacancy': {
          'title': state.title,
          'description': state.description,
          'job_category_id': state.jobCategory.id,
          'full_name': state.fullName,
          'phone': '7' + phone,
          'email': state.email,
          'experience': state.expierence.name,
          'salary': state.coast,
          'city_id': state.city.id,
        }
      }),
    );
    if (_response1.statusCode != 201) throw Exception();

    int id = jsonDecode(_response1.body)['payload']['id'] as int;

    var request = http.MultipartRequest(
      "PUT",
      Uri.parse(getEmployerVacanciesUri + "/$id"),
    )
      ..files.add(await http.MultipartFile.fromPath(
          "vacancy[avatar]", state.pathAvatar))
      ..headers.addAll({
        // 'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
    var streamedResponse = await request.send();
    try {
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) throw Exception();
    } catch (e) {
      throw Exception();
    }

    await http.put(
      Uri.parse(getEmployerVacanciesUri + "/$id/add_schedules"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
          {'schedules': state.schedules.map((ObjectId e) => e.id).toList()}),
    );

    await http.put(
      Uri.parse(getEmployerVacanciesUri + "/$id/add_type_employments"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'type_employments':
            state.typeEmployments.map((ObjectId e) => e.id).toList()
      }),
    );
  }

  Future<void> deleteVacancy(int chatId, String token) async {
    await http.delete(
      Uri.parse(getEmployerVacanciesUri + "/$chatId"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<void> updateVacancy(
      int chatId, VacancyState state, bool isAvatar, String token) async {
    String phone = state.phone;
    phone = phone.replaceAll(" │ ", "");
    phone = phone.replaceAll("-", "");

    final _response1 = await http.put(
      Uri.parse(getEmployerVacanciesUri + "/$chatId"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'vacancy': {
          'title': state.title,
          'description': state.description,
          'job_category_id': state.jobCategory.id,
          'full_name': state.fullName,
          'phone': phone,
          'email': state.email,
          'experience': state.expierence.name,
          'salary': state.coast,
          'city_id': state.city.id,
        }
      }),
    );
    if (_response1.statusCode != 200) throw Exception();

    if (!isAvatar) {
      var request = http.MultipartRequest(
        "PUT",
        Uri.parse(getEmployerVacanciesUri + "/$chatId"),
      )
        ..files.add(await http.MultipartFile.fromPath(
            "vacancy[avatar]", state.pathAvatar))
        ..headers.addAll({
          // 'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });
      var streamedResponse = await request.send();
      try {
        var response = await http.Response.fromStream(streamedResponse);
        if (response.statusCode != 200) throw Exception();
      } catch (e) {
        throw Exception();
      }
    }

    await http.put(
      Uri.parse(getEmployerVacanciesUri + "/$chatId/remove_schedules"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'schedules': [1, 2, 3, 4],
      }),
    );

    await http.put(
      Uri.parse(getEmployerVacanciesUri + "/$chatId/remove_type_employments"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'type_employments': [1, 2, 3, 4],
      }),
    );

    await http.put(
      Uri.parse(getEmployerVacanciesUri + "/$chatId/add_schedules"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
          {'schedules': state.schedules.map((ObjectId e) => e.id).toList()}),
    );

    await http.put(
      Uri.parse(getEmployerVacanciesUri + "/$chatId/add_type_employments"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'type_employments':
            state.typeEmployments.map((ObjectId e) => e.id).toList()
      }),
    );
  }
}
