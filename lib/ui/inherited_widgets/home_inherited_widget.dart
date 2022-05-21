import 'package:flutter/material.dart';

class HomeInheritedWidget extends InheritedWidget {
  const HomeInheritedWidget({
    Key? key,
    required Widget child,
    required this.verticalPadding,
    required this.isEmployer,
  }) : super(key: key, child: child);

  final double verticalPadding;
  final bool isEmployer;

  static HomeInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<HomeInheritedWidget>();
  }

  @override
  bool updateShouldNotify(HomeInheritedWidget oldWidget) {
    if (oldWidget.verticalPadding != verticalPadding ||
        oldWidget.isEmployer != isEmployer) return true;
    return false;
  }
}
