// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/enum_classes.dart';
import 'package:sisbi/models/object_id.dart';
import 'package:sisbi/ui/widgets/vacancy/vacancy_static_action_buttons.dart';
import 'package:sisbi/ui/widgets/wrap_static_cards.dart';

class VacancyStaticHeader extends StatelessWidget {
  const VacancyStaticHeader({
    Key? key,
    required this.employerAvatar,
    required this.avatar,
    required this.name,
    required this.title,
    required this.salary,
    required this.expierence,
    required this.email,
    required this.phone,
    required this.sendMessage,
    required this.isChat,
    required this.removeFavourite,
  }) : super(key: key);

  final String employerAvatar;
  final String avatar;
  final String name;
  final String title;
  final int salary;
  final Expierence expierence;
  final String email;
  final String phone;
  final Function(BuildContext, String) sendMessage;
  final bool isChat;
  final VoidCallback removeFavourite;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.vertical -
          60,
      decoration: const BoxDecoration(
        color: colorAccentDarkBlue,
      ),
      child: Stack(
        children: [
          avatar != ""
              ? Image.network(
                  avatar,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.vertical -
                      // VacancyInheritedWidget.of(context)!.appBarHeight -
                      60,
                  alignment: Alignment.center,
                )
              : Image.asset(
                  "assets/images/сard_preview1.jpeg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.vertical -
                      // VacancyInheritedWidget.of(context)!.appBarHeight -
                      60,
                  alignment: Alignment.center,
                ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(defaultPadding),
                        child: employerAvatar != ""
                            ? Image.network(
                                employerAvatar,
                                width: 24,
                                alignment: Alignment.center,
                              )
                            : Image.asset(
                                "assets/images/logo.png",
                                width: 24,
                                alignment: Alignment.center,
                              ),
                      ),
                      const SizedBox(width: defaultPadding / 2),
                      Text(
                        name,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: colorTextContrast,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: colorTextContrast,
                        ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    "От $salary руб.",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: colorTextContrast,
                        ),
                  ),
                  const SizedBox(height: defaultPadding),
                  WrapStaticCards(
                    expierence: expierence,
                    region: const ObjectId(0, ""),
                  ),
                  const SizedBox(height: defaultPadding),
                  VacancyStaticActionButtons(
                    title: title,
                    salary: salary,
                    sendMessage: sendMessage,
                    name: name,
                    phone: phone,
                    email: email,
                    isChat: isChat,
                    removeFavourite: removeFavourite,
                  ),
                  const SizedBox(height: 2 * defaultPadding),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
