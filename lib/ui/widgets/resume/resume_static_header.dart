// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/chat_preview_model.dart';

class ResumeStaticHeader extends StatelessWidget {
  const ResumeStaticHeader({
    Key? key,
    required this.chat,
    required this.isUser,
  }) : super(key: key);

  final ChatPreviewModel chat;
  final bool isUser;

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
          Image.network(
            chat.employerAvatar,
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
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(300),
                        child: Image.network(
                          chat.employerAvatar,
                          width: 25,
                        ),
                      ),
                      const SizedBox(width: defaultPadding / 2),
                      Text(
                        chat.employerName,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: colorTextContrast,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    chat.title,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: colorTextContrast,
                        ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    "От ${chat.salary} руб.",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: colorTextContrast,
                        ),
                  ),
                  // const SizedBox(height: defaultPadding),
                  // WrapVacancyCards(
                  //   vacancy: vacancy,
                  //   userData: userData,
                  // ),
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
