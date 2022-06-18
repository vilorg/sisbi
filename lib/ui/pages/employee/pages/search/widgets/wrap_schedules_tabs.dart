import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/models/object_id.dart';
import 'package:sisbi/ui/pages/employee/pages/search/search_vacancy_page.dart';

class WrapSchedulesTabs extends StatelessWidget {
  const WrapSchedulesTabs({
    Key? key,
    required this.model,
  }) : super(key: key);

  final SearchViewModel model;

  @override
  Widget build(BuildContext context) {
    final List<ObjectId> data = model.filter.schedules;
    List<bool> values = [false, false, false, false];
    List<String> titles = [
      "Удаленная работа",
      "Полный день",
      "Гибкий график",
      "Сменный график"
    ];

    for (int i = 0; i < titles.length; i++) {
      for (var j in data) {
        if (j.id == i) {
          values[i] = true;
          break;
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: defaultPadding),
          child: Text(
            "График работы",
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
                onTap: () => model.setSchedules(ObjectId(0, titles[0])),
                child: _buildWrapCard(context, titles[0], values[0]),
              ),
              GestureDetector(
                onTap: () => model.setSchedules(ObjectId(1, titles[1])),
                child: _buildWrapCard(context, titles[1], values[1]),
              ),
              GestureDetector(
                onTap: () => model.setSchedules(ObjectId(2, titles[2])),
                child: _buildWrapCard(context, titles[2], values[2]),
              ),
              GestureDetector(
                onTap: () => model.setSchedules(ObjectId(3, titles[3])),
                child: _buildWrapCard(context, titles[3], values[3]),
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
