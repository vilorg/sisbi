// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/chat_preview_model.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        color: Colors.white,
        child: Column(
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
                  "Просмотрено вчера",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: colorAccentDarkBlue,
                      ),
                )
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
      ),
    );
  }
}
