// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';

class RespondVacancyBottomSheet extends StatefulWidget {
  const RespondVacancyBottomSheet({
    Key? key,
    required this.title,
    required this.salary,
    required this.sendMessage,
  }) : super(key: key);

  final String title;
  final int salary;
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
        height: 350,
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
                "${widget.title}, зарплата от ${widget.salary} руб.",
                style: Theme.of(context).textTheme.bodyText1,
                maxLines: 2,
              ),
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
            const Spacer(),
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
