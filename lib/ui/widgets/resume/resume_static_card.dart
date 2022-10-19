// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/enum_classes.dart';
import 'package:sisbi/models/object_id.dart';

import 'resume_static_header.dart';

class ResumeStaticCard extends StatelessWidget {
  const ResumeStaticCard({
    Key? key,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.avatar,
    required this.salary,
    required this.name,
    required this.expierence,
    required this.region,
    required this.phone,
    required this.email,
    required this.sendMessage,
    required this.isChat,
    required this.vacancies,
  }) : super(key: key);

  final String createdAt;
  final String title;
  final String description;
  final String avatar;
  final int salary;
  final String name;
  final Expierence expierence;
  final ObjectId region;
  final String phone;
  final String email;
  final Function(BuildContext, String, int) sendMessage;
  final bool isChat;
  final List<ObjectId> vacancies;

  @override
  Widget build(BuildContext context) {
    final date = createdAt.substring(0, 10);
    return Scaffold(
      backgroundColor: colorAccentDarkBlue,
      appBar: AppBar(
        
        title: Text(
          "Просмотр резюме",
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
                ResumeStaticHeader(
                  avatar: avatar,
                  name: name,
                  salary: salary,
                  title: title,
                  expierence: expierence,
                  region: region,
                  email: email,
                  phone: phone,
                  sendMessage: sendMessage,
                  isChat: isChat,
                  vacancies: vacancies,
                ),
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
                        "Описание резюме",
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: defaultPadding / 2),
                      Text(
                        description,
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
