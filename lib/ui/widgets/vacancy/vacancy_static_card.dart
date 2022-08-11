import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/chat_preview_model.dart';
import 'vacancy_static_header.dart';

class VacancyStaticCard extends StatelessWidget {
  const VacancyStaticCard({
    Key? key,
    required this.chat,
    required this.isUser,
  }) : super(key: key);

  final ChatPreviewModel chat;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    final date = chat.createdAt.substring(0, 10);
    return Scaffold(
      backgroundColor: colorAccentDarkBlue,
      appBar: AppBar(
        title: Text(
          "Просмотр вакансии",
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: colorTextContrast,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      body: ClipRRect(
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(borderRadius)),
        child: ColoredBox(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VacancyStaticHeader(chat: chat, isUser: isUser),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Вакансия опубликована $date',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: colorTextSecondary,
                            ),
                      ),
                      const SizedBox(height: defaultPadding),
                      Text(
                        chat.title,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: defaultPadding / 2),
                      Text(
                        chat.description,
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
