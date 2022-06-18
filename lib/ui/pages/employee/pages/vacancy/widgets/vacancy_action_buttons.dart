import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/ui/pages/employee/pages/vacancy/vacancuies_switcher_view_model.dart';

class VacancyActionButtons extends StatelessWidget {
  const VacancyActionButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<VacanciesSwitcherViewModel>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: model.resetLast,
          child: SvgPicture.asset(
            "assets/icons/action_return.svg",
          ),
        ),
        GestureDetector(
          onTap: () {
            model.nextCard();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: colorAccentRed,
                content: Text(
                  "Вакансия пропущена",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: colorTextContrast,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            );
          },
          child: SvgPicture.asset(
            "assets/icons/action_skip.svg",
          ),
        ),
        GestureDetector(
          onTap: model.starVacancy,
          child: SvgPicture.asset(
            "assets/icons/action_favourite.svg",
          ),
        ),
        GestureDetector(
          onTap: model.trySendMessage,
          child: SvgPicture.asset(
            "assets/icons/action_message.svg",
          ),
        ),
        GestureDetector(
          onTap: model.showContacts,
          child: SvgPicture.asset(
            "assets/icons/action_call.svg",
          ),
        ),
      ],
    );
  }
}