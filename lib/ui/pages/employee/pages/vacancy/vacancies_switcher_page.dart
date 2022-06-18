import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/vacancy_model.dart';
import 'package:sisbi/ui/inherited_widgets/vacacy_inherited_widget.dart';
import 'package:sisbi/ui/pages/employee/pages/search/search_vacancy_page.dart';
import 'package:sisbi/ui/pages/employee/pages/vacancy/vacancy_card.dart';

import 'vacancuies_switcher_view_model.dart';

class CardsSwitcherPage extends StatelessWidget {
  const CardsSwitcherPage({Key? key}) : super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => VacanciesSwitcherViewModel(context),
        child: const CardsSwitcherPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<VacanciesSwitcherViewModel>(context);
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
          onPressed: () => Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  SearchVacancyPage.create(model),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          ),
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
    final model = Provider.of<VacanciesSwitcherViewModel>(context);
    final vacancyes = model.vacancyes;

    return Stack(
      children: vacancyes.map((VacancyModel vacancy) {
        return VacancyCard(
            isFront: vacancyes.last == vacancy, vacancy: vacancy);
      }).toList(),
    );
  }
}
