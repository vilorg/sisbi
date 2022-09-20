// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/constants.dart';

import 'package:sisbi/domain/services/profile_user_service.dart';
import 'package:sisbi/models/object_id.dart';
import 'package:sisbi/ui/widgets/profile/field_of_activity_select_page.dart';

class _ViewModel extends ChangeNotifier {
  final ObjectId initJobCategory;
  final String initVacancy;
  final int initCoast;
  _ViewModel(this.initVacancy, this.initCoast, this.initJobCategory) {
    _vacancyController.text = initVacancy;
    _coastController.text = initCoast.toString();
    _jobCategory = initJobCategory;
    _init();
  }

  final ProfileUserService _service = ProfileUserService();

  final TextEditingController _vacancyController = TextEditingController();
  TextEditingController get vacancyController => _vacancyController;

  final TextEditingController _coastController = TextEditingController();
  TextEditingController get coastController => _coastController;

  List<String> _vacancies = [];
  List<String> get vacancies => _vacancies;

  bool _isLoadingVacancies = false;
  bool get isLoadingVacancies => _isLoadingVacancies;

  bool _isAvaibleVacancies = true;
  bool get isAvaibleVacancies => _isAvaibleVacancies;

  List<ObjectId> _jobCategories = [];
  List<ObjectId> get jobCategories => _jobCategories;

  bool _isLoadingjobCategories = false;
  bool get isLoadingjobCategories => _isLoadingjobCategories;

  ObjectId? _jobCategory;
  ObjectId? get jobCategory => _jobCategory;

  Future<void> _init() async {
    if (_vacancyController.text != "") _isAvaibleVacancies = false;
    _isLoadingVacancies = true;
    _isLoadingjobCategories = true;
    try {
      notifyListeners();
    } catch (e) {
      _isLoadingVacancies = false;
    }
    _vacancies = await _service.getNamedVacancies(_vacancyController.text);
    _jobCategories = await _service.getNamedJobCategories();
    _isLoadingVacancies = false;
    _isLoadingjobCategories = false;
    try {
      notifyListeners();
    } catch (e) {
      _isLoadingVacancies = false;
    }
  }

  Future<void> refreshVacancies() async {
    _isLoadingVacancies = true;
    try {
      notifyListeners();
    } catch (e) {
      _isLoadingVacancies = false;
    }
    _vacancies = await _service.getNamedVacancies(_vacancyController.text);
    _isLoadingVacancies = false;
    try {
      notifyListeners();
    } catch (e) {
      _isLoadingVacancies = false;
    }
  }

  void onVacancyTap(String text) {
    _vacancyController.text = text;
    _isAvaibleVacancies = false;
    try {
      notifyListeners();
    } catch (e) {
      _isLoadingVacancies = false;
    }
  }

  Future<void> onTap() async {
    _isAvaibleVacancies = true;
    _vacancyController.clear();
    await refreshVacancies();
  }

  void onJobCategoryTap(ObjectId? jobCategory) {
    if (jobCategory != null && jobCategory.value == "") return;
    _jobCategory = jobCategory;
    notifyListeners();
  }
}

class CareerInfo extends StatelessWidget {
  final Function(String, int, ObjectId) setCareer;
  const CareerInfo({Key? key, required this.setCareer}) : super(key: key);

