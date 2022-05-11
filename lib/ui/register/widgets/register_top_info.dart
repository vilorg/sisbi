import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';

class RegisterTopInfo extends StatelessWidget {
  const RegisterTopInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var buttonWidth =
        (MediaQuery.of(context).size.width - 3 * defaultPadding) / 2;

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 246,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Выйти",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultButtonPadding),
                      child: Text(
                        "Назад",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    style:
                        Theme.of(context).elevatedButtonTheme.style!.copyWith(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(color: colorButtonSecondary),
                              ),
                            ),
                  ),
                ),
                SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultButtonPadding),
                      child: Text(
                        "Продолжить",
                        style: Theme.of(context).textTheme.button!.copyWith(
                              color: colorAccentDarkBlue,
                            ),
                      ),
                    ),
                    style:
                        Theme.of(context).elevatedButtonTheme.style!.copyWith(
                              backgroundColor:
                                  MaterialStateProperty.all(colorTextContrast),
                            ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
