import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sisbi/constants.dart';
import 'package:sisbi/models/employer_data_model.dart';

class ProfileEmployerProvider {
  Future<EmployerDataModel> getEmployerData(String token) async {
    Uri _uri = Uri.parse(getEmployerUri);
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
      final EmployerDataModel _employer =
          EmployerDataModel.fromJson(_response.body);
      return _employer;
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> uploadAvatar(String path, String token) async {
    Uri uri = Uri.parse(getEmployerUri);
    var request = http.MultipartRequest("PUT", uri)
      ..files.add(await http.MultipartFile.fromPath("employer[avatar]", path))
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

  Future<void> saveEmail(String email, String token) async {
    Uri _uri = Uri.parse(getEmployerUri);
    final _response = await http.put(
      _uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'employer': {'email': email},
      }),
    );
    if (_response.statusCode != 200) throw Exception();
  }

  Future<void> saveAbout(String about, String token) async {
    Uri _uri = Uri.parse(getEmployerUri);
    final _response = await http.put(
      _uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'employer': {'about': about},
      }),
    );
    if (_response.statusCode != 200) throw Exception();
  }
}
//TODO: отловить 401 ошибку на страницах