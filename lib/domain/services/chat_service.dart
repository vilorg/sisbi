import 'package:sisbi/domain/data_providers/chat_media_data_provider.dart';
import 'package:sisbi/domain/data_providers/session_data_provider.dart';
import 'package:sisbi/models/chat_preview_model.dart';
import 'package:sisbi/models/message_model.dart';

class ChatService {
  final SessionDataProvider _sessionProvider = SessionDataProvider();
  final ChatMediaDataProvider _mediaProvider = ChatMediaDataProvider();

  Future<String> getUserToken() async {
    return await _sessionProvider.getUserToken();
  }

  Future<List<ChatPreviewModel>> getAllChats(String token) async {
    return await _mediaProvider.getAllChats(token);
  }

  Future<List<MessageModel>> getMessages(
      String token, int chatId, int page) async {
    return await _mediaProvider.getAllMessages(token, chatId, page);
  }

  Future<bool> sendMessage(String token, int chatId, String message) async {
    return await _mediaProvider.sendMessage(token, chatId, message);
  }
}
