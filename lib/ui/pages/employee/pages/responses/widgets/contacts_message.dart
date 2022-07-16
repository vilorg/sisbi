import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/models/vacancy_model.dart';

class ShowContactsVacancy extends StatelessWidget {
  const ShowContactsVacancy({
    Key? key,
    required this.vacancy,
  }) : super(key: key);

  final VacancyModel vacancy;

  @override
  Widget build(BuildContext context) => Container(
        height: 327.5,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: defaultPadding),
            Text(
              vacancy.employerName,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: defaultPadding),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(defaultPadding * 1.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: colorAccentLightBlue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/icons/phone_icon.svg"),
                  const SizedBox(width: defaultPadding / 2),
                  Text(
                    vacancy.phone,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorTextContrast,
                        ),
                  )
                ],
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(defaultPadding * 1.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(color: colorBorder),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/icons/main_icon.svg"),
                  const SizedBox(width: defaultPadding / 2),
                  Text(
                    vacancy.email,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  )
                ],
              ),
            ),
            const SizedBox(height: defaultPadding * 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.all(defaultButtonPadding),
                  child: Text(
                    "Закрыть",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
