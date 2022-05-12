import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/constants.dart';

import 'widgets/register_slide_animation.dart';
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
  int lastIndex = 0;
  int selectedIndex = 0;
  int selectedItem1 = 0;
  int selectedItem2 = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      RegisterTarget(
          key: const ValueKey(0),
          selectedIndex: selectedItem1,
          changeSelectedIndex: (i) => setState(() => selectedItem1 = i)),
      RegisterTarget(
          key: const ValueKey(1),
          selectedIndex: selectedItem2,
          changeSelectedIndex: (i) => setState(() => selectedItem2 = i)),
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
            RegisterSlideAnimation(
              selectedIndex: selectedIndex,
              lastIndex: lastIndex,
              widgets: widgets,
            ),
            RegisterTopInfo(
              selecterIndex: selectedIndex,
              setSelectedIndex: (bool isLow) {
                if (isLow && (selectedIndex - 1) >= 0) {
                  setState(() {
                    lastIndex = selectedIndex;
                    selectedIndex -= 1;
                  });
                } else if (!isLow && (selectedIndex + 1) <= 1) {
                  setState(() {
                    lastIndex = selectedIndex;
                    selectedIndex += 1;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
