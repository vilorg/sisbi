import 'package:flutter/material.dart';

class VacancyInheritedWidget extends InheritedWidget {
  const VacancyInheritedWidget({
    Key? key,
    required this.appBarHeight,
    required Widget child,
  }) : super(key: key, child: child);

  final double appBarHeight;

  static VacancyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VacancyInheritedWidget>();
  }

  @override
  bool updateShouldNotify(VacancyInheritedWidget oldWidget) {
    if (oldWidget.appBarHeight != appBarHeight) return true;
    return false;
  }
}
