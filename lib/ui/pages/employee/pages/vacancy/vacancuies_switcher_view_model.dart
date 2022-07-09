import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/card_employee_service.dart';
import 'package:sisbi/models/filter_vacancy_model.dart';
import 'package:sisbi/models/user_data_model.dart';
import 'package:sisbi/models/vacancy_model.dart';
import 'package:sisbi/ui/inherited_widgets/home_inherited_widget.dart';

import 'widgets/respond_vacancy_bottom_sheet.dart';
import 'widgets/show_contacts_vacancy.dart';

enum _CardStatus { like, dislike }

class VacanciesSwitcherViewModel extends ChangeNotifier {
  VacanciesSwitcherViewModel(this.context) {
    resetCards();
  }
  final BuildContext context;
  final CardEmployeeService _cardService = CardEmployeeService();

  List<VacancyModel> _vacancyes = [];
  List<VacancyModel> get vacancyes => _vacancyes;

  VacancyModel? _lastVacancy;
  FilterVacancyModel _filter = FilterVacancyModel.deffault();
  FilterVacancyModel get filter => _filter;

  void setFilter(FilterVacancyModel filter) {
    _filter = filter;
    notifyListeners();
  }

  UserDataModel _userData = UserDataModel.deffault();
  UserDataModel? get userData => _userData;

  Offset _position = Offset.zero;
  Offset get position => _position;

  bool _isDragging = false;
  bool get isDragging => _isDragging;

  double _angle = 0;
  double get angle => _angle;

  double _width = 0;
  double _height = 0;

  void startPosition(DragStartDetails details) {
    _isDragging = true;
    _width = HomeInheritedWidget.of(context)!.size.width;
    _height = HomeInheritedWidget.of(context)!.size.height;

    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    final x = _position.dx;
    _angle = pi * x / (_width * 4);

    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;

    final status = getCardStatus();

    switch (status) {
      case _CardStatus.like:
        like();
        break;
      case _CardStatus.dislike:
        dislike();
        break;
      default:
        resetPosition();
    }
  }

  void resetPosition() {
    _position = Offset.zero;
    _isDragging = false;
    _angle = 0;

    notifyListeners();
  }

  _CardStatus? getCardStatus() {
    final x = _position.dx;

    const delta = 100;

    if (x >= delta) {
      return _CardStatus.like;
    } else if (x <= -delta) {
      return _CardStatus.dislike;
    }
    return null;
  }

  void like() {
    _angle = 20;
    _position += Offset(2 * _width, 0);
    _nextCard();
  }

  void dislike() {
    _angle = -20;
    _position -= Offset(2 * _width, 0);
    _nextCard();
  }

  Future starVacancy() async {
    String token = HomeInheritedWidget.of(context)!.token;
    await _cardService.starVacancy(token, vacancyes.last.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colorAccentDarkBlue,
        content: Text(
          "Вакансия успешно добавлена в изрбранное!",
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: colorTextContrast,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }

  Future nextCard() async {
    _position -= Offset(0, 2 * _height);
    await _nextCard();
  }

  Future _nextCard() async {
    if (_vacancyes.isEmpty) return;

    await Future.delayed(const Duration(milliseconds: 200));
    _lastVacancy = _vacancyes.last;
    _vacancyes.removeLast();
    resetPosition();
  }

  Future resetLast() async {
    if (_lastVacancy == null) return;
    _vacancyes.add(_lastVacancy!);
    _lastVacancy = null;
    resetPosition();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colorAccentSoftGold,
        content: Text(
          "Вакансия восстановлена!",
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: colorTextSecondary,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }

  Future<void> init() async {
    try {
      _userData = await _cardService.getUserGraph();
      _filter = _filter.copyWith(
        coast: _userData.coast,
        expierence: _userData.experience,
        post: _userData.post,
        region: _userData.region,
        schedules: _userData.schedules,
        typeEmployments: _userData.typeEmployments,
      );
      await resetCards();
    } catch (e) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        NameRoutes.login,
        (route) => false,
      );
    }
  }

  Future<void> resetCards() async {
    try {
      _vacancyes = (await _cardService.getActualVacancyList(1, _filter))
          .reversed
          .toList();
    } catch (e) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(NameRoutes.login, (route) => false);
    }
    try {
      notifyListeners();
    } catch (e) {
      _vacancyes = [];
    }
  }

  void showContacts() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadiusPage))),
        context: context,
        builder: (context) => ShowContactsVacancy(vacancy: vacancyes.last));
  }

  void trySendMessage() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadiusPage))),
        context: context,
        isScrollControlled: true,
        builder: (context) => RespondVacancyBottomSheet(
            vacancy: vacancyes.last, sendMessage: sendMessage));
  }

  Future<void> sendMessage(BuildContext curContext, String text) async {
    String token = HomeInheritedWidget.of(context)!.token;
    await _cardService.respondVacancy(token, vacancyes.last.id, text);
    Navigator.pop(curContext);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colorAccentDarkBlue,
        content: Text(
          "Вы успешно откликнулись на вакансию!",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: colorTextContrast,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }

  void getContacts() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadiusPage))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return RespondVacancyBottomSheet(
              vacancy: vacancyes.last, sendMessage: sendMessage);
        });
  }
}
