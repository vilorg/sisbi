// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sisbi/models/filter_vacancy_model.dart';
import 'package:sisbi/models/object_id.dart';

class UserDataModel {
  final String firstName;
  final String surname;
  final bool isMale;
  final DateTime birthday;
  final String phone;
  final String email;
  final String avatar;
  final Expierence experience;
  final List<ObjectId> schedules;
  final List<ObjectId> typeEmployments;
  final ObjectId region;
  final String post;
  final int coast;
  UserDataModel({
    required this.firstName,
    required this.surname,
    required this.isMale,
    required this.birthday,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.experience,
    required this.schedules,
    required this.typeEmployments,
    required this.region,
    required this.post,
    required this.coast,
  });

  UserDataModel copyWith({
    String? firstName,
    String? surname,
    bool? isMale,
    DateTime? birthday,
    String? phone,
    String? email,
    String? avatar,
    Expierence? experience,
    List<ObjectId>? schedules,
    List<ObjectId>? typeEmployments,
    ObjectId? region,
    String? post,
    int? coast,
  }) {
    return UserDataModel(
      firstName: firstName ?? this.firstName,
      surname: surname ?? this.surname,
      isMale: isMale ?? this.isMale,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      experience: experience ?? this.experience,
      schedules: schedules ?? this.schedules,
      typeEmployments: typeEmployments ?? this.typeEmployments,
      region: region ?? this.region,
      post: post ?? this.post,
      coast: coast ?? this.coast,
    );
  }

  @override
  String toString() {
    return 'UserDataModel(firstName: $firstName, surname: $surname, isMale: $isMale, birthday: $birthday, phone: $phone, email: $email, avatar: $avatar, experience: $experience, schedules: $schedules, typeEmployments: $typeEmployments, region: $region, post: $post, coast: $coast)';
  }

  static UserDataModel deffault() => UserDataModel(
        firstName: "",
        surname: "",
        email: "",
        phone: "",
        avatar: "",
        isMale: true,
        birthday: DateTime.now(),
        experience: Expierence.notChosed,
        schedules: [],
        typeEmployments: [],
        region: ObjectId(0, ""),
        post: "",
        coast: 0,
      );
}
