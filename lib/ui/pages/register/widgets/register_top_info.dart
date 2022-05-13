import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sisbi/constants.dart';

class RegisterTopInfo extends StatelessWidget {
  final int selecterIndex;
  final Function(bool) setSelectedIndex;

  const RegisterTopInfo({
    Key? key,
    required this.selecterIndex,
    required this.setSelectedIndex,
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
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    children: [
                      Flexible(
                        flex: selecterIndex + 1,
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(borderRadius),
                              color: colorAccentDarkBlue),
                        ),
                      ),
                      Flexible(
                        flex: 10 - selecterIndex,
                        child: const SizedBox(),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    SystemChrome.setSystemUIOverlayStyle(
                        SystemUiOverlayStyle.dark);
                    Navigator.pop(context);
                  },
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
                    onPressed: () => setSelectedIndex(true),
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
                    onPressed: () => setSelectedIndex(false),
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
