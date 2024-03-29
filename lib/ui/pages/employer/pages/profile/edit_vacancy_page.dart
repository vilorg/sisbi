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
import 'package:sisbi/models/vacancy_model.dart';
import 'package:sisbi/ui/widgets/about_page.dart';
import 'package:sisbi/ui/pages/employer/pages/profile/widgets/contacts_employer_page.dart';
import 'package:sisbi/ui/widgets/profile/career_info.dart';
import 'package:sisbi/ui/widgets/profile/city_profile_page.dart';
import 'package:sisbi/ui/widgets/select_wrap_card.dart';
import 'package:sisbi/ui/widgets/wrap_cards.dart';

import 'create_vacancy_page.dart';

class _ViewModel extends ChangeNotifier {
  final VoidCallback onPop;
  final VacancyModel vacancy;
  final BuildContext _context;
  _ViewModel(this._context, this.vacancy, this.onPop) {
    _state = _state.copyWith(
      title: vacancy.title,
      city: ObjectId(vacancy.cityId, vacancy.cityName),
      coast: vacancy.salary,
      description: vacancy.description,
      email: vacancy.email,
      expierence: vacancy.experience,
      fullName: vacancy.fullName,
      jobCategory: ObjectId(vacancy.jobCategoryId, vacancy.jobCategoryName),
      pathAvatar: vacancy.avatar,
      phone: vacancy.phone,
      schedules: vacancy.schedules,
      typeEmployments: vacancy.typeEmployments,
    );
  }

  bool get isNetworkAvatar => vacancy.avatar == _state.pathAvatar;

  VacancyState _state = VacancyState();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  VacancyState get state => _state;
  final VacancyEmployerService _service = VacancyEmployerService();

  Future<void> onTap() async {
    if (!_state.isFullData()) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentRed,
          content: Text(
            "Заполните данные полностью!",
            style: Theme.of(_context).textTheme.subtitle2!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
      return;
    }

    _isLoading = true;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }

    try {
      await _service.updateVacancy(vacancy.id, state, isNetworkAvatar);
      onPop();
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentGreen,
          content: Text(
            "Вакансия успешно создалась!",
            style: Theme.of(_context).textTheme.subtitle2!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
      Navigator.of(_context).pop();
    } catch (e) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentRed,
          content: Text(
            "Ошибка!",
            style: Theme.of(_context).textTheme.subtitle2!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
    }
    _isLoading = false;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
  }

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

class EditVacancyPage extends StatelessWidget {
  const EditVacancyPage({Key? key}) : super(key: key);

  static Widget create(VacancyModel vacancy, VoidCallback onPop) =>
      ChangeNotifierProvider(
        create: ((context) => _ViewModel(context, vacancy, onPop)),
        child: const EditVacancyPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_ViewModel>(context);
    final state = model.state;
    final bool isLoading = model.isLoading;
    final bool isNetworkAvatar = model.isNetworkAvatar;

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
        child: isNetworkAvatar
            ? Image.network(
                state.pathAvatar,
                width: 132,
                height: 132,
              )
            : Image.file(
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
            onPressed: isLoading ? null : model.onTap,
            child: isLoading
                ? const CircularProgressIndicator(
                    color: colorIconContrast, strokeWidth: 1)
                : Text(
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
                            builder: (context) => AboutPage(
                              initAbout: state.description,
                              isVacancy: true,
                              onSave: (String about) =>
                                  model.setState(description: about),
                              isEmployee: false,
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
                            .map((e) => state.typeEmployments
                                .map((e) => e.id)
                                .toList()
                                .contains(e.id))
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
                            .map((e) => state.schedules
                                .map((e) => e.id)
                                .toList()
                                .contains(e.id))
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
                              setContacts: (String fullName, String phone,
                                      String email) =>
                                  model.setState(
                                fullName: fullName,
                                phone: phone,
                                email: email,
                              ),
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
