import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';

class Rates extends StatelessWidget {
  const Rates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(borderRadiusPage)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: const [
              _RatesWidget(),
              _RatesWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RatesWidget extends StatelessWidget {
  const _RatesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: defaultPadding,
        right: defaultPadding,
        bottom: defaultPadding,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: colorAccentLightBlue, width: 1.5),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorAccentDarkBlue,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: defaultPadding / 4,
                horizontal: defaultPadding / 2,
              ),
              child: Text(
                "700 руб.",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: colorTextContrast,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            Text(
              "Тариф “Все отклики на все вакансии”",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: defaultPadding),
            Text(
              "Получите доступ ко всем откликам на все вакансии + на все отклики, которые будут поступать следующие 7 дней",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: colorTextSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
