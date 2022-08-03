// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/constants.dart';

import 'package:sisbi/domain/services/profile_service.dart';

class _ViewModel extends ChangeNotifier {
  final String initState;
  final int initCoast;
  _ViewModel(this.initState, this.initCoast) {
    _vacancyController.text = initState;
    _coastController.text = initCoast.toString();
    _init();
  }

  final ProfileService _service = ProfileService();

  final TextEditingController _vacancyController = TextEditingController();
  TextEditingController get vacancyController => _vacancyController;

  final TextEditingController _coastController = TextEditingController();
  TextEditingController get coastController => _coastController;

  List<String> _vacancies = [];
  List<String> get vacancies => _vacancies;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isAvaible = true;
  bool get isAvaible => _isAvaible;

  Future<void> _init() async {
    _isLoading = true;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
    _vacancies = await _service.getNamedVacancies(_vacancyController.text);
    _isLoading = false;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
  }

  Future<void> refreshVacancies() async => await _init();

  void onVacancyTap(String text) {
    _vacancyController.text = text;
    _isAvaible = false;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
  }

  Future<void> onTap() async {
    _isAvaible = true;
    _vacancyController.clear();
    await _init();
  }
}

class CareerInfo extends StatelessWidget {
  final Function(String, int) setCareer;
  const CareerInfo({
    Key? key,
    required this.setCareer,
  }) : super(key: key);

  static Widget create(
          String initVacancy, int initCoast, Function(String, int) setCareer) =>
      ChangeNotifierProvider(
        create: (context) => _ViewModel(initVacancy, initCoast),
        child: CareerInfo(setCareer: setCareer),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_ViewModel>(context);
    final bool isLoading = model.isLoading;
    final bool isAvaible = model.isAvaible;
    final List<String> vacancies = model.vacancies;
    final TextEditingController vacancyController = model.vacancyController;
    final TextEditingController coastController = model.coastController;

    List<Widget> data = [];

    if (isAvaible) {
      if (isLoading) {
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
                ? null
                : int.tryParse(coastController.text) == null
                    ? null
                    : () {
                        setCareer(
                          vacancyController.text,
                          int.parse(coastController.text),
                        );
                        Navigator.of(context).pop();
                      },
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
