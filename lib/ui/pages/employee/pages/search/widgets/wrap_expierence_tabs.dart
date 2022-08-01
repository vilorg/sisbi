import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/models/enum_classes.dart';
import 'package:sisbi/ui/pages/employee/pages/search/search_vacancy_page.dart';

class WrapExpierenceTabs extends StatelessWidget {
  const WrapExpierenceTabs({
    Key? key,
    required this.model,
  }) : super(key: key);

  final SearchViewModel model;

  @override
  Widget build(BuildContext context) {
    Expierence expierence = model.filter.expierence;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: defaultPadding),
          child: Text(
            "Опыт работы",
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const SizedBox(height: defaultPadding / 2),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 34,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: () => model.setExpierence(Expierence.no),
                child: _buildWrapCard(
                    context, "Нет опыта", expierence == Expierence.no),
              ),
              GestureDetector(
                onTap: () => model.setExpierence(Expierence.y_1_3),
                child: _buildWrapCard(
                    context, "1 - 3 года", expierence == Expierence.y_1_3),
              ),
              GestureDetector(
                onTap: () => model.setExpierence(Expierence.y_3_6),
                child: _buildWrapCard(
                    context, "3 - 6 лет", expierence == Expierence.y_3_6),
              ),
              GestureDetector(
                onTap: () => model.setExpierence(Expierence.more_6),
                child: _buildWrapCard(
                    context, "более 6 лет", expierence == Expierence.more_6),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Padding _buildWrapCard(BuildContext context, String title, bool isSelect) {
    return Padding(
      padding: const EdgeInsets.only(right: defaultPadding / 2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: isSelect ? null : Border.all(color: colorInput, width: 2),
          color: isSelect ? colorAccentLightBlue : Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isSelect ? colorTextContrast : colorText,
                ),
          ),
        ),
      ),
    );
  }
}
