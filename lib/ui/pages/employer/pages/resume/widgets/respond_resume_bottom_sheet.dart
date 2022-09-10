// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/object_id.dart';

class RespondResumeBottomSheet extends StatefulWidget {
  const RespondResumeBottomSheet({
    Key? key,
    required this.sendMessage,
    required this.vacancies,
  }) : super(key: key);

  final Function(BuildContext, String, int) sendMessage;
  final List<ObjectId> vacancies;

  @override
  State<RespondResumeBottomSheet> createState() =>
      _RespondResumeBottomSheetState();
}

class _RespondResumeBottomSheetState extends State<RespondResumeBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  late ObjectId selectedVacancy;

  @override
  void initState() {
    try {
      selectedVacancy = widget.vacancies[0];
    } catch (e) {
      selectedVacancy = const ObjectId(0, "");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 400,
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
            ListTile(
              title: Text(
                "Вакансия",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: colorTextSecondary,
                    ),
              ),
              subtitle: Text(
                selectedVacancy.value,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
              onTap: () => showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(borderRadiusPage))),
                context: context,
                isScrollControlled: true,
                builder: (context) => _SelectVacancy(
                  setVacancy: (ObjectId vacancy) =>
                      setState(() => selectedVacancy = vacancy),
                  vacancies: widget.vacancies,
                  selectedVacancy: selectedVacancy,
                ),
              ),
            ),
            // const SizedBox(height: defaultPadding),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Text(
            //     "Вы откликаетесь как:",
            //     style: Theme.of(context).textTheme.subtitle1!.copyWith(
            //           fontWeight: FontWeight.bold,
            //         ),
            //   ),
            // ),
            // const SizedBox(height: defaultPadding / 2),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Text(
            //     "${widget.resume.post}, зарплата от ${widget.resume.coast} руб.",
            //     style: Theme.of(context).textTheme.bodyText1,
            //     maxLines: 2,
            //   ),
            // ),
            // const SizedBox(height: defaultPadding / 2),
            // const Divider(),
            // const SizedBox(height: defaultPadding / 2),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Flexible(
            //       flex: 5,
            //       child: Text(
            //         "Предоставить контакты работодателю",
            //         style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //               fontWeight: FontWeight.w600,
            //             ),
            //       ),
            //     ),
            //     Flexible(
            //       child: CupertinoSwitch(
            //         activeColor: colorAccentLightBlue,
            //         value: sendContacts,
            //         onChanged: (v) {
            //           sendContacts = v;
            //           setState(() {});
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: defaultPadding / 2),
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
                onPressed: () => widget.sendMessage(
                    context, _controller.text, selectedVacancy.id),
                child: Padding(
                  padding: const EdgeInsets.all(defaultButtonPadding),
                  child: Text(
                    "Отправить приглашение",
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

class _SelectVacancy extends StatefulWidget {
  const _SelectVacancy({
    Key? key,
    required this.setVacancy,
    required this.vacancies,
    required this.selectedVacancy,
  }) : super(key: key);

  final Function(ObjectId) setVacancy;
  final List<ObjectId> vacancies;
  final ObjectId selectedVacancy;

  @override
  State<_SelectVacancy> createState() => __SelectVacancyState();
}

class __SelectVacancyState extends State<_SelectVacancy> {
  late ObjectId selectedVacancy;

  @override
  void initState() {
    selectedVacancy = widget.selectedVacancy;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> data = [];

    for (ObjectId vacancy in widget.vacancies) {
      data.add(
        RadioListTile<ObjectId>(
          title: Text(
            vacancy.value,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          value: vacancy,
          groupValue: selectedVacancy,
          onChanged: (ObjectId? v) => setState(() => selectedVacancy = v!),
        ),
      );
    }

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 400,
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: data,
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.setVacancy(selectedVacancy);
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(defaultButtonPadding),
                  child: Text(
                    "Выбрать",
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
