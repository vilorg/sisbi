import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sisbi/constants.dart';
import 'package:sisbi/models/chat_preview_model.dart';
import 'package:sisbi/models/message_model.dart';

class ChatMediaDataProvider {
  Future<List<ChatPreviewModel>> getAllChats(String token) async {
    Uri uri = Uri.parse(getAllChatsUri);
    var response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode != 200) throw Exception;

    List<dynamic> decoded = jsonDecode(response.body)['payload'];

    List<ChatPreviewModel> data = [];

    for (Map<String, dynamic> chat in decoded) {
      data.add(ChatPreviewModel.fromMap(chat));
    }
    return data;
  }

  Future<List<MessageModel>> getAllMessages(
      String token, int chatId, int page) async {
    Uri uri = Uri.parse("$getMessagesUri/$chatId/?page=$page");
    var response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode != 200) throw Exception;

    List<dynamic> decoded = jsonDecode(response.body)['payload'];

    List<MessageModel> data = [];

    for (Map<String, dynamic> chat in decoded) {
      data.add(MessageModel.fromMap(chat));
    }
    return data;
  }

  Future<bool> sendMessage(String token, int chatId, String message) async {
    Uri uri = Uri.parse(getMessagesUri);
    var body = jsonEncode({
      'message': {
        'content': message,
        'chat_id': chatId,
        'type_message': 1,
      },
    });

    var response = await http.post(
      uri,
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) return false;
    var decoded = jsonDecode(response.body);
    if (decoded["result_code"] != "ok") return false;
    return true;
  }
}
