// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/profile_service.dart';
import 'package:sisbi/models/tile_data.dart';
import 'package:sisbi/models/user_data_model.dart';
import 'package:sisbi/ui/pages/loader_page.dart';
import 'package:sisbi/ui/widgets/action_bottom.dart';
import 'package:sisbi/ui/widgets/select_card.dart';

class _ViewModel extends ChangeNotifier {
  final BuildContext _context;
  final ProfileService _service = ProfileService();

  UserDataModel? _userModel;
  UserDataModel? get userModel => _userModel;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> logout() async {
    await _service.logout();
    Navigator.of(_context).pushNamedAndRemoveUntil(
      NameRoutes.login,
      (route) => false,
    );
  }

  _ViewModel(this._context) {
    _init();
  }

  Future<void> _init() async {
    _userModel = await _service.getUserData();
    _isLoading = false;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = true;
    }
  }
}

class ProfileUserPage extends StatelessWidget {
  const ProfileUserPage({Key? key}) : super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => _ViewModel(context),
        child: const ProfileUserPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_ViewModel>(context);
    final UserDataModel? user = model.userModel;
    final bool isLoading = model.isLoading;
    Widget avatar = Image.asset(
      "assets/images/avatar.png",
      width: 132,
      height: 132,
      fit: BoxFit.cover,
    );

    if (!isLoading) {
      if (user!.avatar != "") {
        avatar = Image.network(
          user.avatar,
          width: 132,
          height: 132,
          fit: BoxFit.cover,
        );
      }
    }

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
              child: CircularProgressIndicator(),
            )
          : Column(
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
                                child: avatar,
                              ),
                            ),
                            SelectCard(
                              title: "Имя, фамилия",
                              value: user!.firstName != ""
                                  ? "${user.firstName} ${user.surname}"
                                  : null,
                              onTap: () {},
                            ),
                            SelectCard(
                              title: "Пол",
                              value: user.isMale ? "Мужской" : "Женский",
                              onTap: () {},
                            ),
                            SelectCard(
                              title: "Дата рождения",
                              value: DateTime.now().difference(user.birthday) <
                                      const Duration(days: 365)
                                  ? null
                                  : DateFormat('dd.MM.yyyy')
                                      .format(user.birthday),
                              onTap: () {},
                            ),
                            SelectCard(
                              title: "Город проживания",
                              value: user.region.value != ""
                                  ? user.region.value
                                  : null,
                              onTap: () {},
                            ),
                            SelectCard(
                              title: "Номер телефона",
                              value: user.phone,
                              onTap: () {},
                            ),
                            SelectCard(
                              title: "Email-адрес",
                              value: user.email != "" ? user.email : null,
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
