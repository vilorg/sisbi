// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/chat_preview_model.dart';
import 'package:sisbi/models/message_model.dart';
import 'package:sisbi/ui/widgets/responses/widgets/message.dart';

import 'dialog_view_model.dart';

class DialogPage extends StatelessWidget {
  final String parthnerName;
  final String title;
  final Duration timeDifference;
  const DialogPage({
    Key? key,
    required this.parthnerName,
    required this.title,
    required this.timeDifference,
  }) : super(key: key);

  static Widget create(ChatPreviewModel chat, bool isUser, VoidCallback onClose,
      Duration timeDifference) {
    String parthnerName = isUser
        ? chat.employerName
        : "${chat.userFirstName} ${chat.userSurname}";
    return ChangeNotifierProvider(
      create: (context) => DialogViewModel(context, chat, isUser, onClose),
      child: DialogPage(
          parthnerName: parthnerName,
          title: chat.title,
          timeDifference: timeDifference),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<DialogViewModel>(context);
    final List<MessageModel> messages = List.from(model.messages.reversed);
    final bool isLoading = model.isLoading;
    final bool isLoadingMore = model.isLoadingMore;
    final bool isUser = model.isUser;
    final TextEditingController textController = model.controller;
    final ScrollController scrollController = model.scrollController;
    final ChatPreviewModel chat = model.chat;
    DateTime lastData = DateTime.parse("0001-01-01");

    List<Widget> data = [];

    for (MessageModel message in messages) {
      if (!(lastData.month == message.createdAt.month &&
          lastData.day == message.createdAt.day &&
          lastData.year == message.createdAt.year)) {
        data.add(
          Padding(
            padding: const EdgeInsets.all(defaultPadding / 2),
            child: Center(
              child: Text(
                "${message.createdAt.day} ${getRusMonthString(message.createdAt)} ${message.createdAt.year}",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: colorTextSecondary,
                    ),
              ),
            ),
          ),
        );
      }
      data.add(Message(
          isUser: isUser, message: message, timeDifference: timeDifference));
      lastData = message.createdAt;
    }

    data = List.from(data.reversed);
    isLoadingMore
        ? data.add(
            Padding(
              padding: const EdgeInsets.all(defaultPadding * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          color: colorAccentDarkBlue)),
                ],
              ),
            ),
          )
        : null;

    return WillPopScope(
      onWillPop: model.closeDialog,
      child: Scaffold(
        backgroundColor: colorAccentDarkBlue,
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: colorTextContrast,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(
                parthnerName,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: colorTextContrast,
                    ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: model.showActions,
              icon: const Icon(Icons.more_vert),
            ),
          ],
          backgroundColor: colorAccentDarkBlue,
        ),
        body: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(
              borderRadiusPage,
            ),
          ),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: !isLoading
                      ? ListView(
                          physics: const BouncingScrollPhysics(),
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          children: data,
                          reverse: true,
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: colorAccentDarkBlue,
                          ),
                        ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(26, 26, 26, 0.02),
                        blurRadius: 15,
                        offset: Offset(0, -1),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(defaultPadding / 2),
                  child: !isUser && chat.responseState == ResponseState.created
                      ? Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: model.accept,
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      defaultButtonPadding / 2),
                                  child: Text(
                                    "Пригласить на работу",
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: defaultPadding / 2),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: model.decline,
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      defaultButtonPadding / 2),
                                  child: Text(
                                    "Отказать",
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                                style: Theme.of(context)
                                    .elevatedButtonTheme
                                    .style!
                                    .copyWith(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              colorAccentRed),
                                    ),
                              ),
                            ),
                          ],
                        )
                      : TextField(
                          controller: textController,
                          onSubmitted: model.sendMessage,
                          maxLines: 1,
                          cursorColor: colorAccentDarkBlue,
                          decoration: const InputDecoration(
                            hintText: " Сообщение",
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: defaultPadding),
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            fillColor: Colors.white,
                          ),
                          style: Theme.of(context).textTheme.bodyText1,
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
