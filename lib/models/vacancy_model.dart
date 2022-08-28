// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

import 'package:sisbi/models/enum_classes.dart';
import 'package:sisbi/models/object_id.dart';

class VacancyModel {
  final int id;
  final String title;
  final String description;
  final String fullName;
  final String avatar;
  final String phone;
  final String email;
  final Expierence experience;
  final int salary;
  final String jobCategoryName;
  final int jobCategoryId;
  final List<ObjectId> schedules;
  final List<ObjectId> typeEmployments;
  final int employerId;
  final String employerName;
  final String employerAvatar;
  final String employerPhone;
  final String employerEmail;
  final String employerAbout;
  final int cityId;
  final String cityName;
  final int views;
  final int shows;
  final int countResponse;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFavourite;

  VacancyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.fullName,
    required this.avatar,
    required this.phone,
    required this.email,
    required this.experience,
    required this.salary,
    required this.jobCategoryName,
    required this.jobCategoryId,
    required this.schedules,
    required this.typeEmployments,
    required this.employerId,
    required this.employerName,
    required this.employerAvatar,
    required this.employerPhone,
    required this.employerEmail,
    required this.employerAbout,
    required this.cityId,
    required this.cityName,
    required this.views,
    required this.shows,
    required this.countResponse,
    required this.createdAt,
    required this.updatedAt,
    required this.isFavourite,
  });

  VacancyModel copyWith({
    int? id,
    String? title,
    String? description,
    String? fullName,
    String? avatar,
    String? phone,
    String? email,
    Expierence? experience,
    int? salary,
    String? jobCategoryName,
    int? jobCategoryId,
    List<ObjectId>? schedules,
    List<ObjectId>? typeEmployments,
    int? employerId,
    String? employerName,
    String? employerAvatar,
    String? employerPhone,
    String? employerEmail,
    String? employerAbout,
    int? cityId,
    String? cityName,
    int? views,
    int? shows,
    int? countResponse,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFavourite,
  }) {
    return VacancyModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      fullName: fullName ?? this.fullName,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      experience: experience ?? this.experience,
      salary: salary ?? this.salary,
      jobCategoryName: jobCategoryName ?? this.jobCategoryName,
      jobCategoryId: jobCategoryId ?? this.jobCategoryId,
      schedules: schedules ?? this.schedules,
      typeEmployments: typeEmployments ?? this.typeEmployments,
      employerId: employerId ?? this.employerId,
      employerName: employerName ?? this.employerName,
      employerAvatar: employerAvatar ?? this.employerAvatar,
      employerPhone: employerPhone ?? this.employerPhone,
      employerEmail: employerEmail ?? this.employerEmail,
      employerAbout: employerAbout ?? this.employerAbout,
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
      views: views ?? this.views,
      shows: shows ?? this.shows,
      countResponse: countResponse ?? this.countResponse,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  factory VacancyModel.fromMap(Map<String, dynamic> json) {
    List<ObjectId> schedules = [];
    for (var i in json['schedules']) {
      schedules.add(ObjectId(i['id'] as int, i['name'] as String));
      //hellojhbk hbh
    }

    List<ObjectId> typeEmployments = [];
    for (var i in json['type_employments']) {
      typeEmployments.add(ObjectId(i['id'] as int, i['name'] as String));
    }

    return VacancyModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      fullName: json['full_name'] as String,
      avatar: json['avatar'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      experience: Expierence.values
          .firstWhere((e) => e.name == json['experience'] as String),
      salary: json['salary'] as int,
      jobCategoryName: json['job_category']['name'] as String,
      jobCategoryId: json['job_category']['id'] as int,
      schedules: schedules,
      typeEmployments: typeEmployments,
      employerId: json['employer']['id'] as int,
      employerName: json['employer']['name'] as String,
      employerAvatar: json['employer']['avatar'] as String,
      employerPhone: json['employer']['phone'] as String,
      employerEmail: json['employer']['email'] as String,
      employerAbout: json['employer']['about'] as String,
      cityId: json['city']['id'] as int,
      cityName: json['city']['name'] as String,
      views: json['views'] as int,
      shows: json['shows'] as int,
      countResponse: json['count_responses'] as int,
      createdAt: DateFormat("yyyy-MM-ddTHH:mm:ss")
          .parse((json['created_at'] as String).substring(0, 19)),
      updatedAt: DateFormat("yyyy-MM-ddTHH:mm:ss")
          .parse((json['updated_at'] as String).substring(0, 19)),
      isFavourite: json['is_favorite'] as bool? ?? false,
    );
  }

  factory VacancyModel.fromJson(String source) =>
      VacancyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<VacancyModel> getVacanciesFromListJson(String source) {
    List<VacancyModel> _vacancies = [];
    var _decoded = json.decode(source)['payload'] as List<dynamic>;
    for (var _vacancy in _decoded) {
      _vacancies.add(VacancyModel.fromMap(_vacancy));
    }
    return _vacancies;
  }

  @override
  String toString() {
    return 'VacancyModel(id: $id, title: $title, description: $description, fullName: $fullName, avatar: $avatar, phone: $phone, email: $email, experience: $experience, salary: $salary, jobCategoryName: $jobCategoryName, jobCategoryId: $jobCategoryId, schedules: $schedules, typeEmployments: $typeEmployments, employerId: $employerId, employerName: $employerName, employerAvatar: $employerAvatar, employerPhone: $employerPhone, employerEmail: $employerEmail, employerAbout: $employerAbout, cityId: $cityId, cityName: $cityName, views: $views, shows: $shows, countResponse: $countResponse, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
