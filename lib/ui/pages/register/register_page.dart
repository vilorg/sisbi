import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/ui/pages/register/widgets/register_birthday.dart';
import 'package:sisbi/ui/pages/register/widgets/register_code.dart';
import 'package:sisbi/ui/pages/register/widgets/register_email.dart';
import 'package:sisbi/ui/pages/register/widgets/register_finish.dart';
import 'package:sisbi/ui/pages/register/widgets/register_gender.dart';
import 'package:sisbi/ui/pages/register/widgets/register_graph.dart';
import 'package:sisbi/ui/pages/register/widgets/register_name.dart';
import 'package:sisbi/ui/pages/register/widgets/register_name_company.dart';
import 'package:sisbi/ui/pages/register/widgets/register_phone.dart';
import 'package:sisbi/ui/pages/register/widgets/register_skills.dart';

import 'register_view_model.dart';
import 'widgets/register_slide_animation.dart';
import 'widgets/register_target.dart';
import 'widgets/register_top_info.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => RegisterViewModel(context),
      child: const RegisterPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = context.select((RegisterViewModel model) => model.state);
    var model = context.read<RegisterViewModel>();

    int selectedIndex = state.selectedIndex;
    int lastIndex = state.lastIndex;
    bool isUser = state.isUser;

    List<Widget> widgets = [
      RegisterTarget(
        key: const ValueKey(0),
        isUser: state.isUser,
        changeIsUser: model.setIsUser,
      ),
      const RegisterPhone(key: ValueKey(1)),
      const RegisterCode(key: ValueKey(2)),
      const RegisterEmail(key: ValueKey(3)),
      RegisterGender(
        key: const ValueKey(4),
        isMale: state.isMale,
        changeIsMale: model.setIsMale,
      ),
      const RegisterName(key: ValueKey(5)),
      const RegisterBirthday(key: ValueKey(6)),
      const RegisterSkills(key: ValueKey(7)),
      const RegisterGraph(key: ValueKey(8)),
      const RegisterFinish(key: ValueKey(9)),
    ];
    if (!isUser) {
      widgets = [
        RegisterTarget(
          key: const ValueKey(0),
          isUser: state.isUser,
          changeIsUser: model.setIsUser,
        ),
        const RegisterPhone(key: ValueKey(1)),
        const RegisterCode(key: ValueKey(2)),
        const RegisterEmail(key: ValueKey(3)),
        const RegisterNameCompany(key: ValueKey(4)),
        const RegisterFinish(key: ValueKey(5)),
      ];
    }

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
              length: widgets.length,
              setSelectedIndex: (bool isLow) {
                if (isLow) {
                  if ((selectedIndex - 1) >= 0) {
                    model.previousPage();
                    return null;
                  } else {
                    Navigator.of(context).pop();
                    return null;
                  }
                } else if (!isLow && (selectedIndex + 1) < widgets.length) {
                  if (selectedIndex == 1) {
                    model.onSubmitPhoneButton();
                    return null;
                  } else if (selectedIndex == 2) {
                    return null;
                  } else if (selectedIndex == 3) {
                    model.validateEmail();
                    return null;
                  } else if (selectedIndex == 4 && !isUser) {
                    model.validateCompanyName();
                    return null;
                  } else if (selectedIndex == 5 && isUser) {
                    model.validateName();
                    return null;
                  } else if (selectedIndex == 7 && isUser) {
                    model.validateSkills();
                    return null;
                  }
                  model.nextPage();
                  return null;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
