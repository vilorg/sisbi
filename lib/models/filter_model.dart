// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sisbi/models/object_id.dart';

import 'enum_classes.dart';

class FilterModel {
  final String post;
  final ObjectId region;
  final int coast;
  final bool isMan;
  final bool isWoman;
  final List<ObjectId> jobCategory;
  final Expierence expierence;
  final List<ObjectId> typeEmployments;
  final List<ObjectId> schedules;

  FilterModel({
    required this.post,
    required this.region,
    required this.coast,
    required this.isMan,
    required this.isWoman,
    required this.jobCategory,
    required this.expierence,
    required this.typeEmployments,
    required this.schedules,
  });

  FilterModel copyWith({
    String? post,
    ObjectId? region,
    int? coast,
    bool? isMan,
    bool? isWoman,
    List<ObjectId>? jobCategory,
    Expierence? expierence,
    List<ObjectId>? typeEmployments,
    List<ObjectId>? schedules,
  }) {
    return FilterModel(
      post: post ?? this.post,
      region: region ?? this.region,
      coast: coast ?? this.coast,
      isMan: isMan ?? this.isMan,
      isWoman: isWoman ?? this.isWoman,
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
    if (isMan) _count += 1;
    if (isWoman) _count += 1;
    return _count;
  }

  static FilterModel deffault() => FilterModel(
        coast: 0,
        expierence: Expierence.notChosed,
        jobCategory: [],
        post: "",
        region: const ObjectId(0, ""),
        schedules: [],
        typeEmployments: [],
        isMan: false,
        isWoman: false,
      );
}
