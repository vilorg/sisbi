import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';

class WrapCards extends StatelessWidget {
  const WrapCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      runSpacing: defaultPadding / 2,
      spacing: defaultPadding / 2,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorAccentDarkBlue,
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
            "Опыт от 3 лет",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
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
            "Полный день",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
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
            "Удаленная работа",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
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
            "Любой город",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }
}
