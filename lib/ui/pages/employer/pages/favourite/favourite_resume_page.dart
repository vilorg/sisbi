// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/card_employer_service.dart';
import 'package:sisbi/models/enum_classes.dart';
import 'package:sisbi/models/object_id.dart';
import 'package:sisbi/models/user_data_model.dart';
import 'package:sisbi/ui/widgets/resume/resume_static_card.dart';

class _ViewModel extends ChangeNotifier {
  _ViewModel(this._context) {
    _init();
  }

  final BuildContext _context;
  final CardEmployerService _cardService = CardEmployerService();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<UserDataModel> _resumes = [];
  List<UserDataModel> get resumes => _resumes;

  List<ObjectId> _vacancies = [];
  List<ObjectId> get vacancies => _vacancies;

  Future<void> _init() async {
    try {
      _resumes = await _cardService.getFavouriteResumeList();
      _vacancies = await _cardService.getVacancies();
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
    _isLoading = true;
    await _cardService.unstarResume(resumeId);
    _resumes = await _cardService.getFavouriteResumeList();
    _isLoading = false;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
  }

  Future<void> sendMessage(
      BuildContext newContext, String text, int vacancyId, int userId) async {
    try {
      await _cardService.respondResume(vacancyId, userId, text);
      Navigator.pop(newContext);
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentDarkBlue,
          content: Text(
            "Вы успешно откликнулись на резюме!",
            style: Theme.of(_context).textTheme.bodyText1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      );
    } on DoubleResponseException {
      Navigator.pop(newContext);
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentRed,
          content: Text(
            "Вы уже приглашали этого соискателя!",
            style: Theme.of(_context).textTheme.bodyText1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      );
    } catch (e) {
      Navigator.pop(newContext);
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentRed,
          content: Text(
            "Произошла ошибка!",
            style: Theme.of(_context).textTheme.bodyText1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      );
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
      data.add(_FavouriteCard(
        resume: resume,
        sendMessage: (BuildContext newContext, String message, int vacancyId) =>
            model.sendMessage(
          newContext,
          message,
          vacancyId,
          resume.id,
        ),
      ));
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
  final Function(BuildContext, String, int) sendMessage;

  const _FavouriteCard({
    Key? key,
    required this.resume,
    required this.sendMessage,
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
          expierence: resume.experience,
          region: resume.region,
          email: resume.email,
          phone: resume.phone,
          sendMessage: sendMessage,
          isChat: false,
          vacancies: model.vacancies,
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
