import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';

import 'package:sisbi/domain/data_providers/auth_api_provider.dart';
import 'package:sisbi/domain/services/auth_service.dart';

class _ViewModelState {
  final int selectedIndex;
  final int lastIndex;
  final bool isUser;
  final String phone;
  final String phoneError;
  final List<String> code;
  final bool isCodeError;
  final String email;
  final String emailError;
  final bool isMale;
  final String firstName;
  final String surName;
  final String companyName;
  final DateTime? birthDay;
  final String skills;
  final int experience;
  final List<int> typeEmployments;
  final List<int> schedules;

  _ViewModelState({
    this.selectedIndex = 0,
    this.lastIndex = 0,
    this.isUser = true,
    this.phone = "",
    this.phoneError = "",
    this.code = const ["", "", "", ""],
    this.isCodeError = false,
    this.email = "",
    this.emailError = "",
    this.isMale = true,
    this.firstName = "",
    this.surName = "",
    this.companyName = "",
    this.birthDay,
    this.skills = "",
    this.experience = 0,
    this.typeEmployments = const [0],
    this.schedules = const [0],
  });

  _ViewModelState copyWith({
    int? selectedIndex,
    int? lastIndex,
    bool? isUser,
    String? phone,
    String? phoneError,
    List<String>? code,
    bool? isCodeError,
    String? email,
    String? emailError,
    bool? isMale,
    String? firstName,
    String? surName,
    String? companyName,
    DateTime? birthDay,
    String? skills,
    int? experience,
    List<int>? typeEmployments,
    List<int>? schedules,
  }) {
    return _ViewModelState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      lastIndex: lastIndex ?? this.lastIndex,
      isUser: isUser ?? this.isUser,
      phone: phone ?? this.phone,
      phoneError: phoneError ?? this.phoneError,
      code: code ?? this.code,
      isCodeError: isCodeError ?? this.isCodeError,
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      isMale: isMale ?? this.isMale,
      firstName: firstName ?? this.firstName,
      surName: surName ?? this.surName,
      companyName: companyName ?? this.companyName,
      birthDay: birthDay ?? this.birthDay,
      skills: skills ?? this.skills,
      experience: experience ?? this.experience,
      typeEmployments: typeEmployments ?? this.typeEmployments,
      schedules: schedules ?? this.schedules,
    );
  }
}

class RegisterViewModel extends ChangeNotifier {
  final BuildContext context;
  RegisterViewModel(this.context);

  final AuthService _authService = AuthService();
  _ViewModelState _state = _ViewModelState();

  TextEditingController controller = TextEditingController();

  _ViewModelState get state => _state;

  void nextPage() {
    _state = _state.copyWith(
        lastIndex: _state.selectedIndex,
        selectedIndex: _state.selectedIndex + 1);
    notifyListeners();
  }

  void previousPage() {
    _state = _state.copyWith(
        lastIndex: _state.selectedIndex,
        selectedIndex: _state.selectedIndex - 1);
    notifyListeners();
  }

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

  void onSubmitPhoneButton() async {
    var phone = _state.phone;
    if (phone.length != 18) {
      _state = _state.copyWith(phoneError: "Введите корректный номер телефона");
      return notifyListeners();
    }
    try {
      await _authService.registerUser(!_state.isUser, phone);
      controller.clear();
      return nextPage();
    } on AuthFetchDataError {
      _state = _state.copyWith(phoneError: "Произошла ошибка на сервере");
    } on AuthUnknownUserError {
      _state = _state.copyWith(phoneError: "Пользователь не зарегистрирован");
    } on AuthUnknownEmployerError {
      _state = _state.copyWith(phoneError: "Работадатель не зарегистрирован");
    } on AuthBusyUserError {
      _state = _state.copyWith(phoneError: "Пользователь уже зарегистрирован");
    } on AuthBusyEmployerError {
      _state = _state.copyWith(phoneError: "Работадатель уже зарегистрирован");
    } catch (e) {
      _state = _state.copyWith(phoneError: "Проверьте подключение к интернету");
    }
    notifyListeners();
  }

  void setSmsValue(int index, String value) {
    List<String> code = [];
    for (int i = 0; i < _state.code.length; i++) {
      if (index == i) {
        code.add(value);
      } else {
        code.add(_state.code[i]);
      }
    }
    _state = _state.copyWith(code: code, isCodeError: false);
    notifyListeners();
  }

  void validateSmsValue() async {
    try {
      await _authService.checkLoginCode(
          !_state.isUser, _state.phone, _state.code.join());
      return nextPage();
    } on AuthIncorrectCode {
      _state = _state.copyWith(isCodeError: true);
    } on Exception {
      _state = _state.copyWith(isCodeError: true);
    }
    notifyListeners();
  }

  void resendSmsCode() async =>
      await _authService.getLoginCode(!_state.isUser, _state.phone);

  void setEmail(String value) {
    _state = _state.copyWith(email: value);
    notifyListeners();
  }

  void clearEmail() {
    _state = _state.copyWith(email: "", emailError: "");
    notifyListeners();
  }

  void validateEmail() {
    var email = _state.email;
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!emailValid) {
      _state = _state.copyWith(emailError: "Введите корректную почту");
      return notifyListeners();
    }
    return nextPage();
  }

  void setIsMale(bool isMale) {
    _state = _state.copyWith(isMale: isMale);
    notifyListeners();
  }

  void setFirstName(String value) {
    _state = _state.copyWith(firstName: value);
  }

  void setSurName(String value) {
    _state = _state.copyWith(surName: value);
  }

  void validateName() {
    if (_state.firstName != "" && _state.surName != "") {
      return nextPage();
    }
  }

  void setCompanyName(String value) {
    _state = _state.copyWith(companyName: value);
  }

  void validateCompanyName() {
    if (_state.companyName != "") {
      return nextPage();
    }
  }

  void setBirthday(DateTime value) {
    _state = _state.copyWith(birthDay: value);
  }

  void setSkills(String value) {
    _state = _state.copyWith(skills: value);
    notifyListeners();
  }

  void setExperience(int i) {
    _state = _state.copyWith(experience: i);
    notifyListeners();
  }

  void validateSkills() {
    if (_state.skills != "") return nextPage();
  }

  void setTypeEmployments(int i) {
    List<int> data = [];
    bool key = true;
    if (_state.typeEmployments.length == 1 && _state.typeEmployments[0] == i) {
      return;
    }
    for (var val in _state.typeEmployments) {
      if (val == i) {
        key = false;
      } else {
        data.add(val);
      }
    }
    if (key) data.add(i);
    _state = _state.copyWith(typeEmployments: data);
    notifyListeners();
  }

  void setSchedules(int i) {
    List<int> data = [];
    bool key = true;
    if (_state.schedules.length == 1 && _state.schedules[0] == i) {
      return;
    }
    for (var val in _state.schedules) {
      if (val == i) {
        key = false;
      } else {
        data.add(val);
      }
    }
    if (key) data.add(i);
    _state = _state.copyWith(schedules: data);
    notifyListeners();
  }

  void saveUser() async {
    await _authService.saveUser(
      birthDay: _state.birthDay ?? DateTime.now(),
      comanyName: _state.companyName,
      email: _state.email,
      experience: _state.experience,
      firstName: _state.firstName,
      isMale: _state.isMale,
      isUser: _state.isUser,
      schedules: _state.schedules,
      skills: _state.skills,
      surName: _state.surName,
      typeEmployments: _state.typeEmployments,
    );
    Navigator.of(context)
        .pushNamedAndRemoveUntil(NameRoutes.home, (route) => false);
  }
}
