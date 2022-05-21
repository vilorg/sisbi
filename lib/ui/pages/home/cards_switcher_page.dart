// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/ui/inherited_widgets/home_inherited_widget.dart';
import 'package:sisbi/ui/inherited_widgets/vacacy_inherited_widget.dart';
import 'package:sisbi/ui/pages/home/user_card.dart';

class CardsSwitcherViewModel extends ChangeNotifier {
  CardsSwitcherViewModel(this.context) {
    isEmployer = HomeInheritedWidget.of(context)!.isEmployer;
  }

  final BuildContext context;
  late bool isEmployer;
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
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(borderRadius),
          ),
          child: Stack(
            children: const [
              UserCard(),
            ],
          ),
        ),
      ),
    );
  }
}
