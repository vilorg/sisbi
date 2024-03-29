import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/chat_service.dart';
import 'package:sisbi/models/chat_preview_model.dart';
import 'package:sisbi/models/message_model.dart';
import 'package:intl/intl.dart';
import 'package:sisbi/models/object_id.dart';
import 'package:web_socket_channel/io.dart';

import 'widgets/actions_message.dart';

class DialogViewModel extends ChangeNotifier {
  final BuildContext _context;
  ChatPreviewModel chat;
  final bool isUser;
  final VoidCallback onClose;
  DialogViewModel(this._context, this.chat, this.isUser, this.onClose) {
    _chatId = chat.chatId;
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
  int _chatId = 0;
  final ScrollController scrollController = ScrollController();
  List<ObjectId> vacancies = [];

  Future<void> _init() async {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 30) {
        loadMoreMessage();
      }
    });
    _token = await _service.getUserToken();
    channel = IOWebSocketChannel.connect(
        Uri.parse('wss://api.sisbi.ru/cable?token=$_token'));
    var sink = jsonEncode({
      "command": "subscribe",
      "identifier": jsonEncode(
        {"channel": "ChatChannel", "chat_id": "$_chatId"},
      ),
    });
    _messages = await _service.getMessages(_token!, !isUser, _chatId, _page);
    _page += 1;
    _isLoading = false;
    try {
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
                  isReponse: a['message']['response'] == "response",
                ));
          }
          notifyListeners();
        }
      });
    } catch (e) {
      _isLoading = false;
    }
  }

  Future<void> loadMoreMessage() async {
    if (_endPage || _isLoadingMore) return;
    _isLoadingMore = true;
    notifyListeners();
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        backgroundColor: colorTextContrast,
        content: Text(
          "Загрузка новых сообщений...",
          style: Theme.of(_context).textTheme.subtitle2!.copyWith(
                color: colorAccentDarkBlue,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
    List<MessageModel> _loadedMessage =
        await _service.getMessages(_token!, !isUser, _chatId, _page);
    if (_loadedMessage.isEmpty) {
      _endPage = true;
      _isLoadingMore = false;
      try {
        notifyListeners();
      } catch (e) {
        _isLoading = false;
      }
      return;
    }
    _page += 1;
    _messages.addAll(_loadedMessage);
    _isLoadingMore = false;
    try {
      notifyListeners();
    } catch (e) {
      _isLoadingMore = false;
    }
  }

  Future<bool> closeDialog() async {
    try {
      channel!.sink.close();
    } catch (e) {
      _messages = [];
    }
    onClose();
    Navigator.of(_context).pop();
    return true;
  }

  void sendMessage(String message) async {
    if (_textController.text == "") return;
    await _service.sendMessage(_token!, !isUser, _chatId, message);
    _textController.text = "";
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.bounceInOut);
    notifyListeners();
  }

  void showActions() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(borderRadiusPage))),
      context: _context,
      builder: (context) => ActionsMessage(
        chat: chat,
        isUser: isUser,
        onDelete: _deleteChat,
      ),
      // ActionsMessage(vacancy: ,)
    );
  }

  Future<void> _deleteChat() async {
    try {
      await _service.deleteChat(chat.chatId, isUser, _token!);
      onClose();
      Navigator.of(_context).pop();
      Navigator.of(_context).pop();
    } catch (e) {
      Navigator.of(_context).pop();
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentRed,
          content: Text(
            "Ошибка загрузки",
            style: Theme.of(_context).textTheme.subtitle2!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
    }
  }

  Future<void> accept() async {
    try {
      await _service.actionUser(true, chat.responseId, _token!);

      chat = chat.copyWith(responseState: ResponseState.accepted);
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentGreen,
          content: Text(
            "Успех!",
            style: Theme.of(_context).textTheme.subtitle2!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentRed,
          content: Text(
            "Ошибка загрузки",
            style: Theme.of(_context).textTheme.subtitle2!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
    }
  }

  Future<void> decline() async {
    try {
      await _service.actionUser(false, chat.responseId, _token!);

      chat = chat.copyWith(responseState: ResponseState.declined);
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentGreen,
          content: Text(
            "Успех!",
            style: Theme.of(_context).textTheme.subtitle2!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          backgroundColor: colorAccentRed,
          content: Text(
            "Ошибка загрузки",
            style: Theme.of(_context).textTheme.subtitle2!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
    }
  }
}
