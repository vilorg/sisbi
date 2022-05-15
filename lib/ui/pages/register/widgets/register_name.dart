import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/ui/pages/register/register_view_model.dart';

class RegisterName extends StatelessWidget {
  const RegisterName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = context.read<RegisterViewModel>();

    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: SvgPicture.asset(
            "assets/icons/register_spiral_top.svg",
            alignment: Alignment.topRight,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: SvgPicture.asset(
            "assets/icons/register_spiral_bottom.svg",
            alignment: Alignment.bottomLeft,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Как вас зовут?",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: colorTextContrast,
                      ),
                ),
                const SizedBox(height: defaultPadding),
                TextField(
                  cursorColor: colorText,
                  cursorWidth: 1,
                  decoration: const InputDecoration(
                    hintText: "Имя",
                  ),
                  keyboardType: TextInputType.name,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: colorText,
                      ),
                  onChanged: model.setFirstName,
                ),
                const SizedBox(height: defaultPadding),
                TextField(
                  cursorColor: colorText,
                  cursorWidth: 1,
                  decoration: const InputDecoration(
                    hintText: "Фамилия",
                  ),
                  keyboardType: TextInputType.name,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: colorText,
                      ),
                  onChanged: model.setSurName,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
