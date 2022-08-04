// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/tile_data.dart';
import 'package:sisbi/ui/pages/employee/pages/profile/widgets/resume_user.dart';
import 'package:sisbi/ui/widgets/action_bottom.dart';

import 'profile_view_model.dart';
import 'widgets/personal_data_user.dart';

class ProfileUserPage extends StatelessWidget {
  const ProfileUserPage({Key? key}) : super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => ProfileViewModel(context),
        child: const ProfileUserPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProfileViewModel>(context);
    final bool isLoading = model.isLoading;
    final bool isFirst = model.isFirst;

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
          // IconButton(
          //   onPressed: () {},
          //   icon: SvgPicture.asset("assets/icons/settings.svg"),
          // ),
          // ignore: todo
          //TODO: разобраться с настройками!
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
                    onTap: model.logout,
                  ),
                ],
              ),
            ),
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: colorIconContrast),
            )
          : Column(
              children: [
                _Header(isFirst: isFirst),
                isFirst ? const ResumeUser() : const PersonalDataUser(),
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
    final model = Provider.of<ProfileViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () => model.setPage(true),
              child: Text(
                "Мое резюме",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: colorTextContrast,
                      fontWeight: isFirst ? FontWeight.w600 : FontWeight.normal,
                    ),
              ),
              style: isFirst
                  ? Theme.of(context).textButtonTheme.style!.copyWith(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            colorAccentLightBlue),
                      )
                  : Theme.of(context).textButtonTheme.style!.copyWith(
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(color: Colors.white, width: 1.5),
                        ),
                      ),
            ),
          ),
          const SizedBox(width: defaultPadding),
          Expanded(
            child: TextButton(
              onPressed: () => model.setPage(false),
              child: Text(
                "Личные данные",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: colorTextContrast,
                      fontWeight:
                          !isFirst ? FontWeight.w600 : FontWeight.normal,
                    ),
              ),
              style: !isFirst
                  ? Theme.of(context).textButtonTheme.style!.copyWith(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            colorAccentLightBlue),
                      )
                  : Theme.of(context).textButtonTheme.style!.copyWith(
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(color: Colors.white, width: 1.5),
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
