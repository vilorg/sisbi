// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';

class AboutEmployerPage extends StatefulWidget {
  final Function(String) onSave;
  final String initAbout;
  final bool isVacancy;
  const AboutEmployerPage({
    Key? key,
    required this.onSave,
    required this.initAbout,
    required this.isVacancy,
  }) : super(key: key);

  @override
  State<AboutEmployerPage> createState() => _AboutEmployerPageState();
}

class _AboutEmployerPageState extends State<AboutEmployerPage> {
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    controller.text = widget.initAbout;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isVacancy ? "Описание вакансии" : "Описание организации",
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: colorTextContrast,
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (controller.text.length < 5) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: colorAccentRed,
                    content: Text(
                      "Заполните данные!",
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: colorTextContrast,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                );
                return;
              }
              widget.onSave(controller.text);
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
                top: Radius.circular(borderRadiusPage),
              ),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                padding: const EdgeInsets.all(defaultPadding),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: TextField(
                    maxLines: 15,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                        hintText: widget.isVacancy
                            ? "Описание вакансии"
                            : "Описание организации"),
                    controller: controller,
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
