// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/message_model.dart';

class Message extends StatelessWidget {
  final bool isUser;
  final MessageModel message;
  final Duration timeDifference;
  const Message({
    Key? key,
    required this.isUser,
    required this.message,
    required this.timeDifference,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _isSelf = isUser == message.isUser;
    const Radius _radius = Radius.circular(defaultPadding);

    return Align(
      alignment: _isSelf ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
        child: Column(
          crossAxisAlignment:
              _isSelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: _radius,
                  topRight: _radius,
                  bottomLeft: _isSelf ? _radius : Radius.zero,
                  bottomRight: _isSelf ? Radius.zero : _radius,
                ),
                color: _isSelf
                    ? const Color.fromRGBO(46, 100, 248, 1)
                    : colorAccentGreen,
              ),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75 -
                      2 * defaultPadding),
              padding: const EdgeInsets.all(defaultPadding),
              child: Text(
                message.content,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: _isSelf ? colorTextContrast : colorText,
                    ),
              ),
            ),
            const SizedBox(height: defaultPadding / 8),
            Row(
              mainAxisAlignment:
                  _isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                _isSelf
                    ? SvgPicture.asset(message.isSeen
                        ? "assets/icons/seen.svg"
                        : "assets/icons/delivered.svg")
                    : const SizedBox(),
                const SizedBox(height: defaultPadding / 8),
                Text(
                  DateFormat('HH:mm')
                      .format(message.createdAt.add(timeDifference)),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
