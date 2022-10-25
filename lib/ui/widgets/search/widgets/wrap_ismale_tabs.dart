import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/models/enum_classes.dart';
import 'package:sisbi/ui/widgets/search/search_page.dart';

class WrapIsMaleTabs extends StatelessWidget {
  const WrapIsMaleTabs({
    Key? key,
    required this.model,
  }) : super(key: key);

  final SearchViewModel model;

  @override
  Widget build(BuildContext context) {
    bool isMan = model.filter.isMan;
    bool isWoman = model.filter.isWoman;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: defaultPadding),
          child: Text(
            "Пол",
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
                onTap: () => model.setMale(!isMan, isWoman),
                child: _buildWrapCard(context, "Мужской", isMan),
              ),
              GestureDetector(
                onTap: () => model.setMale(isMan, !isWoman),
                child: _buildWrapCard(
                  context,
                  "Женский",
                  isWoman,
                ),
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
