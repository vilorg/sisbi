import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sisbi/constants.dart';

class AuthFetchDataError {}

class AuthUnknownUserError {}

class AuthBusyUserError {}

class AuthApiProvider {
  Future<void> getLoginCode(bool isLogin, String phone) async {
    if (!isLogin) {
      Uri uri = Uri.parse(registerUri);
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
        throw AuthBusyUserError();
      } else if (resultCode != "ok") {
        throw Exception();
      }
    }

    Uri uri = Uri.parse(loginUri);
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
      throw AuthUnknownUserError();
    } else if (resultCode != "ok") {
      throw Exception();
    }
  }
}
