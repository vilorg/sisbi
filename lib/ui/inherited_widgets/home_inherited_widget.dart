import 'package:flutter/material.dart';

class HomeInheritedWidget extends InheritedWidget {
  const HomeInheritedWidget({
    Key? key,
    required Widget child,
    required this.size,
    required this.verticalPadding,
    required this.isEmployer,
    required this.timeDifference,
    required this.token,
  }) : super(key: key, child: child);

  final Size size;
  final double verticalPadding;
  final bool isEmployer;
  final Duration timeDifference;
  final String token;

  static HomeInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<HomeInheritedWidget>();
  }

  @override
  bool updateShouldNotify(HomeInheritedWidget oldWidget) {
    if (oldWidget.verticalPadding != verticalPadding ||
        oldWidget.isEmployer != isEmployer ||
        oldWidget.size != size ||
        oldWidget.timeDifference != timeDifference ||
        oldWidget.token != token) return true;
    return false;
  }
}
