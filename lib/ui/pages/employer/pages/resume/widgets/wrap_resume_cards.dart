// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/enum_classes.dart';
import 'package:sisbi/models/object_id.dart';
import 'package:sisbi/models/user_data_model.dart';

class WrapResumeCards extends StatelessWidget {
  const WrapResumeCards({
    Key? key,
    required this.userData,
  }) : super(key: key);

  final UserDataModel userData;

  @override
  Widget build(BuildContext context) {
    List<Container> data = [];

    data.add(_buildWrapCard(context, _stringExp(userData.experience), false));

    data.add(_buildWrapCard(context, userData.region.value, false));

    List<ObjectId> schedules = userData.schedules;

    for (ObjectId i in schedules) {
      data.add(_buildWrapCard(context, i.value, false));
    }

    return Wrap(
      alignment: WrapAlignment.start,
      runSpacing: defaultPadding / 2,
      spacing: defaultPadding / 2,
      children: data,
    );
  }

  Container _buildWrapCard(BuildContext context, String text, bool isSelect) =>
      Container(
        decoration: BoxDecoration(
          color: isSelect ? colorAccentDarkBlue : null,
          border: Border.all(
            color: colorAccentDarkBlue,
          ),
          borderRadius: BorderRadius.circular(300),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: defaultPadding / 2,
          horizontal: defaultPadding,
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: colorTextContrast,
                fontWeight: FontWeight.w600,
              ),
        ),
      );

  // bool _isExpierence(Expierence userExpierence, Expierence vacancyExpierence) {
  //   int intUserExp = _intExp(userExpierence.name.toString());
  //   int intVacancyExp = _intExp(vacancyExpierence.name.toString());
  //   return intUserExp >= intVacancyExp;
  // }

  // int _intExp(String experience) {
  //   switch (experience) {
  //     case "no":
  //       return 0;
  //     case "y_1_3":
  //       return 1;
  //     case "y_2_6":
  //       return 2;
  //     case "more_6":
  //       return 3;
  //   }
  //   return -1;
  // }

  String _stringExp(Expierence experience) {
    switch (experience.name) {
      case "no":
        return "Нет опыта";
      case "y_1_3":
        return "1 - 3 года";
      case "y_2_6":
        return "3 - 6 лет";
      case "more_6":
        return "более 6 лет";
    }
    return "";
  }
}
