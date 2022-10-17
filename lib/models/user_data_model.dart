// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sisbi/models/object_id.dart';

import 'enum_classes.dart';

class UserDataModel {
  final int id;
  final String firstName;
  final String surname;
  final bool isMale;
  final String avatar;
  final DateTime birthday;
  final int coast;
  final String phone;
  final String email;
  final ObjectId jobCategory;
  final ObjectId region;
  final String post;
  final List<DrivingLicence> drivingLicence;
  final Education education;
  final String previusJob;
  final Expierence experience;
  final List<ObjectId> schedules;
  final List<ObjectId> typeEmployments;
  final List<String> skills;
  final bool readyMission;
  final bool readyMove;
  final String about;
  final String createdAt;
  final bool isFavourite;
  final int views;
  final int shows;
  final bool isModetate;
  UserDataModel({
    required this.id,
    required this.firstName,
    required this.surname,
    required this.isMale,
    required this.avatar,
    required this.birthday,
    required this.coast,
    required this.phone,
    required this.email,
    required this.jobCategory,
    required this.region,
    required this.post,
    required this.drivingLicence,
    required this.education,
    required this.previusJob,
    required this.experience,
    required this.schedules,
    required this.typeEmployments,
    required this.skills,
    required this.readyMission,
    required this.readyMove,
    required this.about,
    required this.createdAt,
    required this.isFavourite,
    required this.views,
    required this.shows,
    required this.isModetate,
  });

