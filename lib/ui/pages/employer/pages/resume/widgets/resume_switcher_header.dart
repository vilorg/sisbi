import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/user_data_model.dart';
import 'package:sisbi/ui/inherited_widgets/home_inherited_widget.dart';
import 'package:sisbi/ui/inherited_widgets/vacacy_inherited_widget.dart';

import 'resume_action_buttons.dart';
import 'wrap_resume_cards.dart';

class ResumeSwitcherHeader extends StatelessWidget {
  const ResumeSwitcherHeader({Key? key, required this.resume})
      : super(key: key);

  final UserDataModel resume;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height -
          HomeInheritedWidget.of(context)!.verticalPadding -
          VacancyInheritedWidget.of(context)!.appBarHeight -
          55,
      decoration: const BoxDecoration(
        color: colorAccentDarkBlue,
      ),
      child: Stack(
        children: [
          resume.avatar == ""
              ? Image.asset(
                  "assets/images/resume.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height -
                      HomeInheritedWidget.of(context)!.verticalPadding -
                      VacancyInheritedWidget.of(context)!.appBarHeight -
                      55,
                  alignment: Alignment.center,
                )
              : Image.network(
                  resume.avatar,
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
                  Text(
                    "${resume.firstName} ${resume.surname}",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: colorTextContrast,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    resume.previusJob,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: colorTextContrast,
                        ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(resume.skills.join(", "),
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: colorTextContrast,
                          )),
                  const SizedBox(height: defaultPadding),
                  Text(
                    "От ${resume.coast} руб.",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: colorTextContrast,
                        ),
                  ),
                  const SizedBox(height: defaultPadding),
                  WrapResumeCards(userData: resume),
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
