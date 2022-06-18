import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/models/object_id.dart';
import 'package:sisbi/ui/pages/employee/pages/search/job_categories_search_page.dart';
import 'package:sisbi/ui/pages/employee/pages/search/search_vacancy_page.dart';

class FieldsOfActivityTabs extends StatelessWidget {
  const FieldsOfActivityTabs({
    Key? key,
    required this.model,
  }) : super(key: key);

  final SearchViewModel model;

  @override
  Widget build(BuildContext context) {
    List<ObjectId> fromArr = model.filter.jobCategory;

    List<Widget> data = [];

    for (var i in fromArr) {
      data.add(
        Padding(
          padding: const EdgeInsets.only(bottom: defaultPadding / 2),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorAccentLightBlue,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: const EdgeInsets.all(defaultButtonPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    i.value,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: colorTextContrast,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                    maxLines: 1,
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  width: 15,
                  child: GestureDetector(
                      onTap: () => model.setJobCategory(i, true),
                      child: const Icon(
                        Icons.clear,
                        color: colorIconContrast,
                        size: 15,
                      )),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Сфера деятельности",
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: defaultPadding / 2),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    JobCategoriesSearchPage.create(model),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: colorInput, width: 2),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              padding: const EdgeInsets.all(defaultButtonPadding),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/add.svg"),
                  const SizedBox(width: defaultPadding / 2),
                  Text(
                    "Добавить сферу деятельности",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: colorText,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ...data,
        ],
      ),
    );
  }
}
