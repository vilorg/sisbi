// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/ui/pages/employee/pages/vacancy/widgets/respond_vacancy_bottom_sheet.dart';
import 'package:sisbi/ui/widgets/show_contacts.dart';

class VacancyStaticActionButtons extends StatelessWidget {
  final String title;
  final int salary;
  final Function(BuildContext, String) sendMessage;
  final String name;
  final String phone;
  final String email;
  final bool isChat;
  final VoidCallback removeFavourite;
  const VacancyStaticActionButtons({
    Key? key,
    required this.title,
    required this.salary,
    required this.sendMessage,
    required this.name,
    required this.phone,
    required this.email,
    required this.isChat,
    required this.removeFavourite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: !isChat
            ? [
                GestureDetector(
                  onTap: () {
                    removeFavourite();
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(
                    "assets/icons/action_favourite_sel.svg",
                  ),
                ),
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(borderRadiusPage))),
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => RespondVacancyBottomSheet(
                            title: title,
                            salary: salary,
                            sendMessage: sendMessage,
                          )),
                  child: SvgPicture.asset(
                    "assets/icons/action_message.svg",
                  ),
                ),
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(borderRadiusPage))),
                      context: context,
                      builder: (context) =>
                          ShowContacts(email: email, name: name, phone: phone)),
                  child: SvgPicture.asset(
                    "assets/icons/action_call.svg",
                  ),
                ),
              ]
            : [
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(borderRadiusPage))),
                      context: context,
                      builder: (context) =>
                          ShowContacts(email: email, name: name, phone: phone)),
                  child: SvgPicture.asset(
                    "assets/icons/action_call.svg",
                  ),
                ),
              ],
      ),
    );
  }
}
