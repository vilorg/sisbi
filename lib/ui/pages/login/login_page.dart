import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/constants.dart';

import 'widgets/login_phone_field.dart';
import 'widgets/login_start_header.dart';

enum _ViewModelAuthButtonState { canSubmit, authProcess, disable }

class _ViewModelState {
  final String phone;
  final bool isAuthInProcess;
  final bool error;
  final String textError;
  final bool visible;
  _ViewModelAuthButtonState get authButtonState {
    if (isAuthInProcess) {
      return _ViewModelAuthButtonState.authProcess;
    } else if (phone.isNotEmpty) {
      return _ViewModelAuthButtonState.canSubmit;
    } else {
      return _ViewModelAuthButtonState.disable;
    }
  }

  _ViewModelState({
    this.phone = "",
    this.isAuthInProcess = false,
    this.error = false,
    this.textError = "",
    this.visible = true,
  });

  _ViewModelState copyWith({
    String? phone,
    bool? isAuthInProcess,
    bool? error,
    String? textError,
    bool? visible,
  }) {
    return _ViewModelState(
      phone: phone ?? this.phone,
      isAuthInProcess: isAuthInProcess ?? this.isAuthInProcess,
      error: error ?? this.error,
      textError: textError ?? this.textError,
      visible: visible ?? this.visible,
    );
  }
}

class LoginViewModel extends ChangeNotifier {
  var _state = _ViewModelState();
  _ViewModelState get state => _state;

  void setPhone(String value) {
    if (_state.phone == value) return;
    _state = _state.copyWith(phone: value);
    notifyListeners();
  }

  void setVisible() {
    _state = _state.copyWith(visible: !_state.visible);
    notifyListeners();
  }

  void clearPhone() {
    _state = _state.copyWith(phone: "");
    notifyListeners();
  }

  void onSaved() {
    _state = _state.copyWith(textError: "123");
    print("123");
    notifyListeners();
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static String nameRoute = "/login";

  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: const LoginPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = context.select((LoginViewModel model) => model.state);
    var model = context.read<LoginViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              const LoginStartHeader(),
              LoginPhoneField(model: model, isValue: state.phone.isNotEmpty),
            ],
          ),
        ),
      ),
    );
  }
}
