// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/profile_employer_service.dart';
import 'package:sisbi/models/employer_data_model.dart';
import 'package:sisbi/models/tile_data.dart';
import 'package:sisbi/models/vacancy_model.dart';
import 'package:sisbi/ui/widgets/about_page.dart';
import 'package:sisbi/ui/pages/employer/pages/profile/widgets/personal_data_employer.dart';
import 'package:sisbi/ui/widgets/action_bottom.dart';
import 'package:sisbi/ui/widgets/profile/email_profile_user.dart';

import 'widgets/company_profile.dart';

class _ViewModelState {
  final String email;
  final String about;

  _ViewModelState({
    this.email = "",
    this.about = "",
  });

  _ViewModelState copyWith({
    String? email,
    String? about,
  }) {
    return _ViewModelState(
      email: email ?? this.email,
      about: about ?? this.about,
    );
  }
}

class ProfileEmployerViewModel extends ChangeNotifier {
  final BuildContext _context;
  ProfileEmployerViewModel(this._context) {
    _init();
  }

  final ProfileEmployerService _service = ProfileEmployerService();
  _ViewModelState _state = _ViewModelState();

  String? _token;

  Future<void> _init() async {
    _isLoading = true;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
    _token = await _service.getEmployerToken();
    _employerData = await _service.getEmployerData(_token!);
    _vacancies = await _service.getEmployerVacancies(_token!);
    _state = _state.copyWith(
        email: _employerData!.email, about: _employerData!.about);

    _isLoading = false;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
  }

  void reload() => _init();

  EmployerDataModel? _employerData;
  EmployerDataModel? get employerData => _employerData;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isFirst = false;
  bool get isFirst => _isFirst;

  List<VacancyModel> _vacancies = [];
  List<VacancyModel> get vacancies => _vacancies;

  void setPage(bool isFirst) {
    _isFirst = isFirst;
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
      await _service.uploadAvatar(image!.path, _token!);
      _init();
    } catch (e) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentRed,
          content: Text(
            "Ошибка загрузки",
            style: Theme.of(_context).textTheme.subtitle2!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
    }
  }

  void openEmailScreen() => Navigator.of(_context).push(
        MaterialPageRoute(
          builder: (context) => EmailProfilePage(
            initValue: _state.email,
            setEmail: _saveEmail,
          ),
        ),
      );

  void openAboutScreen() => Navigator.of(_context).push(
        MaterialPageRoute(
          builder: (context) => AboutPage(
            initAbout: _state.about,
            onSave: (String about) {
              _state = _state.copyWith(about: about);
              notifyListeners();
              _saveAbout();
            },
            isVacancy: false,
            isEmployee: false,
          ),
        ),
      );

  Future<void> _saveEmail(String email) async {
    try {
      await _service.saveEmail(email, _token!);
      _init();
    } catch (e) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentRed,
          content: Text(
            "Ошибка загрузки",
            style: Theme.of(_context).textTheme.subtitle2!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
    }
  }

  Future<void> _saveAbout() async {
    try {
      await _service.saveAbout(_state.about, _token!);
      _init();
    } catch (e) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentRed,
          content: Text(
            "Ошибка загрузки",
            style: Theme.of(_context).textTheme.subtitle2!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
    }
  }

  Future<void> deleteVacancy(int chatId) async {
    try {
      await _service.deleteVacancy(chatId, _token!);
      _init();
    } catch (e) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentRed,
          content: Text(
            "Ошибка",
            style: Theme.of(_context).textTheme.subtitle2!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
    }
  }

  Future<void> logout() async {
    await _service.logout();
    Navigator.of(_context).pushNamedAndRemoveUntil(
      NameRoutes.login,
      (route) => false,
    );
  }
}

class ProfileEmployerPage extends StatelessWidget {
  const ProfileEmployerPage({Key? key}) : super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => ProfileEmployerViewModel(context),
        child: const ProfileEmployerPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProfileEmployerViewModel>(context);
    final bool isLoading = model.isLoading;
    final bool isFirst = model.isFirst;

    return Scaffold(
      backgroundColor: colorAccentDarkBlue,
      appBar: AppBar(
        title: Text(
          isFirst ? "Профиль компании" : "Мой профиль",
          style: Theme.of(context).textTheme.headline3!.copyWith(
                color: colorTextContrast,
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: SvgPicture.asset("assets/icons/settings.svg"),
          // ),
          // ignore: todo
          //TODO: разобраться с настройками!
          IconButton(
            onPressed: () => showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(borderRadiusPage))),
              context: context,
              builder: (context) => ActionButton(
                tiles: [
                  TileData(
                    title: "Полтика",
                    asset: "assets/icons/arrow_forward.svg",
                    isRed: false,
                    onTap: () {},
                  ),
                  TileData(
                    title: "Написать разработчикам",
                    asset: "assets/icons/arrow_forward.svg",
                    isRed: false,
                    onTap: () {},
                  ),
                  TileData(
                    title: "Выйти из аккаунта",
                    asset: "assets/icons/logout.svg",
                    isRed: true,
                    onTap: model.logout,
                  ),
                ],
              ),
            ),
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: colorIconContrast),
            )
          : Column(
              children: [
                _Header(isFirst: isFirst),
                isFirst ? const CompanyProfile() : const PersonalDataEmployer(),
              ],
            ),
    );
  }
}

class _Header extends StatelessWidget {
  final bool isFirst;
  const _Header({
    Key? key,
    required this.isFirst,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProfileEmployerViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () => model.setPage(true),
              child: Text(
                "Мои вакансии",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: colorTextContrast,
                      fontWeight: isFirst ? FontWeight.w600 : FontWeight.normal,
                    ),
              ),
              style: isFirst
                  ? Theme.of(context).textButtonTheme.style!.copyWith(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            colorAccentLightBlue),
                      )
                  : Theme.of(context).textButtonTheme.style!.copyWith(
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(color: Colors.white, width: 1.5),
                        ),
                      ),
            ),
          ),
          const SizedBox(width: defaultPadding),
          Expanded(
            child: TextButton(
              onPressed: () => model.setPage(false),
              child: Text(
                "О компании",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: colorTextContrast,
                      fontWeight:
                          !isFirst ? FontWeight.w600 : FontWeight.normal,
                    ),
              ),
              style: !isFirst
                  ? Theme.of(context).textButtonTheme.style!.copyWith(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            colorAccentLightBlue),
                      )
                  : Theme.of(context).textButtonTheme.style!.copyWith(
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(color: Colors.white, width: 1.5),
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
