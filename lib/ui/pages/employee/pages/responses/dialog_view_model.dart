import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/chat_service.dart';
import 'package:sisbi/models/message_model.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';

import 'widgets/actions_message.dart';

class DialogViewModel extends ChangeNotifier {
  final BuildContext context;
  final int chatId;
  final bool isUser;
  final VoidCallback onClose;
  final BuildContext _context;
  DialogViewModel(
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
        {"channel": "ChatChannel", "chat_id": "$chatId"},
      ),
    });
    _messages = await _service.getMessages(_token!, chatId, _page);
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
    Navigator.of(context).pop();
    return true;
  }

  void sendMessage(String message) async {
    if (_textController.text == "") return;
    await _service.sendMessage(_token!, chatId, message);
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
      context: context,
      builder: (context) => const SizedBox(),
      // ActionsMessage(vacancy: ,)
    );
  }
}
