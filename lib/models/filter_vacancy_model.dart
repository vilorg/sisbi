// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sisbi/models/object_id.dart';

import 'enum_classes.dart';

class FilterVacancyModel {
  final String post;
  final ObjectId region;
  final int coast;
  final List<ObjectId> jobCategory;
  final Expierence expierence;
  final List<ObjectId> typeEmployments;
  final List<ObjectId> schedules;

  FilterVacancyModel({
    required this.post,
    required this.region,
    required this.coast,
    required this.jobCategory,
    required this.expierence,
    required this.typeEmployments,
    required this.schedules,
  });

  FilterVacancyModel copyWith({
    String? post,
    ObjectId? region,
    int? coast,
    List<ObjectId>? jobCategory,
    Expierence? expierence,
    List<ObjectId>? typeEmployments,
    List<ObjectId>? schedules,
  }) {
    return FilterVacancyModel(
      post: post ?? this.post,
      region: region ?? this.region,
      coast: coast ?? this.coast,
      jobCategory: jobCategory ?? this.jobCategory,
      expierence: expierence ?? this.expierence,
      typeEmployments: typeEmployments ?? this.typeEmployments,
      schedules: schedules ?? this.schedules,
    );
  }

  @override
  String toString() {
    return 'FilterVacancyModel(post: $post, region: $region, coast: $coast, jobCategory: $jobCategory, expierence: $expierence, typeEmployments: $typeEmployments, schedules: $schedules)';
  }

  int count() {
    int _count = 0;
    if (post != "") _count += 1;
    if (region.value != "") _count += 1;
    if (coast != 0) _count += 1;
    if (jobCategory.isNotEmpty) _count += 1;
    if (typeEmployments.isNotEmpty) _count += 1;
    if (schedules.isNotEmpty) _count += 1;
    if (expierence != Expierence.notChosed) _count += 1;
    return _count;
  }

  static FilterVacancyModel deffault() => FilterVacancyModel(
      coast: 0,
      expierence: Expierence.notChosed,
      jobCategory: [],
      post: "",
      region: ObjectId(0, ""),
      schedules: [],
      typeEmployments: []);
}
