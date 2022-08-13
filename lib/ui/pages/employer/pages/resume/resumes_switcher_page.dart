import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/user_data_model.dart';
import 'package:sisbi/ui/inherited_widgets/vacacy_inherited_widget.dart';
import 'package:sisbi/ui/widgets/search/search_page.dart';

import 'resume_switcher_card.dart';
import 'resumes_switcher_view_model.dart';

class ResumesSwitcherPage extends StatelessWidget {
  const ResumesSwitcherPage({Key? key}) : super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => ResumesSwitcherViewModel(context),
        child: const ResumesSwitcherPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ResumesSwitcherViewModel>(context);
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
                  SearchPage.create(null, model),
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
    final model = Provider.of<ResumesSwitcherViewModel>(context);
    final bool isLoading = model.isLoading;
    final resumes = model.resumes;

    List<Widget> data = resumes.map((UserDataModel resume) {
      return ResumeSwitcherCard(
          isFront: resumes.last == resume, resume: resume);
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
              child: Text(
                "Вы посмотрели все вакансии...",
                style: Theme.of(context).textTheme.headline6,
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
