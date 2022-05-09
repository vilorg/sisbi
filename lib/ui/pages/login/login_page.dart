import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/data_providers/auth_api_provider.dart';
import 'package:sisbi/domain/services/auth_service.dart';
import 'package:sisbi/ui/pages/login/login_code_input_page.dart';

import 'widgets/login_phone_field.dart';
import 'widgets/login_start_header.dart';

enum _ViewModelAuthButtonState { canSubmit, authProcess, disable }

class _ViewModelState {
  final String phone;
  final bool isAuthInProcess;
  final String textError;
  final bool visible;
  final bool isLogin;
  _ViewModelAuthButtonState get authButtonState {
    if (isAuthInProcess) {
      return _ViewModelAuthButtonState.authProcess;
    } else if (phone.isNotEmpty && phone.length == 18 && textError.isEmpty) {
      return _ViewModelAuthButtonState.canSubmit;
    } else {
      return _ViewModelAuthButtonState.disable;
    }
  }

  _ViewModelState({
    this.textError = "",
    this.phone = "",
    this.isAuthInProcess = false,
    this.visible = true,
    this.isLogin = true,
  });

  _ViewModelState copyWith({
    String? phone,
    bool? isAuthInProcess,
    String? textError,
    bool? visible,
    bool? isLogin,
  }) {
    return _ViewModelState(
      phone: phone ?? this.phone,
      isAuthInProcess: isAuthInProcess ?? this.isAuthInProcess,
      textError: textError ?? this.textError,
      visible: visible ?? this.visible,
      isLogin: isLogin ?? this.isLogin,
    );
  }
}

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this.context);

  final BuildContext context;
  final AuthService _authService = AuthService();

  var _state = _ViewModelState();
  _ViewModelState get state => _state;

  void setPhone(String value) {
    if (_state.phone == value) return;
    _state = _state.copyWith(phone: value, textError: "");
    notifyListeners();
  }

  void setVisible() {
    _state = _state.copyWith(visible: !_state.visible);
    notifyListeners();
  }

  void clearPhone() {
    _state = _state.copyWith(phone: "", textError: "");
    notifyListeners();
  }

  void onAuthButtonPressed() async {
    _state = _state.copyWith(isAuthInProcess: true);
    notifyListeners();
    bool isOk = false;
    try {
      await _authService.getLoginCode(_state.isLogin, _state.phone);
      isOk = true;
    } on AuthFetchDataError {
      _state = _state.copyWith(textError: "Произошла ошибка на сервере");
    } on AuthUnknownUserError {
      _state = _state.copyWith(textError: "Пользователь не зарегистрирован");
    } on AuthBusyUserError {
      _state = _state.copyWith(textError: "Пользователь уже зарегистрирован");
    } catch (e) {
      _state = _state.copyWith(textError: "Неизвестная ошибка");
    }
    _state = _state.copyWith(isAuthInProcess: false);
    notifyListeners();
    if (isOk) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginCodeInputPage(),
          ));
    }
  }

  void onRegisterButtonPressed() {
    _state = _state.copyWith(isLogin: !_state.isLogin);
    notifyListeners();
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static String nameRoute = "/login";

  static Widget create() => ChangeNotifierProvider(
      create: (context) => LoginViewModel(context), child: const LoginPage());

  @override
  Widget build(BuildContext context) {
    var state = context.select((LoginViewModel model) => model.state);
    var model = context.read<LoginViewModel>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPadding),
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.vertical -
                3 * defaultPadding,
            child: Column(
              children: [
                LoginStartHeader(isLogin: state.isLogin),
                LoginPhoneField(
                  model: model,
                  isValue: state.phone.isNotEmpty,
                  textError: state.textError,
                ),
                const SizedBox(height: defaultPadding),
                _LoginButton(model: model, isLogin: state.isLogin),
                const Spacer(),
                _RegisterButton(model: model, isLogin: state.isLogin),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({
    Key? key,
    required this.model,
    required this.isLogin,
  }) : super(key: key);

  final LoginViewModel model;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              backgroundColor: MaterialStateProperty.all<Color>(
                colorButtonSecondary,
              ),
            ),
        onPressed: model.onRegisterButtonPressed,
        child: Padding(
          padding: const EdgeInsets.all(defaultButtonPadding),
          child: Text(
            isLogin ? 'Создать аккаунт' : 'Воспользоваться входом',
            style: Theme.of(context).textTheme.button!.copyWith(
                  color: colorTextSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
    required this.model,
    required this.isLogin,
  }) : super(key: key);

  final LoginViewModel model;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    final authButtonState =
        context.select((LoginViewModel value) => value.state.authButtonState);

    final onPressed = authButtonState == _ViewModelAuthButtonState.canSubmit
        ? model.onAuthButtonPressed
        : null;

    final child = authButtonState == _ViewModelAuthButtonState.authProcess
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: colorIconContrast,
                ),
              ),
              const SizedBox(width: defaultPadding),
              Text(
                isLogin ? "Войти..." : "Зарегистрироваться...",
                style: Theme.of(context).textTheme.button!.copyWith(
                      color: colorTextContrast,
                    ),
              ),
            ],
          )
        : Text(
            isLogin ? "Войти" : "Зарегистрироваться",
            style: Theme.of(context).textTheme.button!.copyWith(
                  color: authButtonState == _ViewModelAuthButtonState.canSubmit
                      ? colorTextContrast
                      : colorTextSecondary,
                ),
          );

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                if (authButtonState != _ViewModelAuthButtonState.authProcess) {
                  return colorButtonDisable;
                }
              }
              return colorButton;
            },
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(defaultButtonPadding),
          child: child,
        ),
      ),
    );
  }
}
