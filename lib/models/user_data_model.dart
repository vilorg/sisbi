// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sisbi/models/object_id.dart';

import 'enum_classes.dart';

class UserDataModel {
  final String firstName;
  final String surname;
  final bool isMale;
  final String avatar;
  final DateTime birthday;
  final int coast;
  final String phone;
  final String email;
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
  UserDataModel({
    required this.firstName,
    required this.surname,
    required this.isMale,
    required this.avatar,
    required this.birthday,
    required this.coast,
    required this.phone,
    required this.email,
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
  });

  UserDataModel copyWith({
    String? firstName,
    String? surname,
    bool? isMale,
    String? avatar,
    DateTime? birthday,
    int? coast,
    String? phone,
    String? email,
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
  }) {
    return UserDataModel(
      firstName: firstName ?? this.firstName,
      surname: surname ?? this.surname,
      isMale: isMale ?? this.isMale,
      avatar: avatar ?? this.avatar,
      birthday: birthday ?? this.birthday,
      coast: coast ?? this.coast,
      phone: phone ?? this.phone,
      email: email ?? this.email,
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
    );
  }

  @override
  String toString() {
    return 'UserDataModel(firstName: $firstName, surname: $surname, isMale: $isMale, avatar: $avatar, birthday: $birthday, coast: $coast, phone: $phone, email: $email, region: $region, post: $post, drivingLicence: $drivingLicence, education: $education, previusJob: $previusJob, experience: $experience, schedules: $schedules, typeEmployments: $typeEmployments, skills: $skills, readyMission: $readyMission, readyMove: $readyMove)';
  }

  static UserDataModel deffault() => UserDataModel(
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
        region: ObjectId(0, ""),
        post: "",
        coast: 0,
        readyMission: false,
        readyMove: false,
      );
}
