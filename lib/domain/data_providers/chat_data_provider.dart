import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sisbi/constants.dart';
import 'package:sisbi/models/chat_preview_model.dart';
import 'package:sisbi/models/message_model.dart';

class ChatDataProvider {
  Future<List<ChatPreviewModel>> getAllChats(
      bool isEmployer, String token) async {
    Uri uri =
        Uri.parse(isEmployer ? getAllChatsEmployerUri : getAllChatsEmployeeUri);
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
      String token, bool isEmployer, int chatId, int page) async {
    Uri uri = Uri.parse(
        "${isEmployer ? getMessagesEmployerUri : getMessagesEmployeeUri}/$chatId/?page=$page");
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

  Future<bool> sendMessage(
      String token, bool isEmployer, int chatId, String message) async {
    Uri uri =
        Uri.parse(isEmployer ? getMessagesEmployerUri : getMessagesEmployeeUri);
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

  Future<void> actionUser(bool isAccept, int resumeId, String token) async {
    Uri uri = Uri.parse(getActionUserResponseUri +
        "/$resumeId/${isAccept ? "accept" : "decline"}");
    final response = await http.put(uri, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode != 200) throw Exception();
  }

  Future<void> deleteChat(int chatId, bool isUser, String token) async {
    Uri uri = Uri.parse(
        (isUser ? getDeleteDialogEmployeeUri : getDeleteDialogEmployerUri) +
            "/$chatId");
    final response = await http.delete(uri, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode != 200) throw Exception();
  }
}
