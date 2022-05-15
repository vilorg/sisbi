import 'dart:convert';

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
      uri = Uri.parse(registerUriEmployer);
    } else {
      uri = Uri.parse(registerUriUser);
    }
    final response = await http.post(uri,
        body: jsonEncode({
          "user": {"phone": phone}
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
      uri = Uri.parse(getSmsEmployer);
    } else {
      uri = Uri.parse(getSmsUser);
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
}
