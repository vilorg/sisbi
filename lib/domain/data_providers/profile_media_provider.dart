import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:sisbi/constants.dart';

class ProfileMediaProvider {
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

  Future<void> uploadAvatar(String path, String token) async {
    Uri uri = Uri.parse(getUserUri);
    var request = http.MultipartRequest("PUT", uri)
      ..files.add(await http.MultipartFile.fromPath("user[avatar]", path))
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

  Future<void> saveName(String name, String surname, String token) async {
    Uri uri = Uri.parse(getUserUri);
    var response = await http.put(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "user": {
            "first_name": name,
            "surname": surname,
          }
        }));
    if (response.statusCode != 200) throw Exception();
  }

  Future<void> saveGenro(bool isMale, String token) async {
    Uri uri = Uri.parse(getUserUri);
    var response = await http.put(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "user": {
            "gender": isMale ? 0 : 1,
          }
        }));
    if (response.statusCode != 200) throw Exception();
  }

  Future<void> saveBirthday(DateTime birthday, String token) async {
    Uri uri = Uri.parse(getUserUri);
    var response = await http.put(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "user": {
            "birthday": DateFormat('dd.MM.yyyy').format(birthday),
          }
        }));
    if (response.statusCode != 200) throw Exception();
  }
}
