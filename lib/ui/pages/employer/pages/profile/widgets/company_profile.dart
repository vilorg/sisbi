// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/employer_data_model.dart';
import 'package:sisbi/models/tile_data.dart';
import 'package:sisbi/models/vacancy_model.dart';
import 'package:sisbi/ui/pages/employer/pages/profile/create_vacancy_page.dart';
import 'package:sisbi/ui/pages/employer/pages/profile/edit_vacancy_page.dart';
import 'package:sisbi/ui/widgets/action_bottom.dart';

import '../profile_employer_page.dart';

class CompanyProfile extends StatelessWidget {
  const CompanyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProfileEmployerViewModel>(context);
    final bool isLoading = model.isLoading;
    final EmployerDataModel? employerData = model.employerData;
    final List<VacancyModel> vacancies = model.vacancies;

    Widget avatar = Image.asset(
      "assets/images/avatar.png",
      width: 132,
      height: 132,
      fit: BoxFit.cover,
    );

    if (!isLoading) {
      if (employerData!.avatar != "") {
        avatar = Image.network(
          employerData.avatar,
          width: 132,
          height: 132,
          fit: BoxFit.cover,
        );
      }
    }

    List<Widget> vacanciesWidgets = [];

    for (VacancyModel vacancy in vacancies) {
      vacanciesWidgets.add(
        _VacancyPreview(
          vacancy: vacancy,
          onTap: () => showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(borderRadiusPage),
              ),
            ),
            context: context,
            builder: (_context) => ActionButton(
              tiles: [
                TileData(
                  title: "Изменить вакансию",
                  asset: "assets/icons/arrow_forward.svg",
                  isRed: false,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (c) =>
                            EditVacancyPage.create(vacancy, model.reload),
                      ),
                    );
                  },
                ),
                TileData(
                  title: "Удалить вакансию",
                  asset: "assets/icons/trash.svg",
                  isRed: true,
                  onTap: () {
                    model.deleteVacancy(vacancy.id);
                    Navigator.of(_context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      );
      vacanciesWidgets.add(const Divider());
    }

    vacanciesWidgets.add(
      Container(
        color: Colors.white,
        width: double.infinity,
        padding: const EdgeInsets.all(defaultPadding),
        child: ElevatedButton(
          child: Padding(
            padding: const EdgeInsets.all(defaultButtonPadding),
            child: Text(
              "Добавить вакансию",
              style: Theme.of(context).textTheme.button,
            ),
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateVacancyPage.create(model.reload),
            ),
          ),
        ),
      ),
    );

    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: model.pickAvatar,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: avatar,
            ),
          ),
          const SizedBox(height: defaultPadding),
          Text(
            employerData!.name,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: defaultPadding),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(borderRadiusPage)),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: vacanciesWidgets,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VacancyPreview extends StatelessWidget {
  final VacancyModel vacancy;
  final VoidCallback onTap;
  const _VacancyPreview({
    Key? key,
    required this.vacancy,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Duration _different =
        DateTime.now().timeZoneOffset - const Duration(hours: 3);
    DateTime updatedAt = vacancy.updatedAt.add(_different);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Обновлено ${updatedAt.day} ${getRusMonthString(updatedAt)} ${updatedAt.year}, ${updatedAt.hour}:${updatedAt.minute}",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: colorTextSecondary,
                      ),
                ),
                const SizedBox(height: defaultPadding / 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      vacancy.title,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: defaultPadding),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Показы",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: colorTextSecondary,
                                    ),
                              ),
                              const SizedBox(height: defaultPadding / 2),
                              Text(
                                vacancy.shows.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: colorAccentDarkBlue,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const VerticalDivider(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Просмотры",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: colorTextSecondary,
                                    ),
                              ),
                              const SizedBox(height: defaultPadding / 2),
                              Text(
                                vacancy.views.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: colorAccentDarkBlue,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const VerticalDivider(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Отклики",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: colorTextSecondary,
                                    ),
                              ),
                              const SizedBox(height: defaultPadding / 2),
                              Text(
                                vacancy.countResponse.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: colorAccentDarkBlue,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const VerticalDivider(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: GestureDetector(
                onTap: onTap,
                child: SvgPicture.asset("assets/icons/detail_button.svg"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
