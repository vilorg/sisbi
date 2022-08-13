import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/card_employer_service.dart';
import 'package:sisbi/models/filter_model.dart';
import 'package:sisbi/models/user_data_model.dart';
import 'package:sisbi/ui/inherited_widgets/home_inherited_widget.dart';

import 'widgets/respond_resume_bottom_sheet.dart';
import 'widgets/show_contacts_resume.dart';

enum _CardStatus { like, dislike }

class ResumesSwitcherViewModel extends ChangeNotifier {
  ResumesSwitcherViewModel(this.context) {
    resetCards();
  }

  final BuildContext context;
  final CardEmployerService _cardService = CardEmployerService();

  List<UserDataModel> _resumes = [];
  List<UserDataModel> get resumes => _resumes;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  int _page = 1;

  UserDataModel? _lastVacancy;
  FilterModel _filter = FilterModel.deffault();
  FilterModel get filter => _filter;

  void setFilter(FilterModel filter) {
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
    await _cardService.starVacancy(token, resumes.last.id);
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
    if (_resumes.isEmpty) return;

    await Future.delayed(const Duration(milliseconds: 200));
    _lastVacancy = _resumes.last;
    _resumes.removeLast();
    resetPosition();
    if (_resumes.length == 1) await _loadMoreVacancies();
  }

  Future resetLast() async {
    if (_lastVacancy == null) return;
    _resumes.add(_lastVacancy!);
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
      _resumes = (await _cardService.getActualResumeList(_page, _filter))
          .reversed
          .toList();
      _isLoading = false;
    } catch (e) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(NameRoutes.login, (route) => false);
    }
    try {
      notifyListeners();
    } catch (e) {
      _resumes = [];
    }
  }

  Future<void> _loadMoreVacancies() async {
    _page += 1;
    try {
      _resumes.addAll((await _cardService.getActualResumeList(_page, _filter))
          .reversed
          .toList());
      _isLoading = false;
    } catch (e) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(NameRoutes.login, (route) => false);
    }
    try {
      notifyListeners();
    } catch (e) {
      _resumes = [];
    }
  }

  void showContacts() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadiusPage))),
        context: context,
        builder: (context) => ShowContactsResume(resume: resumes.last));
  }

  void trySendMessage() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadiusPage))),
        context: context,
        isScrollControlled: true,
        builder: (context) => RespondResumeBottomSheet(
            resume: resumes.last, sendMessage: sendMessage));
  }

  Future<void> sendMessage(BuildContext curContext, String text) async {
    String token = HomeInheritedWidget.of(context)!.token;
    await _cardService.respondVacancy(token, resumes.last.id, text);
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
          return RespondResumeBottomSheet(
              resume: resumes.last, sendMessage: sendMessage);
        });
  }
}
