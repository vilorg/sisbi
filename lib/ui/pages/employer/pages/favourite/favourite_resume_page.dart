import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/card_employer_service.dart';
import 'package:sisbi/models/user_data_model.dart';
import 'package:sisbi/ui/inherited_widgets/home_inherited_widget.dart';
import 'package:sisbi/ui/widgets/resume/resume_static_card.dart';
import 'package:sisbi/ui/widgets/vacancy/vacancy_static_card.dart';

class _ViewModel extends ChangeNotifier {
  _ViewModel(this._context) {
    _init();
  }

  final BuildContext _context;
  final CardEmployerService _cardService = CardEmployerService();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<UserDataModel> _resume = [];
  List<UserDataModel> get resumes => _resume;

  Future<void> _init() async {
    try {
      _resume = await _cardService.getFavouriteResumeList();
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

  Future<void> unstarVacancy(int resumeId) async {
    String token = HomeInheritedWidget.of(_context)!.token;
    _isLoading = true;
    await _cardService.unstarResume(token, resumeId);
    _resume = await _cardService.getFavouriteResumeList();
    _isLoading = false;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
  }
}

class FavouriteResumePage extends StatelessWidget {
  const FavouriteResumePage({Key? key}) : super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => _ViewModel(context),
        child: const FavouriteResumePage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_ViewModel>(context);
    final resumes = model.resumes;
    final bool isLoading = model.isLoading;

    List<Widget> data = [];
    for (var resume in resumes) {
      data.add(_FavouriteCard(resume: resume));
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
  final UserDataModel resume;

  const _FavouriteCard({
    Key? key,
    required this.resume,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_ViewModel>(context);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ResumeStaticCard(
          createdAt: resume.createdAt.toString(),
          title: resume.previusJob,
          description: resume.about,
          avatar: resume.avatar,
          salary: resume.coast,
          name: "${resume.firstName} ${resume.surname}",
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
                child: resume.avatar != ""
                    ? Image.network(resume.avatar, fit: BoxFit.cover)
                    : Image.asset("assets/images/avatar.png",
                        fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${resume.firstName} ${resume.surname}",
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    resume.previusJob,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    "От ${resume.coast} руб.",
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
                onPressed: () => model.unstarVacancy(resume.id),
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
