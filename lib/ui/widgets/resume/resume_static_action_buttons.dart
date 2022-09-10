// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sisbi/constants.dart';

import 'package:sisbi/models/object_id.dart';
import 'package:sisbi/ui/pages/employer/pages/resume/widgets/respond_resume_bottom_sheet.dart';

class ResumeStaticActionButtons extends StatelessWidget {
  final String title;
  final int salary;
  final Function(BuildContext, String, int) sendMessage;
  final List<ObjectId> vacancies;
  final bool isChat;

  const ResumeStaticActionButtons({
    Key? key,
    required this.title,
    required this.salary,
    required this.sendMessage,
    required this.vacancies,
    required this.isChat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        GestureDetector(
          onTap: vacancies.isNotEmpty
              ? () => showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(borderRadiusPage))),
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => RespondResumeBottomSheet(
                        sendMessage: sendMessage,
                        vacancies: vacancies,
                      ))
              : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: colorAccentRed,
                      content: Text(
                        "У вас нет действующий вакансий!",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: colorTextContrast,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  );
                },
          child: SvgPicture.asset(
            "assets/icons/action_message.svg",
          ),
        ),
      ]),
    );
  }
}
