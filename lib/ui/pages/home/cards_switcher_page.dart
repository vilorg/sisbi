import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/card_service.dart';
import 'package:sisbi/models/user_graph_model.dart';
import 'package:sisbi/models/vacancy_model.dart';
import 'package:sisbi/ui/inherited_widgets/home_inherited_widget.dart';
import 'package:sisbi/ui/inherited_widgets/vacacy_inherited_widget.dart';
import 'package:sisbi/ui/pages/employee/pages/vacancy/respond_vacancy_bottom_sheet.dart';
import 'package:sisbi/ui/pages/employee/pages/vacancy/show_contacts_vacancy.dart';
import 'package:sisbi/ui/pages/home/user_card.dart';

enum CardStatus { like, dislike }

class CardsSwitcherViewModel extends ChangeNotifier {
  CardsSwitcherViewModel(this.context) {
    resetCards();
  }
  final BuildContext context;
  final CardService _cardService = CardService();

  List<VacancyModel> _vacancyes = [];
  List<VacancyModel> get vacancyes => _vacancyes;

  VacancyModel? _lastVacancy;

  UserGraphModel? _userData;
  UserGraphModel? get userData => _userData;

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
    nextCard();
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
  }

  void resetCards() async {
    _userData = await _cardService.getUserGraph();
    try {
      _vacancyes =
          (await _cardService.getActualVacancyList(1)).reversed.toList();
      notifyListeners();
    } catch (e) {
      notifyListeners();
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

class CardsSwitcherPage extends StatelessWidget {
  const CardsSwitcherPage({Key? key}) : super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => CardsSwitcherViewModel(context),
        child: const CardsSwitcherPage(),
      );

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Row(
        children: [
          TextButton(
            child: Row(
              children: [
                SvgPicture.asset("assets/icons/history_watch.svg"),
                const SizedBox(width: defaultPadding / 2),
                Text(
                  "Открыть историю просмотров",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: colorTextContrast,
                      ),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
      ],
    );

    return Scaffold(
      backgroundColor: colorAccentDarkBlue,
      appBar: appBar,
      body: VacancyInheritedWidget(
        appBarHeight: appBar.preferredSize.height,
        child: ClipRRect(
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(borderRadius)),
          child: _buildCards(context),
        ),
      ),
    );
  }

  Widget _buildCards(BuildContext context) {
    final model = Provider.of<CardsSwitcherViewModel>(context);
    final vacancyes = model.vacancyes;

    return Stack(
      children: vacancyes.map((VacancyModel vacancy) {
        return UserCard(isFront: vacancyes.last == vacancy, vacancy: vacancy);
      }).toList(),
    );
  }
}
