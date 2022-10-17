// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/profile_user_service.dart';
import 'package:sisbi/models/enum_classes.dart';
import 'package:sisbi/models/object_id.dart';
import 'package:sisbi/models/user_data_model.dart';
import 'package:sisbi/ui/widgets/about_page.dart';
import 'package:sisbi/ui/widgets/profile/city_profile_page.dart';
import 'package:sisbi/ui/widgets/profile/email_profile_user.dart';

class _ViewModelState {
  final String name;
  final String surname;
  final bool isMale;
  final DateTime? birthday;
  final String email;
  final ObjectId? city;
  final String about;

  _ViewModelState({
    this.name = "",
    this.surname = "",
    this.isMale = true,
    this.birthday,
    this.email = "",
    this.city,
    this.about = "",
  });

  _ViewModelState copyWith({
    String? name,
    String? surname,
    bool? isMale,
    DateTime? birthday,
    String? email,
    ObjectId? city,
    String? about,
  }) {
    return _ViewModelState(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      isMale: isMale ?? this.isMale,
      birthday: birthday ?? this.birthday,
      email: email ?? this.email,
      city: city ?? this.city,
      about: about ?? this.about,
    );
  }
}

class ProfileUserViewModel extends ChangeNotifier {
  final BuildContext _context;
  final ProfileUserService _service = ProfileUserService();

  String _token = "";

  _ViewModelState _state = _ViewModelState();
  _ViewModelState get state => _state;

  UserDataModel? _userModel;
  UserDataModel? get userModel => _userModel;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isFirst = true;
  bool get isFirst => _isFirst;

  Future<void> pickAvatar() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      await _service.uploadAvatar(image!.path, _token);
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

  Future<void> saveMission(List<bool> missions) async {
    try {
      await _service.saveMission(missions, _token);
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

  Future<void> saveSchedules(List<int> typeEmployments) async {
    try {
      await _service.saveSchedules(typeEmployments, _token);
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

  Future<void> saveLicences(List<String> licences) async {
    try {
      await _service.saveLicences(licences, _token);
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

  Future<void> saveTypeEmployments(List<int> typeEmployments) async {
    try {
      await _service.saveTypeEmployments(typeEmployments, _token);
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

  Future<void> saveEducation(Education education) async {
    try {
      await _service.saveEducation(education, _token);
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

  Future<void> saveCareer(
      String vacancy, int coast, ObjectId jobCategory) async {
    try {
      await _service.saveCareer(vacancy, coast, jobCategory.id, _token);
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

  Future<void> saveExp(Expierence exp) async {
    try {
      await _service.saveExp(exp, _token);
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

  Future<void> saveSkills(List<String> skills) async {
    try {
      await _service.saveSkills(skills, _token);
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

  Future<void> saveName() async {
    try {
      await _service.saveName(_state.name, _state.surname, _token);
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

  Future<void> saveGenro() async {
    try {
      await _service.saveGenro(_state.isMale, _token);
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

  Future<void> saveBirthday() async {
    try {
      await _service.saveBirthday(_state.birthday!, _token);
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

  Future<void> saveEmail(String email) async {
    setEmail(email);
    try {
      await _service.saveEmail(_state.email, _token);
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

  Future<void> saveCity(ObjectId city) async {
    setCity(city);
    try {
      await _service.saveCity(_state.city!, _token);
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

  Future<void> saveAbout(String about) async {
    try {
      await _service.saveAbout(about, _token);
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

  void openCityScreen() => Navigator.of(_context).push(
        MaterialPageRoute(
          builder: (context) => CityProfilePage.create(
            _state.city!,
            saveCity,
          ),
        ),
      );

  void openEmailScreen() => Navigator.of(_context).push(
        MaterialPageRoute(
          builder: (context) => EmailProfilePage(
            initValue: _state.email,
            setEmail: saveEmail,
          ),
        ),
      );

  void openAbout() => Navigator.of(_context).push(MaterialPageRoute(
      builder: (context) => AboutPage(
          onSave: saveAbout,
          initAbout: _state.about,
          isVacancy: false,
          isEmployee: true)));

  void openGenroCard() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadiusPage))),
        context: _context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => SizedBox(
              height: 220,
              child: Column(
                children: [
                  const SizedBox(height: defaultPadding),
                  Container(
                    width: 50,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  Text(
                    "Ваш пол",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () => setState(() {
                      _state = _state.copyWith(isMale: true);
                      notifyListeners();
                    }),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Мужской",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          _state.isMale
                              ? SvgPicture.asset("assets/icons/selected.svg")
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () => setState(() {
                      _state = _state.copyWith(isMale: false);
                      notifyListeners();
                    }),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Женский",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          !_state.isMale
                              ? SvgPicture.asset("assets/icons/selected.svg")
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        saveGenro();
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(defaultButtonPadding),
                        child: Text(
                          "Сохранить",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void openBirthdayCard() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadiusPage))),
        context: _context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => SizedBox(
              height: 300,
              child: Column(
                children: [
                  const SizedBox(height: defaultPadding),
                  Container(
                    width: 50,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  Text(
                    "Дата рождения",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const Divider(),
                  SizedBox(
                    child: CupertinoDatePicker(
                        onDateTimeChanged: (DateTime birthday) =>
                            _state = _state.copyWith(birthday: birthday),
                        mode: CupertinoDatePickerMode.date,
                        maximumYear: DateTime.now().year,
                        minimumYear: 1900,
                        initialDateTime: _state.birthday),
                    height: 150,
                  ),
                  const Divider(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        saveBirthday();
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(defaultButtonPadding),
                        child: Text(
                          "Сохранить",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void setName(String name) => _state = _state.copyWith(name: name);

  void setSurname(String surname) => _state = _state.copyWith(surname: surname);

  void setGenro(bool isMale) => _state = _state.copyWith(isMale: isMale);

  void setEmail(String email) => _state = _state.copyWith(email: email);

  void setCity(ObjectId city) => _state = _state.copyWith(city: city);

  Future<void> logout() async {
    await _service.logout();
    Navigator.of(_context).pushNamedAndRemoveUntil(
      NameRoutes.login,
      (route) => false,
    );
  }

  void setPage(bool isFirst) {
    _isFirst = isFirst;
    try {
      notifyListeners();
    } catch (e) {
      _isFirst = isFirst;
    }
  }

  ProfileUserViewModel(this._context) {
    _init();
  }

  Future<void> _init() async {
    _isLoading = true;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = true;
    }
    _token = await _service.getUserToken();
    _userModel = await _service.getUserData(_token);
    _state = _state.copyWith(
      name: _userModel!.firstName,
      surname: _userModel!.surname,
      isMale: _userModel!.isMale,
      birthday: _userModel!.birthday,
      email: _userModel!.email,
      city: _userModel!.region,
      about: _userModel!.about,
    );
    _isLoading = false;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = true;
    }
  }
}
