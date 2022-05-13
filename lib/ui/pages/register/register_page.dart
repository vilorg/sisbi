import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/auth_service.dart';
import 'package:sisbi/ui/pages/register/widgets/register_phone.dart';

import 'widgets/register_slide_animation.dart';
import 'widgets/register_target.dart';
import 'widgets/register_top_info.dart';

class _ViewModelState {
  final bool isUser;
  final String phone;
  final String phoneError;
  final List<String> code;
  final String codeError;
  final String email;
  final bool isMale;
  final String firstName;
  final String surName;
  final DateTime? birthDay;
  final String skills;
  final int experience;

  _ViewModelState({
    this.isUser = true,
    this.phone = "",
    this.phoneError = "",
    this.code = const ["", "", "", ""],
    this.codeError = "",
    this.email = "",
    this.isMale = true,
    this.firstName = "",
    this.surName = "",
    this.birthDay,
    this.skills = "",
    this.experience = 0,
  });

  _ViewModelState copyWith({
    bool? isUser,
    String? phone,
    String? phoneError,
    List<String>? code,
    String? codeError,
    String? email,
    bool? isMale,
    String? firstName,
    String? surName,
    DateTime? birthDay,
    String? skills,
    int? experience,
  }) {
    return _ViewModelState(
      isUser: isUser ?? this.isUser,
      phone: phone ?? this.phone,
      phoneError: phoneError ?? this.phoneError,
      code: code ?? this.code,
      codeError: codeError ?? this.codeError,
      email: email ?? this.email,
      isMale: isMale ?? this.isMale,
      firstName: firstName ?? this.firstName,
      surName: surName ?? this.surName,
      birthDay: birthDay ?? this.birthDay,
      skills: skills ?? this.skills,
      experience: experience ?? this.experience,
    );
  }
}

class RegisterViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  _ViewModelState _state = _ViewModelState();

  _ViewModelState get state => _state;

  void setIsUser(bool isUser) {
    _state = _state.copyWith(isUser: isUser);
    notifyListeners();
  }

  void clearPhone() {
    _state = _state.copyWith(phone: "", phoneError: "");
    notifyListeners();
  }

  void setPhone(String v) {
    _state = _state.copyWith(phone: v, phoneError: "");
    notifyListeners();
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => RegisterViewModel(),
        child: const RegisterPage(),
      );

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int lastIndex = 0;
  int selectedIndex = 0;
  int selectedItem1 = 0;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var state = context.select((RegisterViewModel model) => model.state);
    var model = context.read<RegisterViewModel>();

    List<Widget> widgets = [
      RegisterTarget(
        key: const ValueKey(0),
        isUser: state.isUser,
        changeIsUser: model.setIsUser,
      ),
      RegisterPhone(
        key: const ValueKey(1),
        model: model,
        controller: controller,
        clearControllerValue: controller.clear,
        isValue: state.phone != "",
        textError: state.phoneError,
      ),
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
