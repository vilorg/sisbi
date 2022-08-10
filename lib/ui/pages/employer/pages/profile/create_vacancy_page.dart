// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/vacancy_employer_service.dart';
import 'package:sisbi/models/enum_classes.dart';
import 'package:sisbi/models/object_id.dart';
import 'package:sisbi/ui/pages/employer/pages/profile/widgets/about_employer_page.dart';
import 'package:sisbi/ui/pages/employer/pages/profile/widgets/contacts_employer_page.dart';
import 'package:sisbi/ui/widgets/profile/career_info.dart';
import 'package:sisbi/ui/widgets/profile/city_profile_page.dart';
import 'package:sisbi/ui/widgets/select_wrap_card.dart';
import 'package:sisbi/ui/widgets/wrap_tards.dart';

class _ViewModelState {
  final String pathAvatar;
  final String title;
  final ObjectId jobCategory;
  final int coast;
  final String description;
  final ObjectId city;
  final Expierence expierence;
  final List<ObjectId> typeEmployments;
  final List<ObjectId> schedules;
  final String fullName;
  final String phone;
  final String email;

  _ViewModelState({
    this.pathAvatar = "",
    this.title = "",
    this.jobCategory = const ObjectId(0, ""),
    this.coast = 0,
    this.description = "",
    this.city = const ObjectId(0, ""),
    this.expierence = Expierence.notChosed,
    this.typeEmployments = const [],
    this.schedules = const [],
    this.fullName = "",
    this.phone = "",
    this.email = "",
  });

  _ViewModelState copyWith({
    String? pathAvatar,
    String? title,
    ObjectId? jobCategory,
    int? coast,
    String? description,
    ObjectId? city,
    Expierence? expierence,
    List<ObjectId>? typeEmployments,
    List<ObjectId>? schedules,
    String? fullName,
    String? phone,
    String? email,
  }) {
    return _ViewModelState(
      pathAvatar: pathAvatar ?? this.pathAvatar,
      title: title ?? this.title,
      jobCategory: jobCategory ?? this.jobCategory,
      coast: coast ?? this.coast,
      description: description ?? this.description,
      city: city ?? this.city,
      expierence: expierence ?? this.expierence,
      typeEmployments: typeEmployments ?? this.typeEmployments,
      schedules: schedules ?? this.schedules,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }
}

class _ViewModel extends ChangeNotifier {
  _ViewModelState _state = _ViewModelState();
  _ViewModelState get state => _state;
  final VacancyEmployerService _service = VacancyEmployerService();

  Future<void> pickAvatar() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      _state = _state.copyWith(pathAvatar: image!.path);
      notifyListeners();
    } catch (e) {
      _state;
    }
  }

  void setState({
    String? pathAvatar,
    String? title,
    ObjectId? jobCategory,
    int? coast,
    String? description,
    ObjectId? city,
    Expierence? expierence,
    List<ObjectId>? typeEmployments,
    List<ObjectId>? schedules,
    String? fullName,
    String? phone,
    String? email,
  }) {
    _state = _state.copyWith(
      pathAvatar: pathAvatar ?? _state.pathAvatar,
      title: title ?? _state.title,
      jobCategory: jobCategory ?? _state.jobCategory,
      coast: coast ?? _state.coast,
      description: description ?? _state.description,
      city: city ?? _state.city,
      expierence: expierence ?? _state.expierence,
      typeEmployments: typeEmployments ?? _state.typeEmployments,
      schedules: schedules ?? _state.schedules,
      fullName: fullName ?? _state.fullName,
      phone: phone ?? _state.phone,
      email: email ?? _state.email,
    );
    try {
      notifyListeners();
    } catch (e) {
      _state;
    }
  }
}

class CreateVacancyPage extends StatelessWidget {
  final VoidCallback onPop;
  const CreateVacancyPage({
    Key? key,
    required this.onPop,
  }) : super(key: key);