  UserDataModel copyWith({
    int? id,
    String? firstName,
    String? surname,
    bool? isMale,
    String? avatar,
    DateTime? birthday,
    int? coast,
    String? phone,
    String? email,
    ObjectId? jobCategory,
    ObjectId? region,
    String? post,
    List<DrivingLicence>? drivingLicence,
    Education? education,
    String? previusJob,
    Expierence? experience,
    List<ObjectId>? schedules,
    List<ObjectId>? typeEmployments,
    List<String>? skills,
    bool? readyMission,
    bool? readyMove,
    String? about,
    String? createdAt,
    bool? isFavourite,
    int? views,
    int? shows,
    bool? isModetate,
  }) {
    return UserDataModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      surname: surname ?? this.surname,
      isMale: isMale ?? this.isMale,
      avatar: avatar ?? this.avatar,
      birthday: birthday ?? this.birthday,
      coast: coast ?? this.coast,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      jobCategory: jobCategory ?? this.jobCategory,
      region: region ?? this.region,
      post: post ?? this.post,
      drivingLicence: drivingLicence ?? this.drivingLicence,
      education: education ?? this.education,
      previusJob: previusJob ?? this.previusJob,
      experience: experience ?? this.experience,
      schedules: schedules ?? this.schedules,
      typeEmployments: typeEmployments ?? this.typeEmployments,
      skills: skills ?? this.skills,
      readyMission: readyMission ?? this.readyMission,
      readyMove: readyMove ?? this.readyMove,
      about: about ?? this.about,
      createdAt: createdAt ?? this.createdAt,
      isFavourite: isFavourite ?? this.isFavourite,
      views: views ?? this.views,
      shows: shows ?? this.shows,
      isModetate: isModetate ?? this.isModetate,
    );
  }

  @override
  String toString() {
    return 'UserDataModel(id: $id, firstName: $firstName, surname: $surname, isMale: $isMale, avatar: $avatar, birthday: $birthday, coast: $coast, phone: $phone, email: $email, jobCategory: $jobCategory, region: $region, post: $post, drivingLicence: $drivingLicence, education: $education, previusJob: $previusJob, experience: $experience, schedules: $schedules, typeEmployments: $typeEmployments, skills: $skills, readyMission: $readyMission, readyMove: $readyMove, about: $about, createdAt: $createdAt, isFavourite: $isFavourite, views: $views, shows: $shows, isModetate: $isModetate)';
  }

  static UserDataModel deffault() => UserDataModel(
        id: 0,
        firstName: "",
        surname: "",
        email: "",
        phone: "",
        avatar: "",
        isMale: true,
        drivingLicence: [],
        birthday: DateTime.now(),
        previusJob: "",
        experience: Expierence.notChosed,
        skills: [""],
        schedules: [],
        typeEmployments: [],
        education: Education.secondary,
        region: const ObjectId(0, ""),
        jobCategory: const ObjectId(0, ""),
        post: "",
        coast: 0,
        readyMission: false,
        readyMove: false,
        about: "",
        createdAt: "",
        isFavourite: false,
        shows: 0,
        views: 0,
        isModetate: false,
      );

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    List<String> birthdayList = map['birthday'].split('.');
    DateTime birthday;
    if (birthdayList.length == 1) {
      birthday = DateTime.now();
    } else {
      birthday = DateTime(int.parse(birthdayList[2]),
          int.parse(birthdayList[1]), int.parse(birthdayList[0]));
    }

    ObjectId jobCategory = const ObjectId(0, "");
    if (map[''] != null) {
      jobCategory =
          ObjectId(map['job_category']['id'], map['job_category']['name']);
    }

    ObjectId city = const ObjectId(0, "");
    if (map['city'] != null) {
      city = ObjectId(map['city']['id'] as int, map['city']['name'] as String);
    }

    final String drivingLicenceString = map['driving_license'];
    List<String> drivingLicenceList = [];
    List<DrivingLicence> drivingLicence = [];

    if (drivingLicenceString.isNotEmpty) {
      drivingLicenceList = drivingLicenceString.split(" ");
    }

    for (String licence in drivingLicenceList) {
      drivingLicence.add(DrivingLicence.values.firstWhere(
          (element) => element.toString() == "DrivingLicence." + licence));
    }

    final String education = map['education'];
    final String experience = map["experience"];
    final String skills = map["skills"];

    final List schedulesDatas = map["schedules"];
    final List typeEmploymentsDatas = map["type_employments"];
    List<ObjectId> schedules = [];
    for (var i in schedulesDatas) {
      schedules.add(ObjectId(i["id"] as int, i["name"] as String));
    }

    List<ObjectId> typeEmployments = [];
    for (var i in typeEmploymentsDatas) {
      typeEmployments.add(ObjectId(i["id"] as int, i["name"] as String));
    }

    return UserDataModel(
      id: map['id'] as int,
      firstName: map['first_name'] as String,
      surname: map['surname'] as String,
      isMale: map['gender'] as String == "male",
      avatar: map['avatar'] as String,
      birthday: birthday,
      coast: map['min_salary'] ?? 0,
      phone: map['phone'] as String,
      email: map['email'] ?? "",
      jobCategory: jobCategory,
      region: city,
      post: skills,
      drivingLicence: drivingLicence,
      education: Education.values.firstWhere(
          (element) => element.toString() == "Education." + education),
      previusJob: map['previous_job'] as String,
      experience: Expierence.values
          .firstWhere((e) => e.toString() == "Expierence." + experience),
      schedules: schedules,
      typeEmployments: typeEmployments,
      skills: (map['skills'] as String).split(" "),
      readyMission: map['ready_mission'] as bool,
      readyMove: map['ready_move'] as bool,
      about: map['about'] ?? "",
      createdAt: map['created_at'] as String,
      isFavourite: map['is_favorite'] as bool,
      shows: map['shows'] as int? ?? 0,
      views: map['views'] as int? ?? 0,
      isModetate: (map['state'] as String?) != "state",
    );
  }

  factory UserDataModel.fromJson(String source) =>
      UserDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant UserDataModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.surname == surname &&
        other.isMale == isMale &&
        other.avatar == avatar &&
        other.birthday == birthday &&
        other.coast == coast &&
        other.phone == phone &&
        other.email == email &&
        other.jobCategory == jobCategory &&
        other.region == region &&
        other.post == post &&
        listEquals(other.drivingLicence, drivingLicence) &&
        other.education == education &&
        other.previusJob == previusJob &&
        other.experience == experience &&
        listEquals(other.schedules, schedules) &&
        listEquals(other.typeEmployments, typeEmployments) &&
        listEquals(other.skills, skills) &&
        other.readyMission == readyMission &&
        other.readyMove == readyMove &&
        other.about == about &&
        other.createdAt == createdAt &&
        other.isFavourite == isFavourite &&
        other.views == views &&
        other.shows == shows &&
        other.isModetate == isModetate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        surname.hashCode ^
        isMale.hashCode ^
        avatar.hashCode ^
        birthday.hashCode ^
        coast.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        jobCategory.hashCode ^
        region.hashCode ^
        post.hashCode ^
        drivingLicence.hashCode ^
        education.hashCode ^
        previusJob.hashCode ^
        experience.hashCode ^
        schedules.hashCode ^
        typeEmployments.hashCode ^
        skills.hashCode ^
        readyMission.hashCode ^
        readyMove.hashCode ^
        about.hashCode ^
        createdAt.hashCode ^
        isFavourite.hashCode ^
        views.hashCode ^
        shows.hashCode ^
        isModetate.hashCode;
  }
}
