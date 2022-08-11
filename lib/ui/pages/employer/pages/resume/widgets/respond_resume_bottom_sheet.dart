// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/user_data_model.dart';

class RespondResumeBottomSheet extends StatefulWidget {
  const RespondResumeBottomSheet({
    Key? key,
    required this.resume,
    required this.sendMessage,
  }) : super(key: key);

  final UserDataModel resume;
  final Function(BuildContext, String) sendMessage;

  @override
  State<RespondResumeBottomSheet> createState() =>
      _RespondResumeBottomSheetState();
}

class _RespondResumeBottomSheetState extends State<RespondResumeBottomSheet> {
  bool sendContacts = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 445.5,
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
                "${widget.resume.post}, зарплата от ${widget.resume.coast} руб.",
                style: Theme.of(context).textTheme.bodyText1,
                maxLines: 2,
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
