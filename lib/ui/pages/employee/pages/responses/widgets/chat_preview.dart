// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/chat_preview_model.dart';
import 'package:sisbi/ui/inherited_widgets/home_inherited_widget.dart';

enum StatusMessage { seen, deliveried, other }

class ChatPreview extends StatelessWidget {
  final ChatPreviewModel model;
  final bool isUser;
  final VoidCallback onTap;

  const ChatPreview({
    Key? key,
    required this.model,
    required this.isUser,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StatusMessage status = StatusMessage.deliveried;
    DateTime now = DateTime.now();
    DateTime yesterday = now.add(const Duration(minutes: -24));
    DateTime dateTime = model.isSeen
        ? model.seenAt!
        : model.lastMessageSenAt
            .add(HomeInheritedWidget.of(context)!.timeDifference);
    String dateTimeText = "";
    if (isUser != model.isEmployerLastMessage) {
      if (dateTime.year == now.year &&
          dateTime.month == now.month &&
          dateTime.day == now.day) {
        dateTimeText = "сегодня";
      } else if (dateTime.year == yesterday.year &&
          dateTime.month == yesterday.month &&
          dateTime.day == yesterday.day) {
        dateTimeText = "вчера";
      } else if (dateTime.year == now.year) {
        dateTimeText =
            "${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}";
      } else {
        dateTimeText =
            "${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year.toString().padLeft(2, '0')}";
      }
    } else if (dateTime.year == now.year) {
      dateTimeText =
          "${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}";
    } else {
      dateTimeText =
          "${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year.toString().padLeft(2, '0')}";
    }
    String statusText = "";
    if (isUser != model.isEmployerLastMessage) {
      if (model.isSeen) {
        statusText = "Просмотрено $dateTimeText";
        status = StatusMessage.seen;
      } else {
        statusText = "Доставлено $dateTimeText";
        status = StatusMessage.deliveried;
      }
    } else {
      statusText = dateTimeText;
      status = StatusMessage.other;
    }

    Widget signStatus = status == StatusMessage.seen
        ? SvgPicture.asset("assets/icons/seen.svg")
        : status == StatusMessage.deliveried
            ? SvgPicture.asset("assets/icons/delivered.svg")
            : const SizedBox();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        color: Colors.white,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(defaultPadding),
                        child: Image.network(
                            isUser ? model.employerAvatar : model.userAvatar),
                      ),
                    ),
                    const SizedBox(width: defaultPadding),
                    Text(
                      isUser
                          ? model.employerName
                          : "${model.userFirstName} ${model.userSurname}",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: colorLink,
                          ),
                    ),
                    const Spacer(),
                    Text(
                      statusText,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: colorAccentDarkBlue,
                          ),
                    ),
                    const SizedBox(width: defaultPadding / 8),
                    signStatus,
                  ],
                ),
                const SizedBox(height: defaultPadding),
                Text(
                  model.title,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: defaultPadding),
                Text(
                  (isUser != model.isEmployerLastMessage ? "Вы: " : "") +
                      model.lastMessage,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: colorTextSecondary,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
