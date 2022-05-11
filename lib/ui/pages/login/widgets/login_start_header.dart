import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';

class LoginStartHeader extends StatelessWidget {
  const LoginStartHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Image.asset("assets/images/login_man.png")),
        const SizedBox(height: defaultPadding),
        Text(
          "Привет!",
          style: Theme.of(context).textTheme.headline1!.copyWith(
                color: colorAccentDarkBlue,
              ),
        ),
        const SizedBox(height: defaultPadding / 2),
        Text(
          "Авторизуйтесь, чтобы начать",
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
