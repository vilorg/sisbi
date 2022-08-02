// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/enum_classes.dart';
import 'package:sisbi/models/object_id.dart';
import 'package:sisbi/models/user_data_model.dart';
import 'package:sisbi/ui/pages/employee/pages/profile/profile_view_model.dart';
import 'package:sisbi/ui/pages/employee/pages/profile/widgets/career_info.dart';
import 'package:sisbi/ui/pages/employee/pages/profile/widgets/skills_profile.dart';

class ResumeUser extends StatelessWidget {
  const ResumeUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProfileViewModel>(context);
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
        avatar = Image.network(user.avatar,
            width: 132, height: 132, fit: BoxFit.cover);
      }
    }

    int years = (DateTime.now().difference(user!.birthday).inDays) ~/ 365;

    String skills = "";
    List<String> drivingLicence = [];

    if (user.skills[0] != "") skills = user.skills.join(", ");
    for (DrivingLicence licence in user.drivingLicence) {
      drivingLicence.add(licence.name);
    }

    List<String> typeEmployments = [];
    List<String> shedules = [];

    for (ObjectId val in user.typeEmployments) {
      typeEmployments.add(val.value);
    }

    for (ObjectId val in user.schedules) {
      shedules.add(val.value);
    }

    final String mission =
        "${user.readyMission ? "Готовность" : "Неготовность"} к командировкам\n${user.readyMove ? "Готовность" : "Неготовность"} к переезду";

    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(borderRadiusPage),
        ),
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
              Text(
                user.previusJob,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: colorTextContrast,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: defaultPadding),
              Text(
                "${user.firstName} ${user.surname}, $years лет",
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: colorTextContrast,
                    ),
              ),
              const SizedBox(height: defaultPadding / 2),
              Text(
                user.region.value,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: colorTextContrast,
                    ),
              ),
              const SizedBox(height: defaultPadding),
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(borderRadiusPage),
                ),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: defaultPadding),
                      Center(
                        child: Container(
                          width: 50,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius),
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                      _GroupTile(
                        title: "Должность",
                        tiles: [
                          _Tile(
                            title: user.previusJob,
                            subtitle: "Зарплата от ${user.coast} руб.",
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CareerInfo.create(
                                  user.previusJob,
                                  user.coast,
                                  (vacancy, coast) =>
                                      model.saveCareer(vacancy, coast)),
                            )),
                          ),
                          _Tile(
                            title: "Профессиональные навыки",
                            subtitle: skills,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SkillsProfile(
                                  initSkills: skills,
                                  setSkills: (List<String> skills) {},
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      _GroupTile(
                        title: "Опыт работы",
                        tiles: [
                          _Tile(
                            title: getExpierenceString(user.experience),
                            onTap: () {},
                          ),
                        ],
                      ),
                      _GroupTile(
                        title: "Образование",
                        tiles: [
                          _Tile(
                            title: getEducationString(user.education),
                            onTap: () {},
                          ),
                        ],
                      ),
                      _GroupTile(
                        title: "Дополнительно",
                        tiles: [
                          _Tile(
                            title: "Занятость",
                            subtitle: typeEmployments.join(", "),
                            onTap: () {},
                          ),
                          _Tile(
                            title: "График работы",
                            subtitle: shedules.join(", "),
                            onTap: () {},
                          ),
                          _Tile(
                            title: "Категория прав",
                            subtitle: drivingLicence.join(", "),
                            onTap: () {},
                          ),
                          _Tile(
                            title: "Командировки и переезд",
                            subtitle: mission,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GroupTile extends StatelessWidget {
  final List<_Tile> tiles;
  final String title;
  const _GroupTile({
    Key? key,
    required this.tiles,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> data = [
      const SizedBox(height: defaultPadding / 2),
      Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Text(
          title,
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      const Divider(),
    ];
    for (_Tile tile in tiles) {
      data.add(tile);
      data.add(const Divider());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data,
    );
  }
}

class _Tile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _Tile({
    Key? key,
    required this.title,
    this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle == "" ? "Не указано" : subtitle!,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: colorTextSecondary,
                  ),
            ),
      trailing: SvgPicture.asset("assets/icons/arrow_forward.svg"),
      onTap: onTap,
    );
  }
}
