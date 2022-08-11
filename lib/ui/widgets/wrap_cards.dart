// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';

class WrapTabs extends StatelessWidget {
  const WrapTabs({
    Key? key,
    required this.title,
    required this.variants,
    required this.values,
    required this.setValue,
  }) : super(key: key);

  final String title;
  final List<String> variants;
  final List<bool> values;
  final Function(int) setValue;

  @override
  Widget build(BuildContext context) {
    List<Widget> data = [];

    for (int i = 0; i < variants.length; i++) {
      data.add(
          _buildWrapCard(context, variants[i], values[i], () => setValue(i)));
    }

    // [
    //           GestureDetector(
    //             onTap: () => model.setExpierence(Expierence.no),
    //             child: _buildWrapCard(
    //                 context, "Нет опыта", expierence == Expierence.no),
    //           ),
    //           GestureDetector(
    //             onTap: () => model.setExpierence(Expierence.y_1_3),
    //             child: _buildWrapCard(
    //                 context, "1 - 3 года", expierence == Expierence.y_1_3),
    //           ),
    //           GestureDetector(
    //             onTap: () => model.setExpierence(Expierence.y_2_6),
    //             child: _buildWrapCard(
    //                 context, "3 - 6 лет", expierence == Expierence.y_2_6),
    //           ),
    //           GestureDetector(
    //             onTap: () => model.setExpierence(Expierence.more_6),
    //             child: _buildWrapCard(
    //                 context, "более 6 лет", expierence == Expierence.more_6),
    //           ),
    //         ]

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: defaultPadding),
            child: Text(
              title,
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
              children: data,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWrapCard(
      BuildContext context, String title, bool isSelect, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: defaultPadding / 2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: isSelect
                ? Border.all(color: Colors.transparent, width: 2)
                : Border.all(color: colorInput, width: 2),
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
      ),
    );
  }
}
