import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/models/user_data_model.dart';
import 'package:sisbi/ui/pages/employee/pages/profile/profile_view_model.dart';
import 'package:sisbi/ui/widgets/select_wrap_card.dart';
import 'package:intl/intl.dart';

import 'name_profile_user.dart';

class PersonalDataUser extends StatelessWidget {
  const PersonalDataUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProfileViewModel>(context);
    final UserDataModel? user = model.userModel;
    final bool isLoading = model.isLoading;

    Widget avatar = Image.asset(
      "assets/images/avatar.png",
      width: 132,
      height: 132,
      fit: BoxFit.cover,
    );

    if (!isLoading) {
      if (user!.avatar != "") {
        avatar = Image.network(user.avatar,
            width: 132, height: 132, fit: BoxFit.cover);
      }
    }

    var nameCard = isLoading
        ? const SizedBox()
        : SelectWrapCard(
            title: "Имя, фамилия",
            value: user!.firstName != ""
                ? "${user.firstName} ${user.surname}"
                : null,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NameProfileUser(
                  name: user.firstName,
                  surname: user.surname,
                  setName: model.setName,
                  setSurname: model.setSurname,
                  onSave: model.saveName,
                ),
              ),
            ),
          );

    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(borderRadiusPage),
        ),
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child:
                        GestureDetector(onTap: model.pickAvatar, child: avatar),
                  ),
                ),
                nameCard,
                SelectWrapCard(
                  title: "Пол",
                  value: user!.isMale ? "Мужской" : "Женский",
                  onTap: model.openGenroCard,
                ),
                SelectWrapCard(
                  title: "Дата рождения",
                  value: DateTime.now().difference(user.birthday) <
                          const Duration(days: 365)
                      ? null
                      : DateFormat('dd.MM.yyyy').format(user.birthday),
                  onTap: model.openBirthdayCard,
                ),
                SelectWrapCard(
                  title: "Город проживания",
                  value: user.region.value != "" ? user.region.value : null,
                  onTap: model.openCityScreen,
                ),
                SelectWrapCard(
                  title: "Номер телефона",
                  value: user.phone,
                  onTap: null,
                ),
                SelectWrapCard(
                  title: "Email-адрес",
                  value: user.email != "" ? user.email : null,
                  onTap: model.openEmailScreen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
