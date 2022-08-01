// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:collection/collection.dart';

import 'enum_classes.dart';
import 'object_id.dart';

class UserModel {
  final int id;
  final bool isVisible;
  final String firstName;
  final String surname;
  final String avatar;
  final DateTime? birthday;
  final bool isMale;
  final Expierence expierence;
  final ObjectId region;
  final List<String> skills;
  final String phone;
  final String? email;
  final String about;
  final int minSalary;
  final bool readyMission;
  final bool readyMove;
  final List<Char> drivingLicence;
  final Education education;
  final String previusJob;
  final List<ObjectId> schedules;
  final List<ObjectId> typeEmployments;
  UserModel({
    required this.id,
    required this.isVisible,
    required this.firstName,
    required this.surname,
    required this.avatar,
    this.birthday,
    required this.isMale,
    required this.expierence,
    required this.region,
    required this.skills,
    required this.phone,
    this.email,
    required this.about,
    required this.minSalary,
    required this.readyMission,
    required this.readyMove,
    required this.drivingLicence,
    required this.education,
    required this.previusJob,
    required this.schedules,
    required this.typeEmployments,
  });

  UserModel copyWith({
    int? id,
    bool? isVisible,
    String? firstName,
    String? surname,
    String? avatar,
    DateTime? birthday,
    bool? isMale,
    Expierence? expierence,
    ObjectId? region,
    List<String>? skills,
    String? phone,
    String? email,
    String? about,
    int? minSalary,
    bool? readyMission,
    bool? readyMove,
    List<Char>? drivingLicence,
    Education? education,
    String? previusJob,
    List<ObjectId>? schedules,
    List<ObjectId>? typeEmployments,
  }) {
    return UserModel(
      id: id ?? this.id,
      isVisible: isVisible ?? this.isVisible,
      firstName: firstName ?? this.firstName,
      surname: surname ?? this.surname,
      avatar: avatar ?? this.avatar,
      birthday: birthday ?? this.birthday,
      isMale: isMale ?? this.isMale,
      expierence: expierence ?? this.expierence,
      region: region ?? this.region,
      skills: skills ?? this.skills,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      about: about ?? this.about,
      minSalary: minSalary ?? this.minSalary,
      readyMission: readyMission ?? this.readyMission,
      readyMove: readyMove ?? this.readyMove,
      drivingLicence: drivingLicence ?? this.drivingLicence,
      education: education ?? this.education,
      previusJob: previusJob ?? this.previusJob,
      schedules: schedules ?? this.schedules,
      typeEmployments: typeEmployments ?? this.typeEmployments,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'isVisible': isVisible,
  //     'firstName': firstName,
  //     'surname': surname,
  //     'avatar': avatar,
  //     'birthday': birthday?.millisecondsSinceEpoch,
  //     'isMale': isMale,
  //     'expierence': expierence.toMap(),
  //     'region': region.toMap(),
  //     'skills': skills,
  //     'phone': phone,
  //     'email': email,
  //     'about': about,
  //     'minSalary': minSalary,
  //     'readyMission': readyMission,
  //     'readyMove': readyMove,
  //     'drivingLicence': drivingLicence.map((x) => x.toMap()).toList(),
  //     'education': education,
  //     'previusJob': previusJob,
  //     'schedules': schedules.map((x) => x.toMap()).toList(),
  //     'typeEmployments': typeEmployments.map((x) => x.toMap()).toList(),
  //   };
  // }

  // factory UserModel.fromMap(Map<String, dynamic> map) {
  //   return UserModel(
  //     id: map['id'] as int,
  //     isVisible: map['isVisible'] as bool,
  //     firstName: map['firstName'] as String,
  //     surname: map['surname'] as String,
  //     avatar: map['avatar'] as String,
  //     birthday: map['birthday'] != null ? DateTime.fromMillisecondsSinceEpoch(map['birthday'] as int) : null,
  //     isMale: map['isMale'] as bool,
  //     expierence: Expierence.fromMap(map['expierence'] as Map<String,dynamic>),
  //     region: ObjectId.fromMap(map['region'] as Map<String,dynamic>),
  //     skills: List<String>.from((map['skills'] as List<String>),
  //     phone: map['phone'] as String,
  //     email: map['email'] != null ? map['email'] as String : null,
  //     about: map['about'] as String,
  //     minSalary: map['minSalary'] as int,
  //     readyMission: map['readyMission'] as bool,
  //     readyMove: map['readyMove'] as bool,
  //     drivingLicence: List<Char>.from((map['drivingLicence'] as List<int>).map<Char>((x) => Char.fromMap(x as Map<String,dynamic>),),),
  //     education: map['education'] as String,
  //     previusJob: map['previusJob'] as String,
  //     schedules: List<ObjectId>.from((map['schedules'] as List<int>).map<ObjectId>((x) => ObjectId.fromMap(x as Map<String,dynamic>),),),
  //     typeEmployments: List<ObjectId>.from((map['typeEmployments'] as List<int>).map<ObjectId>((x) => ObjectId.fromMap(x as Map<String,dynamic>),),),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, isVisible: $isVisible, firstName: $firstName, surname: $surname, avatar: $avatar, birthday: $birthday, isMale: $isMale, expierence: $expierence, region: $region, skills: $skills, phone: $phone, email: $email, about: $about, minSalary: $minSalary, readyMission: $readyMission, readyMove: $readyMove, drivingLicence: $drivingLicence, education: $education, previusJob: $previusJob, schedules: $schedules, typeEmployments: $typeEmployments)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is UserModel &&
        other.id == id &&
        other.isVisible == isVisible &&
        other.firstName == firstName &&
        other.surname == surname &&
        other.avatar == avatar &&
        other.birthday == birthday &&
        other.isMale == isMale &&
        other.expierence == expierence &&
        other.region == region &&
        listEquals(other.skills, skills) &&
        other.phone == phone &&
        other.email == email &&
        other.about == about &&
        other.minSalary == minSalary &&
        other.readyMission == readyMission &&
        other.readyMove == readyMove &&
        listEquals(other.drivingLicence, drivingLicence) &&
        other.education == education &&
        other.previusJob == previusJob &&
        listEquals(other.schedules, schedules) &&
        listEquals(other.typeEmployments, typeEmployments);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        isVisible.hashCode ^
        firstName.hashCode ^
        surname.hashCode ^
        avatar.hashCode ^
        birthday.hashCode ^
        isMale.hashCode ^
        expierence.hashCode ^
        region.hashCode ^
        skills.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        about.hashCode ^
        minSalary.hashCode ^
        readyMission.hashCode ^
        readyMove.hashCode ^
        drivingLicence.hashCode ^
        education.hashCode ^
        previusJob.hashCode ^
        schedules.hashCode ^
        typeEmployments.hashCode;
  }
}
