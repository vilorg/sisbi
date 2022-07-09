// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:intl/intl.dart';

class MessageModel {
  final String content;
  final bool isUser;
  final bool isSeen;
  final DateTime createdAt;
  MessageModel({
    required this.content,
    required this.isUser,
    required this.isSeen,
    required this.createdAt,
  });

  MessageModel copyWith({
    String? content,
    bool? isUser,
    bool? isSeen,
    DateTime? createdAt,
  }) {
    return MessageModel(
      content: content ?? this.content,
      isUser: isUser ?? this.isUser,
      isSeen: isSeen ?? this.isSeen,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'isUser': isUser,
      'isSeen': isSeen,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      content: map['content'] as String,
      isUser: (map['sender_type'] as String) == "User",
      isSeen: map['seen'] as bool,
      createdAt: DateFormat('yyyy-MM-ddTHH:mm:ss')
          .parse((map['created_at'] as String).substring(0, 19)),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(content: $content, isUser: $isUser, isSeen: $isSeen, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.content == content &&
        other.isUser == isUser &&
        other.isSeen == isSeen &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return content.hashCode ^
        isUser.hashCode ^
        isSeen.hashCode ^
        createdAt.hashCode;
  }
}
