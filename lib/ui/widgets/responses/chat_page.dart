import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/models/chat_preview_model.dart';
import 'package:sisbi/ui/inherited_widgets/home_inherited_widget.dart';
import 'package:sisbi/ui/widgets/responses/chat_preview.dart';

import 'chat_view_model.dart';
import 'dialog_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  static Widget create(bool isEmployer) => ChangeNotifierProvider(
        create: (context) => ChatViewModel(isEmployer),
        child: const ChatPage(),
      );

  @override
  Widget build(BuildContext context) {
    List<Widget> data = [];

    final model = Provider.of<ChatViewModel>(context);
    final List<ChatPreviewModel> chatList = model.chatList;
    final bool isLoading = model.isLoading;

    final bool isUser = !HomeInheritedWidget.of(context)!.isEmployer;

    for (ChatPreviewModel chat in chatList) {
      data.add(
        ChatPreview(
          model: chat,
          isUser: isUser,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => DialogPage.create(
                  chat,
                  isUser,
                  model.reloadChats,
                  HomeInheritedWidget.of(context)!.timeDifference,
                ),
              ),
            );
          },
        ),
      );
      data.add(const Divider());
    }

    if (data.isEmpty) {
      data.add(Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Text(
          "У вас нет откликов...",
          style: Theme.of(context).textTheme.headline6,
        ),
      ));
    }

    return Scaffold(
      backgroundColor: colorAccentDarkBlue,
      appBar: AppBar(
        title: Text(
          "Сообщения",
          style: Theme.of(context).textTheme.headline3!.copyWith(
                color: colorTextContrast,
              ),
        ),
        // actions: [
        // IconButton(
        //   onPressed: () {},
        //   icon: SvgPicture.asset("assets/icons/notification.svg"),
        // ),
        // ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const HeaderResponsesEmployee(),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(borderRadiusPage)),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: !isLoading
                    ? SingleChildScrollView(
                        child: Column(
                          children: data,
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: colorAccentDarkBlue,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
