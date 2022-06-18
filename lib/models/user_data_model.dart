// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sisbi/models/filter_vacancy_model.dart';
import 'package:sisbi/models/object_id.dart';

class UserDataModel {
  final Expierence experience;
  final List<ObjectId> schedules;
  final List<ObjectId> typeEmployments;
  final ObjectId region;
  final String post;
  final int coast;
  UserDataModel({
    required this.experience,
    required this.schedules,
    required this.typeEmployments,
    required this.region,
    required this.post,
    required this.coast,
  });

  UserDataModel copyWith({
    Expierence? experience,
    List<ObjectId>? schedules,
    List<ObjectId>? typeEmployments,
    ObjectId? region,
    String? post,
    int? coast,
  }) {
    return UserDataModel(
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
    return 'UserDataModel(experience: $experience, schedules: $schedules, typeEmployments: $typeEmployments, city: $region, post: $post, coast: $coast)';
  }

  static UserDataModel deffault() => UserDataModel(
      experience: Expierence.notChosed,
      schedules: [],
      typeEmployments: [],
      region: ObjectId(0, ""),
      post: "",
      coast: 0);
}
