// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/enum_classes.dart';
import 'package:sisbi/models/filter_model.dart';
import 'package:sisbi/models/object_id.dart';
import 'package:sisbi/ui/pages/employee/pages/vacancy/vacancuies_switcher_view_model.dart';
import 'package:sisbi/ui/pages/employer/pages/resume/resumes_switcher_view_model.dart';
import 'package:sisbi/ui/widgets/search/post_search_page.dart';
import 'package:sisbi/ui/widgets/search/widgets/wrap_ismale_tabs.dart';
import 'package:sisbi/ui/widgets/select_wrap_card.dart';

import 'coast_search_page.dart';
import 'region_search_page.dart';
import 'widgets/fields_of_activity_tabs.dart';
import 'widgets/wrap_expierence_tabs.dart';
import 'widgets/wrap_schedules_tabs.dart';
import 'widgets/wrap_type_employments_tabs.dart';

class SearchViewModel extends ChangeNotifier {
  SearchViewModel(this.context, this.userModel, this.employerModel) {
    _isUser = userModel != null;
    _filter = _isUser ? userModel!.filter : employerModel!.filter;
  }

  final BuildContext context;
  final VacanciesSwitcherViewModel? userModel;
  final ResumesSwitcherViewModel? employerModel;

  bool _isUser = false;

  FilterModel get filter => _filter;
  late FilterModel _filter;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool get isEmployer => employerModel != null;

  void setRegion(ObjectId value) {
    _filter = _filter.copyWith(region: value);
    // _isUser ? userModel!.setFilter(_filter) : employerModel!.setFilter(_filter);
    notifyListeners();
  }

  void setCoast(int value) {
    _filter = _filter.copyWith(coast: value);
    // _isUser ? userModel!.setFilter(_filter) : employerModel!.setFilter(_filter);
    notifyListeners();
  }

  void setPost(String value) {
    _filter = _filter.copyWith(post: value);
    // _isUser ? userModel!.setFilter(_filter) : employerModel!.setFilter(_filter);
    notifyListeners();
  }

  void setJobCategory(ObjectId value, bool isRemove) {
    List<ObjectId> arr = _filter.jobCategory;
    isRemove ? arr.remove(value) : arr.add(value);
    _filter = _filter.copyWith(jobCategory: arr);
    // _isUser ? userModel!.setFilter(_filter) : employerModel!.setFilter(_filter);
    notifyListeners();
  }

  void setExpierence(Expierence expierence) {
    if (_filter.expierence == expierence) {
      _filter = _filter.copyWith(expierence: Expierence.notChosed);
    } else {
      _filter = _filter.copyWith(expierence: expierence);
    }
    notifyListeners();
  }

  void setMale(bool isMan, bool isWooman) {
    _filter = _filter.copyWith(isMan: isMan, isWoman: isWooman);
    notifyListeners();
  }

  void setTypeEmployments(ObjectId value) {
    List<ObjectId> arr = _filter.typeEmployments;
    for (var i in arr) {
      if (i.id == value.id) {
        arr.remove(i);
        _filter = _filter.copyWith(typeEmployments: arr);
        // _isUser
        //     ? userModel!.setFilter(_filter)
        //     : employerModel!.setFilter(_filter);
        notifyListeners();
        return;
      }
    }
    arr.add(value);
    _filter = _filter.copyWith(typeEmployments: arr);
    // _isUser ? userModel!.setFilter(_filter) : employerModel!.setFilter(_filter);
    notifyListeners();
  }

  void setSchedules(ObjectId value) {
    List<ObjectId> arr = _filter.schedules;
    for (var i in arr) {
      if (i.id == value.id) {
        arr.remove(i);
        _filter = _filter.copyWith(schedules: arr);
        // _isUser
        //     ? userModel!.setFilter(_filter)
        //     : employerModel!.setFilter(_filter);
        notifyListeners();
        return;
      }
    }
    arr.add(value);
    _filter = _filter.copyWith(schedules: arr);
    // _isUser ? userModel!.setFilter(_filter) : employerModel!.setFilter(_filter);
    notifyListeners();
  }

  void clearFilter() {
    _filter = FilterModel.deffault();
    // _isUser ? userModel!.setFilter(_filter) : employerModel!.setFilter(_filter);
    notifyListeners();
  }

  Future<void> onPop() async {
    _isLoading = true;
    notifyListeners();
    _isUser ? userModel!.setFilter(_filter) : employerModel!.setFilter(_filter);
    _isUser ? await userModel!.resetCards() : await employerModel!.resetCards();
    _isLoading = false;
    notifyListeners();
    Navigator.pop(context);
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  static Widget create(VacanciesSwitcherViewModel? userModel,
          ResumesSwitcherViewModel? employerMode) =>
      ChangeNotifierProvider(
        create: (context) => SearchViewModel(context, userModel, employerMode),
        child: const SearchPage(),
      );

  @override
  Widget build(BuildContext context) {
    final SearchViewModel model = Provider.of<SearchViewModel>(context);
    final bool isLoading = model.isLoading;
    final bool isEmployer = model.isEmployer;

    return Scaffold(
      backgroundColor: colorAccentDarkBlue,
      appBar: AppBar(
        title: Text(
          isEmployer ? "Поиск по резюме" : "Поиск по вакансиям",
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: colorTextContrast,
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: [
          IconButton(
            onPressed: model.clearFilter,
            icon: SvgPicture.asset("assets/icons/trash_icon.svg"),
          ),
        ],
      ),
      body: ClipRRect(
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(borderRadiusPage)),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Column(
                  children: [
                    SelectWrapCard(
                      onTap: () => Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  PostSearchPage.create(model),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
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
                      title: "Должность",
                      value: model.filter.post != "" ? model.filter.post : null,
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    SelectWrapCard(
                        onTap: () => Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        RegionSearchPage.create(model),
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
                        title: "Регион",
                        value: model.filter.region.value == ""
                            ? null
                            : model.filter.region.value),
                    const SizedBox(height: defaultPadding / 2),
                    SelectWrapCard(
                      onTap: () => Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  CoastSearchPage(model: model),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
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
                      title: "Зарплата, от",
                      value: model.filter.coast != 0
                          ? "${model.filter.coast.toString().substring(0, model.filter.coast.toString().length - 3)} ${model.filter.coast.toString().substring(model.filter.coast.toString().length - 3)} руб."
                          : null,
                    ),
                    FieldsOfActivityTabs(model: model),
                    isEmployer
                        ? WrapIsMaleTabs(model: model)
                        : const SizedBox(),
                    SizedBox(height: isEmployer ? defaultPadding : 0),
                    WrapExpierenceTabs(model: model),
                    const SizedBox(height: defaultPadding),
                    WrapTypeEmploymentsTabs(model: model),
                    const SizedBox(height: defaultPadding),
                    WrapSchedulesTabs(model: model),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(26, 26, 26, 0.05),
                    blurRadius: 15,
                  ),
                ],
              ),
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: ElevatedButton(
                  onPressed: () async => await model.onPop(),
                  child: Padding(
                    padding: const EdgeInsets.all(defaultButtonPadding),
                    child: !isLoading
                        ? Text("Применить фильтры (${model.filter.count()})")
                        : const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: colorIconContrast,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
