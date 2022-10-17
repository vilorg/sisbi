import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sisbi/constants.dart';
import 'package:sisbi/models/enum_classes.dart';
import 'package:sisbi/models/filter_model.dart';
import 'package:sisbi/models/object_id.dart';
import 'package:sisbi/models/user_data_model.dart';

class CardEmployerDataProvider {
  Future<List<UserDataModel>> getActualResumeList(
      int page, FilterModel filter, String token) async {
    String uriString = getResumeUri + "?";
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
    params.add("limit=7");

    Uri uri = Uri.parse(uriString + params.join("&"));
    var response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) throw Exception();

    List dirtyData = jsonDecode(response.body)["payload"];

    List<UserDataModel> data = [];

    for (var i in dirtyData) {
      UserDataModel user = UserDataModel.fromMap(i);
      data.add(user);
    }
    return data;
  }

  Future<List<UserDataModel>> getFavouriteResumeList(String token) async {
    String uriString = getFavouriteResumeUri;
    Uri uri = Uri.parse(uriString);
    var response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) throw Exception();

    List dirtyData = jsonDecode(response.body)["payload"];
    List<UserDataModel> data = [];

    for (var i in dirtyData) {
      UserDataModel user = UserDataModel.fromMap(i);
      data.add(user);
    }
    return data;
  }

  Future<void> starResume(String token, int resumeId) async {
    Uri uri = Uri.parse(getFavouriteResumeUri);
    final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "favorite_user": {"user_id": resumeId}
        }));
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode != 200) throw Exception();
  }

  Future<void> unstarResume(String token, int resumeId) async {
    Uri uri = Uri.parse("$getFavouriteResumeUri/$resumeId");
    final response =
        await http.delete(uri, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode != 200) throw Exception();
  }

  Future respondResume(
      String token, int vacancyId, int userId, String text) async {
    Uri uri = Uri.parse(getRespondResumeUri);
    final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "invite": {
            "vacancy_id": vacancyId,
            "user_id": userId,
            "message": text,
          }
        }));
    if (response.statusCode == 422) throw DoubleResponseException();
    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  Future<UserDataModel> getUserData(String token) async {
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

    // try {
    final String experience = _decoded["experience"];
    final String education = _decoded['education'];
    final List schedulesDatas = _decoded["schedules"];
    final List typeEmploymentsDatas = _decoded["type_employments"];
    final String skills = _decoded["skills"];
    final int coast = _decoded["min_salary"];
    final String drivingLicenceString = _decoded['driving_license'];
    List<String> drivingLicenceList = [];
    List<DrivingLicence> drivingLicence = [];

    if (drivingLicenceString.isNotEmpty) {
      drivingLicenceList = drivingLicenceString.split(" ");
    }

    for (String licence in drivingLicenceList) {
      drivingLicence.add(DrivingLicence.values.firstWhere(
          (element) => element.toString() == "DrivingLicence." + licence));
    }

    ObjectId city = const ObjectId(0, "");
    if (_decoded['city'] != null) {
      city = ObjectId(
          _decoded['city']['id'] as int, _decoded['city']['name'] as String);
    }

    ObjectId jobCategory = const ObjectId(0, "");
    if (_decoded[''] != null) {
      jobCategory = ObjectId(
          _decoded['job_category']['id'], _decoded['job_category']['name']);
    }

    List<String> birthdayList = _decoded['birthday'].split('.');

    DateTime birthday = DateTime(int.parse(birthdayList[2]),
        int.parse(birthdayList[1]), int.parse(birthdayList[0]));

    List<ObjectId> schedules = [];
    for (var i in schedulesDatas) {
      schedules.add(ObjectId(i["id"] as int, i["name"] as String));
    }

    List<ObjectId> typeEmployments = [];
    for (var i in typeEmploymentsDatas) {
      typeEmployments.add(ObjectId(i["id"] as int, i["name"] as String));
    }

    // print(_decoded['first_name'] as String);
    // print(_decoded['surname'] as String);

    return UserDataModel(
      id: _decoded['id'] as int,
      firstName: _decoded['first_name'] as String,
      surname: _decoded['surname'] as String,
      avatar: _decoded['avatar'],
      birthday: birthday,
      previusJob: _decoded['previous_job'],
      isMale: _decoded['gender'] == "male",
      email: _decoded["email"] ?? "",
      phone: _decoded["phone"],
      drivingLicence: drivingLicence,
      education: Education.values.firstWhere(
          (element) => element.toString() == "Education." + education),
      experience: Expierence.values
          .firstWhere((e) => e.toString() == "Expierence." + experience),
      schedules: schedules,
      skills: (_decoded['skills'] as String).split(" "),
      region: city,
      jobCategory: jobCategory,
      post: skills,
      coast: coast,
      typeEmployments: typeEmployments,
      readyMission: _decoded['ready_mission'] as bool,
      readyMove: _decoded['ready_move'] as bool,
      about: _decoded['about'] ?? "",
      createdAt: _decoded['created_at'] as String,
      isFavourite: _decoded['is_favorite'] as bool,
      shows: _decoded['shows'] as int? ?? 0,
      views: _decoded['views'] as int? ?? 0,
      isModetate: (_decoded['state'] as String?) == "moderating",
    );
    // } catch (e) {
    //   print(e);
    //   return UserDataModel.deffault();
    // }
  }

  Future<List<ObjectId>> getCities(String search) async {
    List<ObjectId> cities = [];
    Uri uri = Uri.parse(getCityUri + "&q[name_cont]=" + search);
    var response = await http.get(uri);
    if (response.statusCode != 200) throw Exception;
    var decoded = jsonDecode(response.body)['payload'];
    for (var city in decoded) {
      cities.add(ObjectId(city['id'] as int, city['name'] as String));
    }
    return cities;
  }

  Future<List<String>> getNameVacancies(String text) async {
    List<String> vacancies = [];
    Uri uri = Uri.parse(getNameVacancyUri + "&q[name_cont]=" + text);
    var response = await http.get(uri);
    if (response.statusCode != 200) throw Exception;
    var decoded = jsonDecode(response.body)['payload'];
    for (var vacancyName in decoded) {
      vacancies.add(vacancyName['name'] as String);
    }
    return vacancies;
  }

  Future<List<ObjectId>> getVacancies(String token) async {
    List<ObjectId> vacancies = [];
    Uri uri = Uri.parse(getEmployerVacanciesUri);
    var response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode != 200) throw Exception;
    var decoded = jsonDecode(response.body)['payload'];
    // print(response.statusCode);
    // print(decoded);
    for (var vacancyName in decoded) {
      vacancies.add(
          ObjectId(vacancyName['id'] as int, vacancyName['title'] as String));
    }
    return vacancies;
  }

  Future<List<ObjectId>> getNamedJobCategories() async {
    List<ObjectId> vacancies = [];
    Uri uri = Uri.parse(getJobCategoriesUri);
    var response = await http.get(uri);
    if (response.statusCode != 200) throw Exception;
    var decoded = jsonDecode(response.body)['payload'];
    for (var vacancyName in decoded) {
      vacancies.add(
          ObjectId(vacancyName['id'] as int, vacancyName['name'] as String));
    }
    return vacancies;
  }
}
