// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';

import 'vacancy_static_header.dart';

class VacancyStaticCard extends StatelessWidget {
  const VacancyStaticCard({
    Key? key,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.avatar,
    required this.employerAvatar,
    required this.salary,
    required this.name,
  }) : super(key: key);

  final String createdAt;
  final String title;
  final String description;
  final String avatar;
  final String employerAvatar;
  final int salary;
  final String name;

  @override
  Widget build(BuildContext context) {
    final date = createdAt.substring(0, 10);
    return Scaffold(
      backgroundColor: colorAccentDarkBlue,
      appBar: AppBar(
        title: Text(
          "Просмотр резюме",
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: colorTextContrast,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      body: ClipRRect(
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(borderRadius)),
        child: ColoredBox(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VacancyStaticHeader(
                  avatar: avatar,
                  employerAvatar: employerAvatar,
                  name: name,
                  salary: salary,
                  title: title,
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Вакансия опубликована $date',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: colorTextSecondary,
                            ),
                      ),
                      const SizedBox(height: defaultPadding),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: defaultPadding / 2),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
