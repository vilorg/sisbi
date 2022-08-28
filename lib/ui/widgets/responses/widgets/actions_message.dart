// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/chat_preview_model.dart';
import 'package:sisbi/ui/widgets/vacancy/vacancy_static_card.dart';

import 'contacts_message.dart';

class ActionsMessage extends StatelessWidget {
  final ChatPreviewModel chat;
  final bool isUser;
  final VoidCallback onDelete;
  const ActionsMessage({
    Key? key,
    required this.chat,
    required this.isUser,
    required this.onDelete,
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
              title: isUser ? "Перейти в вакансию" : "Перейти в резюме",
              asset: "assets/icons/arrow_forward.svg",
              isTrash: false,
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VacancyStaticCard(
                      avatar: chat.avatar,
                      employerAvatar: chat.employerAvatar,
                      createdAt: chat.createdAt,
                      description: chat.description,
                      name: chat.employerName,
                      salary: chat.salary,
                      title: chat.title,
                    ),
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
      builder: (context) => ContactsMessage(chat: chat, isUser: isUser),
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
          "${isUser ? "Работадатель" : "Соискатель"} больше не сможет вам писать, все материалы будут удалены",
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
                onDelete();
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
