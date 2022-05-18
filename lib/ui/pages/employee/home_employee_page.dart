import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/ui/pages/employee/pages/vacancy/vacancy_page.dart';

class _ViewModelState {
  final int selectedIndex;

  _ViewModelState({
    this.selectedIndex = 0,
  });

  _ViewModelState copyWith({
    int? selectedIndex,
  }) {
    return _ViewModelState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

class _ViewModel extends ChangeNotifier {
  _ViewModelState _state = _ViewModelState();
  _ViewModelState get state => _state;

  void setSelectedIndex(int index) {
    _state = _state.copyWith(selectedIndex: index);
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
    var model = context.read<_ViewModel>();
    var state = context.select((_ViewModel model) => model.state);

    int selectedIndex = state.selectedIndex;

    List<Widget> pages = [
      VacancyPage.create(),
    ];

    return Scaffold(
      body: pages[0],
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
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
      ),
    );
  }
}
