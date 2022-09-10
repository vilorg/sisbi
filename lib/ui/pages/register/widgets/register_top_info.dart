import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/ui/pages/register/register_view_model.dart';

class RegisterTopInfo extends StatelessWidget {
  final int length;
  final Function(bool) setSelectedIndex;

  const RegisterTopInfo({
    Key? key,
    required this.length,
    required this.setSelectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = context.read<RegisterViewModel>();
    var state = context.select((RegisterViewModel model) => model.state);

    var selectedIndex = state.selectedIndex;

    var buttonWidth =
        (MediaQuery.of(context).size.width - 3 * defaultPadding) / 2;

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
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
                        flex: selectedIndex + 1,
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(borderRadius),
                              color: colorAccentDarkBlue),
                        ),
                      ),
                      Flexible(
                        flex: length - selectedIndex - 1,
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
          selectedIndex == (length - 1) ? const SizedBox() : const Divider(),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: selectedIndex == (length - 1)
                ? SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: model.saveUser,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultButtonPadding),
                        child: Text(
                          model.state.isUser
                              ? "Искать работу"
                              : "Поиск сотрудников",
                          style: Theme.of(context).textTheme.button!.copyWith(
                                color: colorAccentDarkBlue,
                              ),
                        ),
                      ),
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style!
                          .copyWith(
                            backgroundColor:
                                MaterialStateProperty.all(colorTextContrast),
                          ),
                    ),
                  )
                : Row(
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
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
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
                              style:
                                  Theme.of(context).textTheme.button!.copyWith(
                                        color: colorAccentDarkBlue,
                                      ),
                            ),
                          ),
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                backgroundColor: MaterialStateProperty.all(
                                    colorTextContrast),
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
