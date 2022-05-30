// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/vacancy_model.dart';

class RespondVacancyBottomSheet extends StatefulWidget {
  const RespondVacancyBottomSheet({
    Key? key,
    required this.vacancy,
    required this.sendMessage,
  }) : super(key: key);

  final VacancyModel vacancy;
  final Function(BuildContext, String) sendMessage;

  @override
  State<RespondVacancyBottomSheet> createState() =>
      _RespondVacancyBottomSheetState();
}

class _RespondVacancyBottomSheetState extends State<RespondVacancyBottomSheet> {
  bool sendContacts = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 430,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: defaultPadding),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Вы откликаетесь как:",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${widget.vacancy.title}, зарплата от ${widget.vacancy.salary} руб.",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            const Divider(),
            const SizedBox(height: defaultPadding / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 5,
                  child: Text(
                    "Предоставить контакты работодателю",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Flexible(
                  child: CupertinoSwitch(
                    activeColor: colorAccentLightBlue,
                    value: sendContacts,
                    onChanged: (v) {
                      sendContacts = v;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding / 2),
            const Divider(),
            const SizedBox(height: defaultPadding / 2),
            TextField(
              controller: _controller,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: const InputDecoration(
                hintText: "Ваше сопроводительно письмо",
              ),
              minLines: 6,
              maxLines: 6,
            ),
            const SizedBox(height: defaultPadding),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => widget.sendMessage(context, _controller.text),
                child: Padding(
                  padding: const EdgeInsets.all(defaultButtonPadding),
                  child: Text(
                    "Откликнуться",
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: colorTextContrast,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