  static Widget create(
          String initVacancy,
          int initCoast,
          ObjectId initJobCategory,
          Function(String, int, ObjectId) setCareer) =>
      ChangeNotifierProvider(
        create: (context) =>
            _ViewModel(initVacancy, initCoast, initJobCategory),
        child: CareerInfo(setCareer: setCareer),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_ViewModel>(context);
    final bool isLoadingVacancy = model.isLoadingVacancies;
    final bool isAvaible = model.isAvaibleVacancies;
    final List<String> vacancies = model.vacancies;
    final TextEditingController vacancyController = model.vacancyController;
    final TextEditingController coastController = model.coastController;
    final bool isLoadingjobCategories = model.isLoadingjobCategories;
    final List<ObjectId> jobCategories = model.jobCategories;
    final ObjectId? jobCategory = model.jobCategory;

    List<Widget> data = [];

    if (isAvaible) {
      if (isLoadingVacancy) {
        data = [
          const CircularProgressIndicator(color: colorAccentDarkBlue),
        ];
      } else {
        for (String vacancy in vacancies) {
          data.add(
            ListTile(
              title: Text(
                vacancy,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              onTap: () => model.onVacancyTap(vacancy),
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Должность",
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: colorTextContrast,
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: [
          TextButton(
            onPressed: isAvaible
                ? () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: colorAccentRed,
                    content: Text("Заполните должность!",
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: colorTextContrast,
                              fontWeight: FontWeight.w600,
                            ))))
                : int.tryParse(coastController.text) == null ||
                        int.tryParse(coastController.text) == 0 ||
                        coastController.text[0] == "0"
                    ? () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: colorAccentRed,
                        content: Text("Заполните корректно зарплату!",
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: colorTextContrast,
                                      fontWeight: FontWeight.w600,
                                    ))))
                    : jobCategory!.value != ""
                        ? () {
                            setCareer(
                              vacancyController.text,
                              int.parse(coastController.text),
                              jobCategory,
                            );
                            Navigator.of(context).pop();
                          }
                        : () => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: colorAccentRed,
                                content: Text("Заполните сферу!",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                          color: colorTextContrast,
                                          fontWeight: FontWeight.w600,
                                        )))),
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
                padding: const EdgeInsets.all(defaultPadding),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: model.onTap,
                        child: TextField(
                          controller: vacancyController,
                          decoration: const InputDecoration(
                            hintText: "Название должности",
                          ),
                          style: Theme.of(context).textTheme.bodyText1,
                          onChanged: (e) => model.refreshVacancies(),
                          enabled: isAvaible,
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      const SizedBox(height: defaultPadding),
                      ...data,
                      const SizedBox(height: defaultPadding),
                      TextField(
                        controller: coastController,
                        decoration: InputDecoration(
                            hintText: "Ожидаемая зарплата",
                            suffixIcon: SizedBox(
                              width: 1,
                              child: Center(
                                child: Text(
                                  "руб.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: colorTextSecondary,
                                      ),
                                ),
                              ),
                            )),
                        style: Theme.of(context).textTheme.bodyText1,
                        keyboardType: TextInputType.number,
                        onChanged: (s) => model.refreshVacancies(),
                      ),
                      const SizedBox(height: defaultPadding),
                      // !isLoadingjobCategories
                      //     ? DropdownButton<String>(
                      //         isExpanded: true,
                      //         value: jobCategory!.value,
                      //         elevation: 16,
                      //         style: Theme.of(context).textTheme.bodyText1,
                      //         onChanged: (String? newValue) {
                      //           ObjectId val = jobCategories.firstWhere(
                      //               (element) => element.value == newValue);
                      //           model.onJobCategoryTap(val);
                      //         },
                      //         items: jobCategories
                      //             .map((e) => e.value)
                      //             .map<DropdownMenuItem<String>>(
                      //                 (String value) {
                      //           return DropdownMenuItem<String>(
                      //             value: value,
                      //             child: Text(value),
                      //           );
                      //         }).toList()
                      //           ..add(const DropdownMenuItem<String>(
                      //             value: "",
                      //             child: Text(""),
                      //           )),
                      //       )
                      //     : const CircularProgressIndicator(
                      //         color: colorAccentDarkBlue),
                      !isLoadingjobCategories
                          ? GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      FieldOfActivitySelectPage(
                                          fieldsOfActivity: jobCategories,
                                          setFieldOfActivity:
                                              model.onJobCategoryTap),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
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
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: colorInput, width: 2),
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                ),
                                padding:
                                    const EdgeInsets.all(defaultButtonPadding),
                                child: Row(
                                  children: jobCategory == null ||
                                          jobCategory.value == ""
                                      ? [
                                          SvgPicture.asset(
                                              "assets/icons/add.svg"),
                                          const SizedBox(
                                              width: defaultPadding / 2),
                                          Text(
                                            "Добавить сферу деятельности",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  color: colorText,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ]
                                      : [
                                          Text(
                                            jobCategory.value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  color: colorText,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ],
                                ),
                              ),
                            )
                          : const CircularProgressIndicator(
                              color: colorAccentDarkBlue),
                      const SizedBox(height: defaultPadding),
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
