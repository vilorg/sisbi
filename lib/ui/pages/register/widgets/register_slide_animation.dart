import 'package:flutter/material.dart';

class RegisterSlideAnimation extends StatelessWidget {
  const RegisterSlideAnimation({
    Key? key,
    required this.selectedIndex,
    required this.lastIndex,
    required this.widgets,
  }) : super(key: key);

  final int selectedIndex;
  final int lastIndex;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        transitionBuilder: (Widget child, Animation<double> animation) {
          final inAnimation = Tween<Offset>(
                  begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
              .animate(animation);
          final outAnimation = Tween<Offset>(
                  begin: const Offset(-1.0, 0.0), end: const Offset(0.0, 0.0))
              .animate(animation);

          if (child.key == ValueKey(selectedIndex)) {
            return ClipRect(
              child: SlideTransition(
                position:
                    lastIndex > selectedIndex ? outAnimation : inAnimation,
                child: child,
              ),
            );
          } else {
            return ClipRect(
              child: SlideTransition(
                position:
                    lastIndex > selectedIndex ? inAnimation : outAnimation,
                child: child,
              ),
            );
          }
        },
        duration: const Duration(milliseconds: 200),
        child: widgets[selectedIndex],
        layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
          List<Widget> children = previousChildren;
          if (currentChild != null) {
            children = children.toList()..add(currentChild);
          }
          return Stack(
            children: children,
            alignment: Alignment.center,
          );
        });
  }
}
