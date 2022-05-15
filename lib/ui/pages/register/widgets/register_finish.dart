import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';

class RegisterFinish extends StatelessWidget {
  const RegisterFinish({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/register_final.png"),
          const SizedBox(height: defaultPadding),
          Text(
            "Поздравляем, вы успешно прошли регистрацию!",
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: colorTextContrast,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
