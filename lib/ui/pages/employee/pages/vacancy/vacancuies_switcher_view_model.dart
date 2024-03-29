import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/card_employee_service.dart';
import 'package:sisbi/models/enum_classes.dart';
import 'package:sisbi/models/filter_model.dart';
import 'package:sisbi/models/user_data_model.dart';
import 'package:sisbi/models/vacancy_model.dart';
import 'package:sisbi/ui/inherited_widgets/home_inherited_widget.dart';
import 'package:sisbi/ui/widgets/show_contacts.dart';

import 'widgets/respond_vacancy_bottom_sheet.dart';

enum CardStatus { like, dislike }

class VacanciesSwitcherViewModel extends ChangeNotifier {
  VacanciesSwitcherViewModel(
      this.context, this._filter, this.setGeneralFilter) {
    init();
  }

  final BuildContext context;
  final CardEmployeeService _cardService = CardEmployeeService();
  final Function(FilterModel) setGeneralFilter;

  List<VacancyModel> _vacancies = [];
  List<VacancyModel> get vacancies => _vacancies;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  int _page = 1;
  bool _isLoadingMore = false;
  bool _isLastPage = false;

  VacancyModel? _lastVacancy;
  FilterModel _filter;
  FilterModel get filter => _filter;

  void setFilter(FilterModel filter) {
    _filter = filter;
    setGeneralFilter(filter);
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

  void startPosition(DragStartDetails details) {
    _isDragging = true;
    _width = HomeInheritedWidget.of(context)!.size.width;

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
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
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

  CardStatus? getCardStatus() {
    final x = _position.dx;

    const delta = 100;

    if (x >= delta) {
      return CardStatus.like;
    } else if (x <= -delta) {
      return CardStatus.dislike;
    }
    return null;
  }

  void like() {
    _position = Offset(_position.dx + _width, _position.dy);
    try {
      notifyListeners();
    } catch (e) {
      _vacancies = [];
    }
    likeVacancyAction();
    _nextCard();
  }

  void dislike() {
    _position = Offset(_position.dx - _width, _position.dy);
    try {
      notifyListeners();
    } catch (e) {
      _vacancies = [];
    }
    _nextCard();
  }

  Future starVacancy() async {
    try {
      vacancies.last.isFavourite
          ? await _cardService.unstarVacancy(vacancies.last.id)
          : await _cardService.starVacancy(vacancies.last.id);
      vacancies.last =
          vacancies.last.copyWith(isFavourite: !vacancies.last.isFavourite);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentDarkBlue,
          content: Text(
            vacancies.last.isFavourite
                ? "Вакансия успешно добавлена в изрбранное!"
                : "Вакансия успешно удалена из избранного!",
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentRed,
          content: Text(
            "Произошла ошибка",
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
    }

    try {
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
  }

  Future likeVacancyAction() async {
    if (vacancies.last.isFavourite) return;
    try {
      vacancies.last = vacancies.last.copyWith(isFavourite: true);
      await _cardService.starVacancy(vacancies.last.id);
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentRed,
          content: Text(
            "Произошла ошибка",
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
    }

    try {
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
  }

  Future nextCard() async {
    await _nextCard();
  }

  Future _nextCard() async {
    if (_vacancies.isEmpty) return;

    await Future.delayed(const Duration(milliseconds: 200));
    _lastVacancy = _vacancies.last;
    _vacancies.removeLast();
    resetPosition();
    if (_vacancies.length <= 4) await _loadMoreVacancies();
  }

  Future resetLast() async {
    if (_lastVacancy == null) return;
    _vacancies.add(_lastVacancy!);
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
    _isLoading = true;
    try {
      _userData = await _cardService.getUserData();
      // _filter = _filter.copyWith(
      //   coast: _userData.coast,
      //   expierence: _userData.experience,
      //   post: _userData.post,
      //   region: _userData.region,
      //   schedules: _userData.schedules,
      //   typeEmployments: _userData.typeEmployments,
      // );
      await resetCards();
    } catch (e) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        NameRoutes.login,
        (route) => false,
      );
    }
  }

  Future resetCards() async {
    _isLoadingMore = false;
    _isLastPage = false;
    _page = 1;
    try {
      notifyListeners();
    } catch (e) {
      _vacancies = [];
    }
    try {
      _vacancies = (await _cardService.getActualVacancyList(_page, _filter))
          .reversed
          .toList();
    } catch (e) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(NameRoutes.login, (route) => false);
    }
    _isLoading = false;
    try {
      notifyListeners();
    } catch (e) {
      _vacancies = [];
    }
  }

  Future<void> _loadMoreVacancies() async {
    if (_isLoadingMore || _isLastPage) return;
    _isLoadingMore = true;
    _page += 1;
    try {
      notifyListeners();
    } catch (e) {
      _vacancies = [];
    }
    try {
      List<VacancyModel> data =
          (await _cardService.getActualVacancyList(_page, _filter))
              .reversed
              .toList();
      if (data.isEmpty) _isLastPage = true;
      _vacancies.insertAll(0, data);
    } catch (e) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(NameRoutes.login, (route) => false);
    }
    _isLoadingMore = false;
    try {
      notifyListeners();
    } catch (e) {
      _vacancies = [];
    }
  }

  void showContacts() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadiusPage))),
        context: context,
        builder: (context) => ShowContacts(
            email: vacancies.last.email,
            name: vacancies.last.fullName,
            phone: vacancies.last.phone));
  }

  void trySendMessage() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadiusPage))),
        context: context,
        isScrollControlled: true,
        builder: (context) => RespondVacancyBottomSheet(
              title: vacancies.last.title,
              salary: vacancies.last.salary,
              sendMessage: sendMessage,
            ));
  }

  Future<void> sendMessage(BuildContext curContext, String text) async {
    if (_userData.isModetate) {
      Navigator.pop(curContext);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentRed,
          content: Text(
            "Ваше резюме еще не прошло модерацию",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      );
      return;
    }
    try {
      await _cardService.respondVacancy(vacancies.last.id, text);
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
    } on DoubleResponseException {
      Navigator.pop(curContext);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentRed,
          content: Text(
            "Вы уже откликались на эту вакансию!",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      );
    } catch (e) {
      Navigator.pop(curContext);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentRed,
          content: Text(
            "Произошла ошибка!",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      );
    }
  }
}
