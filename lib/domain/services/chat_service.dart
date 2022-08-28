import 'package:sisbi/domain/data_providers/chat_data_provider.dart';
import 'package:sisbi/domain/data_providers/session_data_provider.dart';
import 'package:sisbi/models/chat_preview_model.dart';
import 'package:sisbi/models/message_model.dart';

class ChatService {
  final SessionDataProvider _sessionProvider = SessionDataProvider();
  final ChatDataProvider _mediaProvider = ChatDataProvider();

  Future<String> getUserToken() async {
    return await _sessionProvider.getToken();
  }

  Future<List<ChatPreviewModel>> getAllChats(
      bool isEmployer, String token) async {
    return await _mediaProvider.getAllChats(isEmployer, token);
  }

  Future<List<MessageModel>> getMessages(
      String token, bool isEmployer, int chatId, int page) async {
    return await _mediaProvider.getAllMessages(token, isEmployer, chatId, page);
  }

  Future<bool> sendMessage(
      String token, bool isEmployer, int chatId, String message) async {
    return await _mediaProvider.sendMessage(token, isEmployer, chatId, message);
  }

  Future<void> actionUser(bool isAccept, int resumeId, String token) async =>
      await _mediaProvider.actionUser(isAccept, resumeId, token);

  Future<void> deleteChat(int chatId, bool isUser, String token) async =>
      await _mediaProvider.deleteChat(chatId, isUser, token);
}
