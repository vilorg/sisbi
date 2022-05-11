import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sisbi/constants.dart';

class RegisterTarget extends StatelessWidget {
  const RegisterTarget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset("assets/images/register_top_circle.png",
                width: double.infinity),
            Padding(
                padding: const EdgeInsets.only(bottom: 3 * defaultPadding),
                child: Image.asset("assets/images/register_target.png")),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Text(
                "Какая у вас цель?",
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: colorTextContrast,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: defaultPadding),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: colorInputActive,
                ),
                padding: const EdgeInsets.all(defaultPadding * 1.3),
                child: Row(
                  children: [
                    Text(
                      "Я ищу работу",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: colorTextContrast,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const Spacer(),
                    SvgPicture.asset("assets/icons/register_done.svg"),
                  ],
                ),
              ),
              const SizedBox(height: defaultPadding / 2),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(color: colorTextContrast),
                ),
                padding: const EdgeInsets.all(defaultPadding * 1.3),
                child: Row(
                  children: [
                    Text(
                      "Я ищу сотрудников",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: colorTextContrast,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
