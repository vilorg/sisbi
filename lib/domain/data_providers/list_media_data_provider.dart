import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sisbi/constants.dart';
import 'package:sisbi/models/object_id.dart';

class ListMediaDataProvider {
  Future<List<ObjectId>> getCities(String token, String s) async {
    String uriString = getCitiesUri;
    if (s.isNotEmpty) {
      uriString += "&q[name_cont]=$s";
    }

    Uri uri = Uri.parse(uriString);
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    List<ObjectId> data = [];

    try {
      final List<dynamic> decoded = jsonDecode(response.body)["payload"];
      for (var i in decoded) {
        ObjectId objectId = ObjectId(i['id'], i['name']);
        data.add(objectId);
      }
    } catch (e) {
      data = [];
    }
    return data;
  }

  Future<List<ObjectId>> getJobCategories(String token) async {
    String uriString = getJobCategoriesUri;

    Uri uri = Uri.parse(uriString);
    final response = await http.get(uri);

    List<ObjectId> data = [];

    try {
      final List<dynamic> decoded = jsonDecode(response.body)["payload"];
      for (var i in decoded) {
        ObjectId objectId = ObjectId(i['id'], i['name']);
        data.add(objectId);
      }
    } catch (e) {
      data = [];
    }
    return data;
  }
}
