import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/profile_service.dart';
import 'package:sisbi/models/user_data_model.dart';
import 'package:sisbi/ui/pages/employee/pages/profile/widgets/phone_profile_user.dart';

class _ViewModelState {
  final String name;
  final String surname;
  final bool isMale;
  final DateTime? birthday;

  _ViewModelState(
      {this.name = "", this.surname = "", this.isMale = true, this.birthday});

  _ViewModelState copyWith({
    String? name,
    String? surname,
    bool? isMale,
    DateTime? birthday,
  }) {
    return _ViewModelState(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      isMale: isMale ?? this.isMale,
      birthday: birthday ?? this.birthday,
    );
  }
}

class ProfileViewModel extends ChangeNotifier {
  final BuildContext _context;
  final ProfileService _service = ProfileService();

  String _token = "";

  _ViewModelState _state = _ViewModelState();
  _ViewModelState get state => _state;

  UserDataModel? _userModel;
  UserDataModel? get userModel => _userModel;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> pickAvatar() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    try {
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

  void openPhoneScreen() => Navigator.of(_context)
      .push(MaterialPageRoute(builder: (context) => PhoneProfileUser.create()));

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
                        maximumYear: 2010,
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

  Future<void> logout() async {
    await _service.logout();
    Navigator.of(_context).pushNamedAndRemoveUntil(
      NameRoutes.login,
      (route) => false,
    );
  }

  ProfileViewModel(this._context) {
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
        isMale: _userModel!.isMale, birthday: _userModel!.birthday);
    _isLoading = false;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = true;
    }
  }
}
