import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/ui/pages/employee/pages/vacancy/vacancy_page.dart';

import 'card_action_buttons.dart';
import 'wrap_cards.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.vertical -
          VacancyInheritedWidget.of(context)!.appBarHeight -
          60,
      decoration: const BoxDecoration(
        color: colorAccentDarkBlue,
      ),
      child: Stack(
        children: [
          Image.asset(
            "assets/images/сard_preview.png",
            fit: BoxFit.cover,
            width: double.infinity,
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
                      Image.asset(
                        "assets/images/logo.png",
                        width: 25,
                      ),
                      const SizedBox(width: defaultPadding / 2),
                      Text(
                        'Рич Фэмили',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: colorTextContrast,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    'UI/UX дизайнер',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: colorTextContrast,
                        ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    'от 45 000 до 65 000 руб ',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: colorTextContrast,
                        ),
                  ),
                  const SizedBox(height: defaultPadding),
                  const WrapCards(),
                  const SizedBox(height: 2 * defaultPadding),
                  const CardActionButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
