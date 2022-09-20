import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/filter_model.dart';
import 'package:sisbi/models/vacancy_model.dart';
import 'package:sisbi/ui/inherited_widgets/vacacy_inherited_widget.dart';
import 'package:sisbi/ui/pages/employee/pages/vacancy/vacancy_switcher_card.dart';
import 'package:sisbi/ui/widgets/search/search_page.dart';

import 'vacancuies_switcher_view_model.dart';

class VacanciesSwitcherPage extends StatelessWidget {
  const VacanciesSwitcherPage({Key? key}) : super(key: key);

  static Widget create(FilterModel filter, Function(FilterModel) setFilter) =>
      ChangeNotifierProvider(
        create: (context) =>
            VacanciesSwitcherViewModel(context, filter, setFilter),
        child: const VacanciesSwitcherPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<VacanciesSwitcherViewModel>(context);
    var appBar = AppBar(
      title: Text(
        "Вакансии",
        style: Theme.of(context).textTheme.headline3!.copyWith(
              color: colorTextContrast,
              fontWeight: FontWeight.w700,
            ),
      ),
      // title: Row(
      //   children: [
      //     TextButton(
      //       child: Row(
      //         children: [
      //           SvgPicture.asset("assets/icons/history_watch.svg"),
      //           const SizedBox(width: defaultPadding / 2),
      //           Text(
      //             "Открыть историю просмотров",
      //             style: Theme.of(context).textTheme.bodyText2!.copyWith(
      //                   color: colorTextContrast,
      //                 ),
      //           ),
      //         ],
      //       ),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () => Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  SearchPage.create(model, null),
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
    final bool isLoading = model.isLoading;
    final vacancyes = model.vacancies;

    List<Widget> data = vacancyes.map((VacancyModel vacancy) {
      return VacancySwitcherCard(
          isFront: vacancyes.last == vacancy, vacancy: vacancy);
    }).toList();

    if (isLoading) {
      data = [
        const Center(child: CircularProgressIndicator(color: colorIconContrast))
      ];
    } else if (data.isEmpty) {
      data = [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(borderRadiusPage)),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/register_target.png",
                    width: MediaQuery.of(context).size.width * 0.56,
                  ),
                  const SizedBox(height: defaultPadding),
                  RichText(
                    text: TextSpan(
                      text: 'Больше вакансий не найдено. Вы можете изменить ',
                      children: [
                        TextSpan(
                          text: 'настройки фильтра',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        SearchPage.create(model, null),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
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
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: colorLink,
                                  ),
                        ),
                        TextSpan(
                          text: ', чтобы расширить область поиска.',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ),
        )
      ];
    }

    return Stack(
      children: data,
    );
  }
}
