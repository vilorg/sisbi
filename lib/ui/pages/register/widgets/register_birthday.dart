import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/ui/pages/register/register_view_model.dart';

class RegisterBirthday extends StatelessWidget {
  const RegisterBirthday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = context.read<RegisterViewModel>();

    return Column(
      children: [
        const _Header(),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Text(
                "Дата вашего рождения",
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: colorTextContrast,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: defaultPadding),
              SizedBox(
                child: CupertinoTheme(
                  data: const CupertinoThemeData(
                    brightness: Brightness.dark,
                  ),
                  child: CupertinoDatePicker(
                    onDateTimeChanged: model.setBirthday,
                    mode: CupertinoDatePickerMode.date,
                    maximumYear: 2010,
                    minimumYear: 1950,
                    initialDateTime: DateTime(2000),
                  ),
                ),
                height: 150,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset("assets/images/register_top_circle.png",
            width: double.infinity),
        Padding(
            padding: const EdgeInsets.only(bottom: 3 * defaultPadding),
            child: Image.asset(
              "assets/images/register_birthday.png",
              width: MediaQuery.of(context).size.width / 1.5,
            )),
      ],
    );
  }
}
