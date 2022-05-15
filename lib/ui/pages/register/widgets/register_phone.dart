import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/ui/pages/register/register_view_model.dart';

class RegisterPhone extends StatelessWidget {
  const RegisterPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = context.read<RegisterViewModel>();
    var state = context.select((RegisterViewModel model) => model.state);

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
                  "Введите номер телефона",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: colorTextContrast,
                      ),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  cursorColor: colorText,
                  cursorWidth: 1,
                  controller: model.controller,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(defaultPadding * 0.8),
                      child: SvgPicture.asset(
                        "assets/icons/login_phone.svg",
                        color: state.phoneError.isEmpty
                            ? colorText
                            : colorInputError,
                      ),
                    ),
                    suffixIcon: state.phone != ""
                        ? InkWell(
                            onTap: () {
                              model.clearPhone();
                              model.controller.clear();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(defaultPadding * 0.8),
                              child: SvgPicture.asset(
                                  "assets/icons/login_clear.svg",
                                  color: state.phoneError.isEmpty
                                      ? colorAccentLightBlue
                                      : colorInputError),
                            ),
                          )
                        : null,
                    hintText: "+7 │ Номер телефона",
                    errorText:
                        state.phoneError.isEmpty ? null : state.phoneError,
                    errorStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: colorInputError,
                        ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [phoneMask],
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: state.phoneError.isEmpty
                            ? colorText
                            : colorInputError,
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
