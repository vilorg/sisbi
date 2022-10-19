import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/card_employer_service.dart';
import 'package:sisbi/models/enum_classes.dart';
import 'package:sisbi/models/filter_model.dart';
import 'package:sisbi/models/object_id.dart';
import 'package:sisbi/models/user_data_model.dart';
import 'package:sisbi/ui/inherited_widgets/home_inherited_widget.dart';
import 'package:sisbi/ui/pages/employee/pages/vacancy/vacancuies_switcher_view_model.dart';
import 'package:sisbi/ui/widgets/show_contacts.dart';

import 'widgets/respond_resume_bottom_sheet.dart';

class ResumesSwitcherViewModel extends ChangeNotifier {
  ResumesSwitcherViewModel(this.context, this._filter, this.setGeneralFilter) {
    resetCards();
  }

  final BuildContext context;
  final CardEmployerService _cardService = CardEmployerService();
  final Function(FilterModel) setGeneralFilter;

  List<UserDataModel> _resumes = [];
  List<UserDataModel> get resumes => _resumes;

  List<ObjectId> _vacancies = [];

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  int _page = 1;
  bool _isLastPage = false;
  bool _isLoadingMore = false;

  UserDataModel? _lastVacancy;
  FilterModel _filter;
  FilterModel get filter => _filter;

  void setFilter(FilterModel filter) {
    setGeneralFilter(filter);
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
    likeResumeAction();
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

  Future likeResumeAction() async {
    if (resumes.last.isFavourite) return;
    try {
      resumes.last = resumes.last.copyWith(isFavourite: true);
      await _cardService.starResume(resumes.last.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentDarkBlue,
          content: Text(
            "Резюме успешно добавлено в изрбранное!",
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

  Future starResume() async {
    try {
      resumes.last.isFavourite
          ? await _cardService.unstarResume(resumes.last.id)
          : await _cardService.starResume(resumes.last.id);
      resumes.last =
          resumes.last.copyWith(isFavourite: !resumes.last.isFavourite);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentDarkBlue,
          content: Text(
            resumes.last.isFavourite
                ? "Резюме успешно добавлено в изрбранное!"
                : "Резюме успешно удалено из избранного!",
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
    if (_resumes.isEmpty) return;

    await Future.delayed(const Duration(milliseconds: 200));
    _lastVacancy = _resumes.last;
    _resumes.removeLast();
    resetPosition();
    if (_resumes.length <= 4) await _loadMoreResumes();
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
          "Резюме восстановлено!",
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
    _page = 1;
    _isLastPage = false;
    _isLoadingMore = false;
    try {
      notifyListeners();
    } catch (e) {
      _resumes = [];
    }
    try {
      _vacancies = await _cardService.getVacancies();
      _resumes = (await _cardService.getActualResumeList(_page, _filter))
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
      _resumes = [];
    }
  }

  Future<void> _loadMoreResumes() async {
    if (_isLoadingMore || _isLastPage) return;
    _isLoadingMore = true;
    _page++;
    try {
      List<UserDataModel> data =
          (await _cardService.getActualResumeList(_page, _filter))
              .reversed
              .toList();
      if (data.isEmpty) _isLastPage = true;
      _resumes.insertAll(0, data);
    } catch (e) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(NameRoutes.login, (route) => false);
    }
    _isLoadingMore = false;
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
        builder: (context) => ShowContacts(
              name: "${resumes.last.firstName} ${resumes.last.surname}",
              email: resumes.last.email,
              phone: resumes.last.phone,
            ));
  }

  void trySendMessage() {
    if (_vacancies.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentRed,
          content: Text(
            "У вас нет действующий вакансий!",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      );
      return;
    }
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(borderRadiusPage))),
      context: context,
      isScrollControlled: true,
      builder: (context) => RespondResumeBottomSheet(
        vacancies: _vacancies,
        sendMessage: sendMessage,
      ),
    );
  }

  Future<void> sendMessage(
      BuildContext curContext, String text, int vacancyId) async {
    try {
      await _cardService.respondResume(vacancyId, resumes.last.id, text);
      Navigator.pop(curContext);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentDarkBlue,
          content: Text(
            "Вы успешно откликнулись на резюме!",
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
            "Вы уже приглашали этого соискателя!",
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

  void getContacts() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadiusPage))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return RespondResumeBottomSheet(
              vacancies: _vacancies, sendMessage: sendMessage);
        });
  }
}
