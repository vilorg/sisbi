import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/data_providers/auth_api_provider.dart';
import 'package:sisbi/domain/services/auth_service.dart';

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
    } on AuthIncorrectCode {
      _state = _state.copyWith(isError: true);
    } on Exception {
      _state = _state.copyWith(isError: true);
    }
    notifyListeners();
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
                Image.asset("assets/images/login_bird.png"),
                const SizedBox(height: defaultPadding),
                Text(
                  "Мы отправили код подтверждения на указанный номер $textPhone",
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
                _InputFields(isError: state.isError),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputFields extends StatelessWidget {
  final bool isError;

  const _InputFields({
    Key? key,
    required this.isError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _InputField(index: 0, isError: isError),
          _InputField(index: 1, isError: isError),
          _InputField(index: 2, isError: isError),
          _InputField(index: 3, isError: isError),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final int index;
  final bool isError;

  const _InputField({
    Key? key,
    required this.index,
    required this.isError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = context.read<_ViewModel>();
    return SizedBox(
      height: 68,
      width: 64,
      child: TextField(
        autofocus: index == 0 ? true : false,
        decoration: InputDecoration(
          errorText: isError ? "" : null,
          hintText: "0",
          errorStyle: const TextStyle(
            height: 0,
            fontSize: 0,
          ),
        ),
        onChanged: (v) {
          model.setSmsValue(index, v);
          if (v.length == 1 && index != 3) {
            FocusScope.of(context).nextFocus();
          } else if (v.isEmpty && index != 0) {
            FocusScope.of(context).previousFocus();
          } else if (v.length == 1 && index == 3) {
            model.validateSmsCode();
          }
        },
        style: Theme.of(context).textTheme.subtitle1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
