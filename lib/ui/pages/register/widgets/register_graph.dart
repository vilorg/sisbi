import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/ui/pages/register/register_view_model.dart';

import 'register_wrap_item_picker.dart';

class RegisterGraph extends StatelessWidget {
  const RegisterGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = context.read<RegisterViewModel>();
    var state = context.select((RegisterViewModel model) => model.state);

    List<int> selectedSchedulese = state.schedules;
    List<int> selectedTypeEmployments = state.typeEmployments;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Условия работы",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: colorTextContrast,
                        ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                Text(
                  "График работы",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: colorTextContrast,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: defaultPadding),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    RegisterWrapItemPicker(
                      text: "Удаленная работа",
                      isSelect: selectedSchedulese.contains(0),
                      onTap: () => model.setSchedules(0),
                    ),
                    RegisterWrapItemPicker(
                      text: "Полный день",
                      isSelect: selectedSchedulese.contains(1),
                      onTap: () => model.setSchedules(1),
                    ),
                    RegisterWrapItemPicker(
                      text: "Сменный график",
                      isSelect: selectedSchedulese.contains(2),
                      onTap: () => model.setSchedules(2),
                    ),
                    RegisterWrapItemPicker(
                      text: "Гибкий график",
                      isSelect: selectedSchedulese.contains(3),
                      onTap: () => model.setSchedules(3),
                    ),
                  ],
                ),
                const SizedBox(height: defaultPadding),
                Text(
                  "График работы",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: colorTextContrast,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: defaultPadding),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    RegisterWrapItemPicker(
                      text: "Полная занятость",
                      isSelect: selectedTypeEmployments.contains(0),
                      onTap: () => model.setTypeEmployments(0),
                    ),
                    RegisterWrapItemPicker(
                      text: "Частичная занятость",
                      isSelect: selectedTypeEmployments.contains(1),
                      onTap: () => model.setTypeEmployments(1),
                    ),
                    RegisterWrapItemPicker(
                      text: "Проектная работа",
                      isSelect: selectedTypeEmployments.contains(2),
                      onTap: () => model.setTypeEmployments(2),
                    ),
                    RegisterWrapItemPicker(
                      text: "Стажировка",
                      isSelect: selectedTypeEmployments.contains(3),
                      onTap: () => model.setTypeEmployments(3),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
