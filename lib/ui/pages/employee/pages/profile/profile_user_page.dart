// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/tile_data.dart';
import 'package:sisbi/ui/widgets/action_bottom.dart';
import 'package:sisbi/ui/widgets/select_card.dart';

class _ViewModel extends ChangeNotifier {}

class ProfileUserPage extends StatelessWidget {
  const ProfileUserPage({Key? key}) : super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => _ViewModel(),
        child: const ProfileUserPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAccentDarkBlue,
      appBar: AppBar(
        title: Text(
          "Мой профиль",
          style: Theme.of(context).textTheme.headline3!.copyWith(
                color: colorTextContrast,
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/settings.svg"),
          ),
          IconButton(
            onPressed: () => showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(borderRadiusPage))),
              context: context,
              builder: (context) => ActionButton(
                tiles: [
                  TileData(
                    title: "Полтика",
                    asset: "assets/icons/arrow_forward.svg",
                    isRed: false,
                    onTap: () {},
                  ),
                  TileData(
                    title: "Написать разработчикам",
                    asset: "assets/icons/arrow_forward.svg",
                    isRed: false,
                    onTap: () {},
                  ),
                  TileData(
                    title: "Выйти из аккаунта",
                    asset: "assets/icons/logout.svg",
                    isRed: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          const _Header(isFirst: false),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(borderRadiusPage),
              ),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            "assets/images/сard_preview.png",
                            width: 132,
                            height: 132,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SelectCard(
                        title: "Имя, фамилия",
                        onTap: () {},
                      ),
                      SelectCard(
                        title: "Пол",
                        onTap: () {},
                      ),
                      SelectCard(
                        title: "Дата рождения",
                        onTap: () {},
                      ),
                      SelectCard(
                        title: "Город проживания",
                        onTap: () {},
                      ),
                      SelectCard(
                        title: "Номер телефона",
                        onTap: () {},
                      ),
                      SelectCard(
                        title: "Email-адрес",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final bool isFirst;
  const _Header({
    Key? key,
    required this.isFirst,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Мое резюме",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: colorTextContrast,
                    ),
              ),
              style: Theme.of(context).textButtonTheme.style!.copyWith(
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: Colors.white, width: 1.5),
                    ),
                  ),
            ),
          ),
          const SizedBox(width: defaultPadding),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Личные данные",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: colorTextContrast,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              style: Theme.of(context).textButtonTheme.style!.copyWith(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(colorAccentLightBlue),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
