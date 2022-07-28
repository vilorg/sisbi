// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';

class NameProfileUser extends StatelessWidget {
  final String name;
  final String surname;
  final Function(String) setName;
  final Function(String) setSurname;
  final VoidCallback onSave;
  const NameProfileUser({
    Key? key,
    required this.name,
    required this.surname,
    required this.setName,
    required this.setSurname,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAccentDarkBlue,
      appBar: AppBar(
        title: Text(
          "Имя, фамилия",
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: colorTextContrast,
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                onSave();
                Navigator.pop(context);
              },
              child: Text(
                "Сохранить",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: colorTextContrast,
                    ),
              ))
        ],
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(borderRadiusPage),
        ),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                TextFormField(
                  initialValue: name,
                  cursorColor: colorText,
                  cursorWidth: 1,
                  decoration: const InputDecoration(
                    hintText: "Имя",
                  ),
                  keyboardType: TextInputType.name,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: colorText,
                      ),
                  onChanged: setName,
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  initialValue: surname,
                  cursorColor: colorText,
                  cursorWidth: 1,
                  decoration: const InputDecoration(
                    hintText: "Фамилия",
                  ),
                  keyboardType: TextInputType.name,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: colorText,
                      ),
                  onChanged: setSurname,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
