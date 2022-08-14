import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/card_employee_service.dart';
import 'package:sisbi/models/vacancy_model.dart';
import 'package:sisbi/ui/inherited_widgets/home_inherited_widget.dart';
import 'package:sisbi/ui/widgets/vacancy/vacancy_static_card.dart';

class _ViewModel extends ChangeNotifier {
  _ViewModel(this._context) {
    _init();
  }

  final BuildContext _context;
  final CardEmployeeService _cardService = CardEmployeeService();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<VacancyModel> _vacancies = [];
  List<VacancyModel> get vacancies => _vacancies;

  Future<void> _init() async {
    try {
      _vacancies = await _cardService.getFavouriteVacancyList();
    } catch (e) {
      Navigator.of(_context)
          .pushNamedAndRemoveUntil(NameRoutes.login, (route) => false);
    }
    _isLoading = false;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
  }

  Future<void> unstarVacancy(int vacancyId) async {
    String token = HomeInheritedWidget.of(_context)!.token;
    _isLoading = true;
    await _cardService.unstarVacancy(token, vacancyId);
    _vacancies = await _cardService.getFavouriteVacancyList();
    _isLoading = false;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
  }
}

class FavouriteVacancyPage extends StatelessWidget {
  const FavouriteVacancyPage({Key? key}) : super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => _ViewModel(context),
        child: const FavouriteVacancyPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_ViewModel>(context);
    final vacancies = model.vacancies;
    final bool isLoading = model.isLoading;

    List<Widget> data = [];
    for (var vacancy in vacancies) {
      data.add(_FavouriteCard(vacancy: vacancy));
      data.add(const Divider());
    }

    if (data.isEmpty) {
      data.add(Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Text(
          "У вас нет избранных вакансий...",
          style: Theme.of(context).textTheme.headline6,
        ),
      ));
    }

    return Scaffold(
      backgroundColor: colorAccentDarkBlue,
      appBar: AppBar(
        title: Text("Избранное",
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: colorTextContrast,
                )),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: colorIconContrast),
            )
          : Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(borderRadiusPage)),
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          children: data,
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

class _FavouriteCard extends StatelessWidget {
  final VacancyModel vacancy;

  const _FavouriteCard({
    Key? key,
    required this.vacancy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_ViewModel>(context);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => VacancyStaticCard(
          createdAt: vacancy.createdAt.toString(),
          title: vacancy.title,
          description: vacancy.description,
          employerAvatar: vacancy.employerAvatar,
          avatar: vacancy.avatar,
          salary: vacancy.salary,
          name: vacancy.fullName,
        ),
      )),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 76,
              height: 76,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(vacancy.avatar, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(defaultPadding),
                          child: Image.network(vacancy.employerAvatar),
                        ),
                      ),
                      const SizedBox(width: defaultPadding),
                      Text(
                        vacancy.employerName,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  Text(
                    vacancy.title,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    "От ${vacancy.salary} руб.",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorTextSecondary,
                        ),
                  )
                ],
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromRGBO(237, 237, 240, 1), width: 2),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => model.unstarVacancy(vacancy.id),
                icon: const Icon(
                  Icons.clear,
                  color: colorIconSecondary,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
