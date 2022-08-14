// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';

class ResumeStaticHeader extends StatelessWidget {
  const ResumeStaticHeader({
    Key? key,
    required this.avatar,
    required this.name,
    required this.title,
    required this.salary,
  }) : super(key: key);

  final String avatar;
  final String name;
  final String title;
  final int salary;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.vertical -
          60,
      decoration: const BoxDecoration(
        color: colorAccentDarkBlue,
      ),
      child: Stack(
        children: [
          avatar != ""
              ? Image.network(
                  avatar,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.vertical -
                      // VacancyInheritedWidget.of(context)!.appBarHeight -
                      60,
                  alignment: Alignment.center,
                )
              : Image.asset(
                  "assets/images/resume.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.vertical -
                      // VacancyInheritedWidget.of(context)!.appBarHeight -
                      60,
                  alignment: Alignment.center,
                ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: colorTextContrast,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: colorTextContrast,
                        ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    "От $salary руб.",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: colorTextContrast,
                        ),
                  ),
                  // const SizedBox(height: defaultPadding),
                  // WrapVacancyCards(
                  //   vacancy: vacancy,
                  //   userData: userData,
                  // ),
                  const SizedBox(height: 2 * defaultPadding),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
