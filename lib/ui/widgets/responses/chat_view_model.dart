import 'package:flutter/material.dart';
import 'package:sisbi/domain/services/chat_service.dart';
import 'package:sisbi/models/chat_preview_model.dart';

class ChatViewModel extends ChangeNotifier {
  final bool isEmployer;
  ChatViewModel(this.isEmployer) {
    _init();
  }

  late String _token;
  final ChatService _service = ChatService();

  List<ChatPreviewModel> _chatList = [];
  List<ChatPreviewModel> get chatList => _chatList;
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  // set chatId(int s) => _chatId = s;

  Future<void> _init() async {
    _token = await _service.getUserToken();
    _chatList = await _service.getAllChats(isEmployer, _token);
    _isLoading = false;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
  }

  Future<void> reloadChats() async {
    try {
      _isLoading = true;
      notifyListeners();
      _chatList = await _service.getAllChats(isEmployer, _token);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
  }
}
