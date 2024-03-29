// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/domain/services/auth_service.dart';
import 'package:sisbi/models/filter_model.dart';
import 'package:sisbi/ui/inherited_widgets/home_inherited_widget.dart';
import 'package:sisbi/ui/pages/employee/pages/favourite/favourite_vacancy_page.dart';
import 'package:sisbi/ui/pages/employee/pages/profile/profile_user_page.dart';

import 'package:sisbi/ui/pages/employee/pages/vacancy/vacancies_switcher_page.dart';
import 'package:sisbi/ui/widgets/responses/chat_page.dart';

class _ViewModel extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  String _token = "";
  String get token => _token;

  FilterModel _filter = FilterModel.deffault();
  FilterModel get filter => _filter;

  void setFilter(FilterModel filter) {
    _filter = filter;
    try {
      notifyListeners();
    } catch (e) {
      _token = _token;
    }
  }

  final AuthService _authService = AuthService();

  _ViewModel() {
    _init();
  }

  Future<void> _init() async {
    _token = await _authService.getUserToken();
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

class HomeEmployeePage extends StatelessWidget {
  const HomeEmployeePage({Key? key}) : super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => _ViewModel(),
        child: const HomeEmployeePage(),
      );

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<_ViewModel>(context);
    final Duration timeDifference =
        DateTime.now().timeZoneOffset - const Duration(hours: 3);
    int selectedIndex = model.selectedIndex;

    List<Widget> pages = [
      VacanciesSwitcherPage.create(model.filter, model.setFilter),
      FavouriteVacancyPage.create(),
      ChatPage.create(false),
      ProfileUserPage.create(),
    ];

    return Scaffold(
      body: HomeInheritedWidget(
        child: pages[selectedIndex],
        size: MediaQuery.of(context).size,
        verticalPadding: MediaQuery.of(context).padding.vertical,
        isEmployer: false,
        timeDifference: timeDifference,
        token: model.token,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: model.setSelectedIndex,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: selectedIndex == 0
                ? SvgPicture.asset("assets/icons/navigation_bar_vacancy.svg")
                : SvgPicture.asset(
                    "assets/icons/navigation_bar_vacancy_un.svg"),
            label: "Вакансии",
          ),
          BottomNavigationBarItem(
            icon: selectedIndex == 1
                ? SvgPicture.asset(
                    "assets/icons/navigation_bar_favourite.svg")
                : SvgPicture.asset(
                    "assets/icons/navigation_bar_favourite_un.svg"),
            label: "Избранное",
          ),
          BottomNavigationBarItem(
            icon: selectedIndex == 2
                ? SvgPicture.asset("assets/icons/navigation_bar_response.svg")
                : SvgPicture.asset(
                    "assets/icons/navigation_bar_response_un.svg"),
            label: "Отклики",
          ),
          BottomNavigationBarItem(
            icon: selectedIndex == 3
                ? SvgPicture.asset("assets/icons/navigation_bar_profile.svg")
                : SvgPicture.asset(
                    "assets/icons/navigation_bar_profile_un.svg"),
            label: "Профиль",
          ),
        ],
      ),
    );
  }
}