  static Widget create(VoidCallback onPop) => ChangeNotifierProvider(
        create: ((context) => _ViewModel()),
        child: CreateVacancyPage(onPop: onPop),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_ViewModel>(context);
    final state = model.state;

    Widget avatar = Container(
      width: 132,
      height: 132,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: colorInput),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/preview_avatar.svg"),
          const SizedBox(height: defaultPadding / 2),
          Text(
            "Превью для вакансии",
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: colorTextSecondary,
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    if (state.pathAvatar != "") {
      avatar = ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.file(
          File(state.pathAvatar),
          width: 132,
          height: 132,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Создание вакансии",
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: colorTextContrast,
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Сохранить",
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ],
      ),
      backgroundColor: colorAccentDarkBlue,
      body: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(borderRadiusPage)),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: Column(
                    children: [
                      GestureDetector(onTap: model.pickAvatar, child: avatar),
                      const SizedBox(height: defaultPadding),
                      SelectWrapCard(
                        title: "Название вакансии",
                        value: state.title == "" ? null : state.title,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CareerInfo.create(
                              state.title,
                              state.coast,
                              state.jobCategory,
                              (String title, int coast, ObjectId jobCategory) =>
                                  model.setState(
                                title: title,
                                coast: coast,
                                jobCategory: jobCategory,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SelectWrapCard(
                        title: "Сфера деятельности",
                        value: state.jobCategory.value == ""
                            ? null
                            : state.jobCategory.value,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CareerInfo.create(
                              state.title,
                              state.coast,
                              state.jobCategory,
                              (String title, int coast, ObjectId jobCategory) =>
                                  model.setState(
                                title: title,
                                coast: coast,
                                jobCategory: jobCategory,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SelectWrapCard(
                        title: "Зарплата, от",
                        value: state.coast == 0 ? null : "${state.coast} руб.",
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CareerInfo.create(
                              state.title,
                              state.coast,
                              state.jobCategory,
                              (String title, int coast, ObjectId jobCategory) =>
                                  model.setState(
                                title: title,
                                coast: coast,
                                jobCategory: jobCategory,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SelectWrapCard(
                        title: "Описание вакансии",
                        value:
                            state.description == "" ? null : state.description,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AboutEmployerPage(
                              initAbout: state.description,
                              isVacancy: true,
                              onSave: (String about) =>
                                  model.setState(description: about),
                            ),
                          ),
                        ),
                      ),
                      SelectWrapCard(
                        title: "Регион",
                        value: state.city.value == "" ? null : state.city.value,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CityProfilePage.create(
                              state.city,
                              (ObjectId city) => model.setState(city: city),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      WrapTabs(
                        title: "Опыт работы",
                        variants: Expierence.values
                            .map((e) => getExpierenceString(e))
                            .toList(),
                        values: Expierence.values.map((e) {
                          return e == state.expierence;
                        }).toList(),
                        // const [false, false, false, false, false],
                        setValue: (int i) => model.setState(
                          expierence: getExpierenceFromInt(i - 1),
                        ),
                      ),
                      WrapTabs(
                        title: "Тип занятости",
                        variants: getTypeEmploymentsString()
                            .map((e) => e.value)
                            .toList(),
                        values: getTypeEmploymentsString()
                            .map((e) => state.typeEmployments.contains(e))
                            .toList(),
                        setValue: (int i) {
                          ObjectId typeEmployment = getTypeEmploymentFromInt(i);
                          List<ObjectId> newTypeEmployments =
                              state.typeEmployments;
                          List<ObjectId> typeEmployments = [];
                          for (ObjectId typeEmp in newTypeEmployments) {
                            typeEmployments.add(typeEmp);
                          }
                          if (newTypeEmployments.contains(typeEmployment)) {
                            typeEmployments.remove(typeEmployment);
                          } else {
                            typeEmployments.add(typeEmployment);
                          }
                          model.setState(typeEmployments: typeEmployments);
                        },
                      ),
                      WrapTabs(
                        title: "График работы",
                        variants:
                            getSchedulesString().map((e) => e.value).toList(),
                        values: getSchedulesString()
                            .map((e) => state.schedules.contains(e))
                            .toList(),
                        setValue: (int i) {
                          ObjectId schedule = getSchedulesFromInt(i);
                          List<ObjectId> newSchedules = state.schedules;
                          List<ObjectId> schedules = [];

                          for (ObjectId sched in newSchedules) {
                            schedules.add(sched);
                          }

                          if (newSchedules.contains(schedule)) {
                            schedules.remove(schedule);
                          } else {
                            schedules.add(schedule);
                          }
                          model.setState(schedules: schedules);
                        },
                      ),
                      const Divider(),
                      SelectWrapCard(
                        title: "Контактные данные",
                        value: state.fullName == "" ||
                                state.phone == "" ||
                                state.email == ""
                            ? null
                            : state.fullName,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ContactsEmployerPage(
                              initFullName: state.fullName,
                              initPhone: state.phone,
                              initEmail: state.email,
                              setContacts: (String a, String b, String c) {},
                            ),
                          ),
                        ),
                      ),
                    ],
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
