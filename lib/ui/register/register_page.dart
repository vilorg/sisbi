import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/constants.dart';

import 'widgets/register_target.dart';
import 'widgets/register_top_info.dart';

class _ViewModel extends ChangeNotifier {}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => _ViewModel(),
        child: const RegisterPage(),
      );

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      RegisterTarget(
          key: const ValueKey(1),
          selectedIndex: selectedIndex,
          changeSelectedIndex: (i) => setState(() => selectedIndex = i)),
      RegisterTarget(
          key: const ValueKey(2),
          selectedIndex: selectedIndex,
          changeSelectedIndex: (i) => setState(() => selectedIndex = i)),
    ];

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        return true;
      },
      child: Scaffold(
        backgroundColor: colorAccentDarkBlue,
        body: Stack(
          children: [
            AnimatedSwitcher(
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final inAnimation = Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: const Offset(0.0, 0.0))
                      .animate(animation);
                  final outAnimation = Tween<Offset>(
                          begin: const Offset(-1.0, 0.0),
                          end: const Offset(0.0, 0.0))
                      .animate(animation);

                  if (child.key == ValueKey(selectedIndex)) {
                    return ClipRect(
                      child: SlideTransition(
                        position: inAnimation,
                        child: child,
                      ),
                    );
                  } else {
                    return ClipRect(
                      child: SlideTransition(
                        position: outAnimation,
                        child: child,
                      ),
                    );
                  }
                },
                duration: const Duration(seconds: 1),
                child: widgets[selectedIndex],
                layoutBuilder:
                    (Widget? currentChild, List<Widget> previousChildren) {
                  List<Widget> children = previousChildren;
                  if (currentChild != null) {
                    children = children.toList()..add(currentChild);
                  }
                  return Stack(
                    children: children,
                    alignment: Alignment.center,
                  );
                }),
            RegisterTopInfo(
              setSelectedIndex: (bool isLow) {
                if (isLow && (selectedIndex - 1) >= 0) {
                  setState(() => selectedIndex -= 1);
                } else if (!isLow && (selectedIndex + 1) <= 1) {
                  setState(() => selectedIndex += 1);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
