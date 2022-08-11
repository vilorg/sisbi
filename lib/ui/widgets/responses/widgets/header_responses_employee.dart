import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sisbi/constants.dart';

class HeaderResponsesEmployee extends StatelessWidget {
  const HeaderResponsesEmployee({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(defaultPadding),
              hintText: "Название вакансии, компании",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding * 0.8),
                child: SvgPicture.asset(
                  "assets/icons/prefix_search.svg",
                  color: colorInputContent,
                ),
              ),
            ),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Показывать:",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: colorTextContrast,
                    ),
              ),
              Row(
                children: [
                  Text(
                    "Все отклики",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: colorTextContrast,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: colorIconContrast),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
