// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/chat_preview_model.dart';
import 'package:sisbi/ui/pages/employee/pages/responses/widgets/contacts_message.dart';
import 'package:sisbi/ui/widgets/vacancy_static_card.dart';

class ActionsMessage extends StatelessWidget {
  final ChatPreviewModel chat;
  final bool isUser;
  const ActionsMessage({
    Key? key,
    required this.chat,
    required this.isUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: Column(
        children: [
          const SizedBox(height: defaultPadding),
          Container(
            width: 50,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          const Divider(),
          _Tile(
              title: "Перейти в вакансию",
              asset: "assets/icons/arrow_forward.svg",
              isTrash: false,
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        VacancyStaticCard(chat: chat, isUser: isUser),
                  ))),
          const Divider(),
          _Tile(
              title: "Посмотреть контакты",
              asset: "assets/icons/arrow_forward.svg",
              isTrash: false,
              onTap: () => showContactsDialog(context)),
          const Divider(),
          _Tile(
              title: "Удалить чат",
              asset: "assets/icons/trash.svg",
              isTrash: true,
              onTap: () => showDeleteDialog(context)),
          const Divider(),
        ],
      ),
    );
  }

  Future<dynamic> showContactsDialog(BuildContext context) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(borderRadiusPage))),
      context: context,
      builder: (context) => ContactssMessage(chat: chat, isUser: isUser),
    );
  }

  Future<dynamic> showDeleteDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.all(defaultPadding),
        actionsPadding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding / 2),
        titlePadding: const EdgeInsets.all(defaultPadding),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusPage)),
        title: Text(
          "Удалить чат?",
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        content: Text(
          "Работодатель больше не сможет вам писать, все материалы будут удалены",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          TextButton(
              child: Text(
                "Отмена",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: colorLink,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          TextButton(
              child: Text(
                "Удалить",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: colorAccentRed,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    Key? key,
    required this.title,
    required this.asset,
    required this.isTrash,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String asset;
  final bool isTrash;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: isTrash ? colorAccentRed : colorText),
            ),
            SvgPicture.asset(asset),
          ],
        ),
      ),
    );
  }
}
