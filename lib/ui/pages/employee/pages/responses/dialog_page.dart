// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/chat_service.dart';
import 'package:sisbi/models/message_model.dart';
import 'package:sisbi/ui/pages/employee/pages/responses/widgets/message.dart';

class _ViewModel extends ChangeNotifier {
  final BuildContext context;
  final int chatId;
  final bool isUser;
  final VoidCallback onClose;
  final BuildContext _context;
  _ViewModel(
      this.context, this.chatId, this.isUser, this.onClose, this._context) {
    _init();
  }

  final ChatService _service = ChatService();
  IOWebSocketChannel? channel;

  List<MessageModel> _messages = [];
  List<MessageModel> get messages => _messages;
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  final TextEditingController _textController = TextEditingController();
  TextEditingController get controller => _textController;
  bool isOnline = false;
  String? _token;
  int _page = 1;
  bool _endPage = false;
  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;
  final ScrollController scrollController = ScrollController();

  Future<void> _init() async {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMoreMessage();
      }
    });
    _token = await _service.getUserToken();
    channel = IOWebSocketChannel.connect(
        Uri.parse('wss://api.sisbi.ru/cable?token=$_token'));
    var sink = jsonEncode({
      "command": "subscribe",
      "identifier": jsonEncode(
        {"channel": "ChatChannel", "chat_id": "$chatId"},
      ),
    });
    _messages = await _service.getMessages(_token!, chatId, _page);
    _page += 1;
    _isLoading = false;
    notifyListeners();
    channel!.sink.add(sink);
    channel!.stream.listen((event) {
      Map<String, dynamic> a = jsonDecode(event);
      if (a.keys.contains('identifier') && a.keys.contains('message')) {
        if (a['message'].keys.contains("message")) {
          isOnline = a['message']['online'] as bool;
          if (isOnline) {
            for (int i = 0; i < _messages.length; i++) {
              _messages[i] = _messages[i].copyWith(isSeen: true);
            }
          }
        } else {
          _messages.insert(
              0,
              MessageModel(
                content: a['message']['content'],
                isUser: a['message']['sender_type'] == "User",
                isSeen: isOnline,
                createdAt: DateFormat('yyyy-MM-ddTHH:mm:ss').parse(
                    (a['message']['created_at'] as String).substring(0, 19)),
              ));
        }
        notifyListeners();
      }
    });
  }

  Future<void> loadMoreMessage() async {
    if (_endPage) return;
    _isLoadingMore = true;
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colorTextContrast,
        content: Text(
          "Загрузка новых сообщений...",
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: colorAccentDarkBlue,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
    List<MessageModel> _loadedMessage =
        await _service.getMessages(_token!, chatId, _page);
    if (_loadedMessage.isEmpty) {
      _endPage = true;
      _isLoadingMore = false;
      notifyListeners();
      return;
    }
    _page += 1;
    _messages.addAll(_loadedMessage);
    _isLoadingMore = false;
    notifyListeners();
  }

  Future<bool> closeDialog() async {
    try {
      channel!.sink.close();
    } catch (e) {
      _messages = [];
    }
    onClose();
    Navigator.of(context).pop();
    return true;
  }

  void sendMessage(String message) async {
    if (_textController.text == "") return;
    await _service.sendMessage(_token!, chatId, message);
    _textController.text = "";
    notifyListeners();
  }

  void showActions() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadiusPage))),
        context: context,
        builder: (context) => Container());
  }
}

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

  static Widget create(int chatId, bool isUser, VoidCallback onClose,
          String parthnerName, String title, Duration timeDifference) =>
      ChangeNotifierProvider(
        create: (context) =>
            _ViewModel(context, chatId, isUser, onClose, context),
        child: DialogPage(
            parthnerName: parthnerName,
            title: title,
            timeDifference: timeDifference),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_ViewModel>(context);
    final List<MessageModel> messages = List.from(model.messages.reversed);
    final bool isLoading = model.isLoading;
    final bool isLoadingMore = model.isLoadingMore;
    final bool isUser = model.isUser;
    final TextEditingController textController = model.controller;
    final ScrollController scrollController = model.scrollController;
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
                  child: TextField(
                    controller: textController,
                    onSubmitted: model.sendMessage,
                    maxLines: 1,
                    cursorColor: colorAccentDarkBlue,
                    decoration: const InputDecoration(
                      hintText: " Сообщение",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: defaultPadding),
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
