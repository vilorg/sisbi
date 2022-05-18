import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/data_providers/auth_api_provider.dart';
import 'package:sisbi/domain/services/auth_service.dart';
import 'package:sisbi/ui/widgets/code_input_fields.dart';

class _ViewModelState {
  final List<String> smsCode;
  final bool isError;

  _ViewModelState({
    this.smsCode = const ["", "", "", ""],
    this.isError = false,
  });

  _ViewModelState copyWith({
    List<String>? smsCode,
    bool? isError,
  }) {
    return _ViewModelState(
      smsCode: smsCode ?? this.smsCode,
      isError: isError ?? this.isError,
    );
  }
}

class _ViewModel extends ChangeNotifier {
  _ViewModel(this.context, this.phone, this.isEmployer);

  final BuildContext context;
  final String phone;
  final bool isEmployer;

  final AuthService _authService = AuthService();

  _ViewModelState _state = _ViewModelState();

  _ViewModelState get state => _state;

  void setSmsValue(index, value) {
    List<String> smsCode = [];
    for (int i = 0; i < _state.smsCode.length; i++) {
      if (i == index) {
        smsCode.add(value);
      } else {
        smsCode.add(_state.smsCode[i]);
      }
    }
    _state = _state.copyWith(smsCode: smsCode, isError: false);
    notifyListeners();
  }

  void validateSmsCode() async {
    try {
      await _authService.checkLoginCode(
          isEmployer, phone, _state.smsCode.join());
      Navigator.of(context).pushNamedAndRemoveUntil(
        isEmployer ? NameRoutes.homeEmployer : NameRoutes.homeEmployee,
        (route) => false,
      );
      return;
    } on AuthIncorrectCode {
      _state = _state.copyWith(isError: true);
    } on Exception {
      _state = _state.copyWith(isError: true);
    }
    notifyListeners();
  }

  void resendSmsCode() async {
    try {
      await _authService.getLoginCode(isEmployer, phone);
    } catch (e) {
      _state = _state.copyWith(isError: true);
      notifyListeners();
    }
  }
}

class LoginCodeInputPage extends StatefulWidget {
  const LoginCodeInputPage({Key? key}) : super(key: key);

  static Widget create(String phone, bool isEmployer) => ChangeNotifierProvider(
      create: (context) => _ViewModel(context, phone, isEmployer),
      child: const LoginCodeInputPage());

  @override
  State<LoginCodeInputPage> createState() => _LoginCodeInputPageState();
}

class _LoginCodeInputPageState extends State<LoginCodeInputPage> {
  late Timer _timer;
  bool _isResentAvaible = false;
  bool _isResent = false;
  int _countDown = 120;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countDown == 0) {
        _timer.cancel();
        _isResentAvaible = true;
      } else {
        _countDown -= 1;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var phone = context.read<_ViewModel>().phone;

    var textPhone = phone.split('')[0] +
        phone.split('')[1] +
        phone.split('')[5] +
        phone.split('')[6] +
        phone.split('')[7] +
        "*****" +
        phone.split('')[16] +
        phone.split('')[17];

    var model = context.read<_ViewModel>();
    var state = context.select((_ViewModel model) => model.state);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Подтверждение телефона",
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: colorTextContrast,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: colorAccentDarkBlue,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadiusPage)),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Image.asset("assets/images/login_bird.png",
                    width: MediaQuery.of(context).size.width / 1.5),
                const SizedBox(height: defaultPadding),
                Text(
                  "Мы отправили код подтверждения на указанный номер $textPhone",
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
                CodeInputFields(
                  isError: state.isError,
                  setSmsValue: model.setSmsValue,
                  validateSmsValue: model.validateSmsCode,
                ),
                GestureDetector(
                  onTap: _isResentAvaible & !_isResent
                      ? () {
                          try {
                            model.resendSmsCode();
                            _isResentAvaible = false;
                            _isResent = true;
                            setState(() {});
                          } catch (e) {
                            _isResentAvaible = true;
                            _isResent = false;
                          }
                        }
                      : null,
                  child: Text(
                    _isResent
                        ? "Код был повторно выслан"
                        : _isResentAvaible
                            ? "Отправить код снова?"
                            : "Выслать код повторно через ${_countDown ~/ 60}:${_countDown % 60}",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: colorLink,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
