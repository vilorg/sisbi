import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/user_data_model.dart';
import 'package:sisbi/models/vacancy_model.dart';
import 'vacancy_static_header.dart';

class VacancyStaticCard extends StatelessWidget {
  const VacancyStaticCard({
    Key? key,
    required this.vacancy,
    required this.userData,
  }) : super(key: key);

  final VacancyModel vacancy;
  final UserDataModel userData;

  @override
  Widget build(BuildContext context) {
    final date = vacancy.createdAt.substring(0, 10);
    return ClipRRect(
      borderRadius:
          const BorderRadius.vertical(top: Radius.circular(borderRadius)),
      child: ColoredBox(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VacancyStaticHeader(vacancy: vacancy, userData: userData),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Вакансия опубликована $date в ${vacancy.cityName}',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: colorTextSecondary,
                          ),
                    ),
                    const SizedBox(height: defaultPadding),
                    Text(
                      vacancy.title,
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    Text(
                      vacancy.description,
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
