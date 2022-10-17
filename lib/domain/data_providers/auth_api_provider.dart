import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:sisbi/constants.dart';

class AuthFetchDataError {}

class AuthUnknownUserError {}

class AuthUnknownEmployerError {}

class AuthBusyUserError {}

class AuthBusyEmployerError {}

class AuthIncorrectCode {}

class AuthApiProvider {
  Future<void> registerUser(bool isEmployer, String phone) async {
    Uri uri;
    if (isEmployer) {
      uri = Uri.parse(getEmployerUri);
    } else {
      uri = Uri.parse(getUserUri);
    }
    final response = await http.post(uri,
        body: jsonEncode({
          isEmployer ? "employer" : "user": {"phone": phone}
        }),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode != 201 && response.statusCode != 422) {
      throw AuthFetchDataError();
    }
    var decoded = jsonDecode(response.body);
    var resultCode = decoded["result_code"];
    var messagesData = decoded["messages"];
    var errorData = decoded["errors"];

    if (resultCode == null && messagesData != null && errorData != null) {
      if (isEmployer) {
        throw AuthBusyEmployerError();
      }
      throw AuthBusyUserError();
    } else if (resultCode != "ok") {
      throw Exception();
    }
  }

  Future<void> getLoginCode(bool isEmployer, String phone) async {
    Uri uri;
    if (isEmployer) {
      uri = Uri.parse(getSmsEmployerUri);
    } else {
      uri = Uri.parse(getSmsUserUri);
    }
    final response = await http.post(uri,
        body: jsonEncode({"phone": phone}),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode != 200 && response.statusCode != 422) {
      throw AuthFetchDataError();
    }
    var decoded = jsonDecode(response.body);
    var resultCode = decoded["result_code"];
    var messagesData = decoded["messages"];
    var errorData = decoded["errors"];

    if (resultCode == null && messagesData != null && errorData != null) {
      if (isEmployer) throw AuthUnknownEmployerError();
      throw AuthUnknownUserError();
    } else if (resultCode != "ok") {
      throw Exception();
    }
  }

  Future<String> checkSmsCode(
      bool isEmployer, String phone, String smsCode) async {
    Uri uri;
    if (isEmployer) {
      uri = Uri.parse(getEmployerTokenUri);
    } else {
      uri = Uri.parse(getUserTokenUri);
    }

    final response = await http.post(uri,
        body: jsonEncode({
          "auth": {"phone": phone, "sms_pin": smsCode}
        }),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 404) {
      throw AuthIncorrectCode();
    } else if (response.statusCode != 200) {
      throw Exception();
    }
    var decoded = jsonDecode(response.body);
    var token = decoded["access_token"];
    if (token == null) throw Exception();

    return token;
  }

  Future<List<String>> getPosts(String s) async {
    Uri uri = Uri.parse(getNameVacancyUri + "&q[name_cont]=$s");
    var response = await http.get(uri);
    if (response.statusCode != 200) throw Exception();
    List<String> result = [];
    var _decoded = jsonDecode(response.body)['payload'];

    for (var post in _decoded) {
      result.add(post['name']);
    }

    return result;
  }

  Future<void> saveUser(
      String token,
      bool isUser,
      String firstName,
      String surName,
      String comanyName,
      String email,
      DateTime birthDay,
      bool isMale,
      int experience,
      String previousJob) async {
    Uri uri;
    if (isUser) {
      uri = Uri.parse(getUserUri);
    } else {
      uri = Uri.parse(getEmployerUri);
    }
    var response = await http.put(uri,
        body: isUser
            ? jsonEncode({
                "user": {
                  "previous_job": previousJob,
                  "first_name": firstName,
                  "surname": surName,
                  "birthday": DateFormat("dd.MM.yyyy").format(birthDay),
                  "gender": isMale ? "male" : "female",
                  "experience": experience,
                  "email": email,
                }
              })
            : jsonEncode({
                "employer": {"name": comanyName, "email": email}
              }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode != 200 ||
        jsonDecode(response.body)["result_code"] != "ok") throw Exception();
    print(jsonDecode(response.body));
    return;
  }

  Future<void> saveSchedules(String token, List<int> schedules) async {
    for (int i = 0; i < schedules.length; i++) {
      schedules[i] += 1;
    }
    Uri uri = Uri.parse(setSchedulesUri);
    final response = await http
        .put(uri, body: jsonEncode({"schedules": schedules}), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode != 200) throw Exception();
  }

  Future<void> saveTypeEmployments(
      String token, List<int> typeEmployments) async {
    for (int i = 0; i < typeEmployments.length; i++) {
      typeEmployments[i] += 1;
    }
    Uri uri = Uri.parse(getAddTypeEmploymentsUri);
    final response = await http.put(uri,
        body: jsonEncode({"type_employments": typeEmployments}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode != 200) throw Exception();
  }
}
