import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/ui/pages/register/register_page.dart';

class RegisterPhone extends StatelessWidget {
  final RegisterViewModel model;
  final TextEditingController controller;
  final VoidCallback clearControllerValue;
  final bool isValue;
  final String textError;

  const RegisterPhone({
    Key? key,
    required this.model,
    required this.controller,
    required this.clearControllerValue,
    required this.isValue,
    required this.textError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SvgPicture.asset(
            "assets/icons/register_spiral_top.svg",
            alignment: Alignment.topCenter,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SvgPicture.asset(
            "assets/icons/register_spiral_bottom.svg",
            alignment: Alignment.bottomCenter,
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
                  "Введите номер телефона",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: colorTextContrast,
                      ),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  cursorColor: colorText,
                  cursorWidth: 1,
                  controller: controller,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(defaultPadding * 0.8),
                      child: SvgPicture.asset(
                        "assets/icons/login_phone.svg",
                        color: textError.isEmpty ? colorText : colorInputError,
                      ),
                    ),
                    suffixIcon: isValue
                        ? InkWell(
                            onTap: () {
                              model.clearPhone();
                              clearControllerValue();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(defaultPadding * 0.8),
                              child: SvgPicture.asset(
                                  "assets/icons/login_clear.svg",
                                  color: textError.isEmpty
                                      ? colorAccentLightBlue
                                      : colorInputError),
                            ),
                          )
                        : null,
                    hintText: "+7 │ Номер телефона",
                    errorText: textError.isEmpty ? null : textError,
                    errorStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: colorInputError,
                        ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [phoneMask],
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: textError.isEmpty ? colorText : colorInputError,
                      ),
                  onChanged: model.setPhone,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
