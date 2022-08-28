import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/domain/data_providers/session_data_provider.dart';
import 'package:sisbi/ui/inherited_widgets/home_inherited_widget.dart';
import 'package:sisbi/ui/pages/employer/pages/favourite/favourite_resume_page.dart';
import 'package:sisbi/ui/pages/employer/pages/profile/profile_employer_page.dart';
import 'package:sisbi/ui/widgets/responses/chat_page.dart';

import 'pages/resume/resumes_switcher_page.dart';

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

  final SessionDataProvider _service = SessionDataProvider();

  String _token = "";
  String get token => _token;

  _ViewModel() {
    _init();
  }

  Future<void> _init() async {
    _token = _service.toString();
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _state = _state.copyWith(selectedIndex: index);
    notifyListeners();
  }
}

class HomeEmployerPage extends StatelessWidget {
  const HomeEmployerPage({Key? key}) : super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => _ViewModel(),
        child: const HomeEmployerPage(),
      );

  @override
  Widget build(BuildContext context) {
    var model = context.read<_ViewModel>();
    final Duration timeDifference =
        DateTime.now().timeZoneOffset - const Duration(hours: 3);
    var state = context.select((_ViewModel model) => model.state);

    int selectedIndex = state.selectedIndex;

    List<Widget> pages = [
      ResumesSwitcherPage.create(),
      FavouriteResumePage.create(),
      ChatPage.create(true),
      ProfileEmployerPage.create(),
    ];

    return Scaffold(
      body: HomeInheritedWidget(
        child: pages[selectedIndex],
        size: MediaQuery.of(context).size,
        verticalPadding: MediaQuery.of(context).padding.vertical,
        isEmployer: true,
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
            label: "Резюме",
          ),
          BottomNavigationBarItem(
            icon: selectedIndex == 1
                ? SvgPicture.asset("assets/icons/navigation_bar_favourite.svg")
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
