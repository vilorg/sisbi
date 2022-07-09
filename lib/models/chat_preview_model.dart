// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatPreviewModel {
  final int id;
  final String employerName;
  final String employerAvatar;
  final String lastMessage;
  final DateTime lastMessageSenAt;
  final bool isEmployerLastMessage;
  final bool isSeen;
  final String title;
  final DateTime? seenAt;
  final String userFirstName;
  final String userSurname;
  final String userAvatar;
  ChatPreviewModel({
    required this.id,
    required this.employerName,
    required this.employerAvatar,
    required this.lastMessage,
    required this.lastMessageSenAt,
    required this.isEmployerLastMessage,
    required this.isSeen,
    required this.title,
    this.seenAt,
    required this.userFirstName,
    required this.userSurname,
    required this.userAvatar,
  });

  ChatPreviewModel copyWith({
    int? id,
    String? employerName,
    String? employerAvatar,
    String? lastMessage,
    DateTime? lastMessageSenAt,
    bool? isEmployerLastMessage,
    bool? isSeen,
    String? title,
    DateTime? seenAt,
    String? userFirstName,
    String? userSurname,
    String? userAvatar,
  }) {
    return ChatPreviewModel(
      id: id ?? this.id,
      employerName: employerName ?? this.employerName,
      employerAvatar: employerAvatar ?? this.employerAvatar,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageSenAt: lastMessageSenAt ?? this.lastMessageSenAt,
      isEmployerLastMessage:
          isEmployerLastMessage ?? this.isEmployerLastMessage,
      isSeen: isSeen ?? this.isSeen,
      title: title ?? this.title,
      seenAt: seenAt ?? this.seenAt,
      userFirstName: userFirstName ?? this.userFirstName,
      userSurname: userSurname ?? this.userSurname,
      userAvatar: userAvatar ?? this.userAvatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'employerName': employerName,
      'employerAvatar': employerAvatar,
      'lastMessage': lastMessage,
      'lastMessageSenAt': lastMessageSenAt.millisecondsSinceEpoch,
      'isEmployerLastMessage': isEmployerLastMessage,
      'isSeen': isSeen,
      'title': title,
      'seenAt': seenAt?.millisecondsSinceEpoch,
      'userFirstName': userFirstName,
      'userSurname': userSurname,
      'userAvatar': userAvatar,
    };
  }

  factory ChatPreviewModel.fromMap(Map<String, dynamic> map) {
    final String dateString =
        (map['last_message']['created_at'] as String).substring(0, 10);
    final DateTime dateTime = DateTime.parse(dateString);

    return ChatPreviewModel(
      id: map['id'] as int,
      employerName: map['employer']['name'] as String,
      employerAvatar: map['employer']['avatar'] as String,
      lastMessage: map['last_message']['content'] as String,
      lastMessageSenAt: dateTime,
      isEmployerLastMessage: map['last_message']['sender_type'] != "User",
      isSeen: map['last_message']['seen'] as bool,
      title: map['vacancy']['title'] as String,
      // seenAt: map['seenAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['seenAt'] as int) : null,
      userFirstName: map['user']['first_name'] as String,
      userSurname: map['user']['surname'] as String,
      userAvatar: map['user']['avatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatPreviewModel.fromJson(String source) =>
      ChatPreviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatPreviewModel(id: $id, employerName: $employerName, employerAvatar: $employerAvatar, lastMessage: $lastMessage, lastMessageSenAt: $lastMessageSenAt, isEmployerLastMessage: $isEmployerLastMessage, isSeen: $isSeen, title: $title, seenAt: $seenAt, userFirstName: $userFirstName, userSurname: $userSurname, userAvatar: $userAvatar)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatPreviewModel &&
        other.id == id &&
        other.employerName == employerName &&
        other.employerAvatar == employerAvatar &&
        other.lastMessage == lastMessage &&
        other.lastMessageSenAt == lastMessageSenAt &&
        other.isEmployerLastMessage == isEmployerLastMessage &&
        other.isSeen == isSeen &&
        other.title == title &&
        other.seenAt == seenAt &&
        other.userFirstName == userFirstName &&
        other.userSurname == userSurname &&
        other.userAvatar == userAvatar;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        employerName.hashCode ^
        employerAvatar.hashCode ^
        lastMessage.hashCode ^
        lastMessageSenAt.hashCode ^
        isEmployerLastMessage.hashCode ^
        isSeen.hashCode ^
        title.hashCode ^
        seenAt.hashCode ^
        userFirstName.hashCode ^
        userSurname.hashCode ^
        userAvatar.hashCode;
  }
}
