// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sisbi/constants.dart';

class SelectWrapCard extends StatelessWidget {
  final String title;
  final String? value;
  final VoidCallback? onTap;
  const SelectWrapCard({
    Key? key,
    required this.title,
    this.value,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 4,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorInput,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.all(defaultButtonPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: colorInputContent,
                    ),
              ),
              value != null
                  ? Row(
                      children: [
                        Text(
                          value!,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: colorText,
                                  ),
                        ),
                        onTap != null
                            ? SvgPicture.asset(
                                "assets/icons/arrow_right.svg",
                                color: colorText,
                              )
                            : const SizedBox(),
                      ],
                    )
                  : Row(
                      children: [
                        Text(
                          "Не указано",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: colorIconSecondary,
                                  ),
                        ),
                        onTap != null
                            ? SvgPicture.asset(
                                "assets/icons/arrow_right.svg",
                                color: colorIconSecondary,
                              )
                            : const SizedBox(),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
