// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/vacancy_model.dart';

class ActionsMessage extends StatelessWidget {
  final VacancyModel vacancy;
  const ActionsMessage({
    Key? key,
    required this.vacancy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Column(
        children: [
          const SizedBox(height: defaultPadding),
          Container(
            width: 50,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          const Divider(),
          Tile(
            title: "Перейти в вакансию",
            asset: "assets/icons/arrow_forward.svg",
            isTrash: false,
            onTap: () {},
          ),
          const Divider(),
          Tile(
            title: "Посмотреть контакты",
            asset: "assets/icons/arrow_forward.svg",
            isTrash: false,
            onTap: () {},
          ),
          const Divider(),
          Tile(
            title: "Удалить чат",
            asset: "assets/icons/trash.svg",
            isTrash: true,
            onTap: () {},
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.title,
    required this.asset,
    required this.isTrash,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String asset;
  final bool isTrash;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: isTrash ? colorAccentRed : colorText),
            ),
            SvgPicture.asset(asset),
          ],
        ),
      ),
    );
  }
}
