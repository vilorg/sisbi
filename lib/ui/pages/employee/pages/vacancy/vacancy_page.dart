// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/ui/pages/home/user_card.dart';

class VacancyInheritedWidget extends InheritedWidget {
  const VacancyInheritedWidget({
    Key? key,
    required this.appBarHeight,
    required Widget child,
  }) : super(key: key, child: child);

  final double appBarHeight;

  static VacancyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VacancyInheritedWidget>();
  }

  @override
  bool updateShouldNotify(VacancyInheritedWidget oldWidget) {
    if (oldWidget.appBarHeight != appBarHeight) return true;
    return false;
  }
}

class _ViewModel extends ChangeNotifier {}

class VacancyPage extends StatelessWidget {
  const VacancyPage({Key? key}) : super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => _ViewModel(),
        child: const VacancyPage(),
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
        child: const ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(borderRadius),
          ),
          child: UserCard(),
        ),
      ),
    );
  }
}
