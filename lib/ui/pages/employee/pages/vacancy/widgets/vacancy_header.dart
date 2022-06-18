import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/vacancy_model.dart';
import 'package:sisbi/ui/inherited_widgets/home_inherited_widget.dart';
import 'package:sisbi/ui/inherited_widgets/vacacy_inherited_widget.dart';

import 'vacancy_action_buttons.dart';
import 'wrap_vacancy_cards.dart';

class VacancyHeader extends StatelessWidget {
  const VacancyHeader({Key? key, required this.vacancy}) : super(key: key);

  final VacancyModel vacancy;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height -
          HomeInheritedWidget.of(context)!.verticalPadding -
          VacancyInheritedWidget.of(context)!.appBarHeight -
          60,
      decoration: const BoxDecoration(
        color: colorAccentDarkBlue,
      ),
      child: Stack(
        children: [
          Image.network(
            vacancy.avatar,
            fit: BoxFit.cover,
            width: double.infinity,
            height: MediaQuery.of(context).size.height -
                HomeInheritedWidget.of(context)!.verticalPadding -
                VacancyInheritedWidget.of(context)!.appBarHeight -
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
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(300),
                        child: Image.network(
                          vacancy.employerAvatar,
                          width: 25,
                        ),
                      ),
                      const SizedBox(width: defaultPadding / 2),
                      Text(
                        vacancy.fullName,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: colorTextContrast,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    vacancy.title,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: colorTextContrast,
                        ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    "От ${vacancy.salary}  руб.",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: colorTextContrast,
                        ),
                  ),
                  const SizedBox(height: defaultPadding),
                  WrapVacancyCards(vacancy: vacancy),
                  const SizedBox(height: 2 * defaultPadding),
                  const VacancyActionButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
