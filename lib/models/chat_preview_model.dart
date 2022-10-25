// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

import 'package:sisbi/models/enum_classes.dart';

import 'object_id.dart';

enum ResponseState { created, accepted, declined, no }

class ChatPreviewModel {
  final int chatId;
  final int vacancyId;
  final String employerName;
  final String employerAvatar;
  final String employerPhone;
  final String employerEmail;
  final String lastMessage;
  final DateTime lastMessageSenAt;
  final bool isEmployerLastMessage;
  final bool isSeen;
  final String title;
  final String description;
  final String createdAt;
  final int salary;
  final DateTime? seenAt;
  final String userFirstName;
  final String userSurname;
  final String userAvatar;
  final String userPhone;
  final String userEmail;
  final Expierence userExpierence;
  final ObjectId region;
  final String userAbout;

  final String avatar;
  final ResponseState responseState;
  final bool isInvite;
  final int responseId;
  final Expierence vacancyExpierence;

  ChatPreviewModel({
    required this.chatId,
    required this.vacancyId,
    required this.employerName,
    required this.employerAvatar,
    required this.employerPhone,
    required this.employerEmail,
    required this.lastMessage,
    required this.lastMessageSenAt,
    required this.isEmployerLastMessage,
    required this.isSeen,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.salary,
    this.seenAt,
    required this.userFirstName,
    required this.userSurname,
    required this.userAvatar,
    required this.userPhone,
    required this.userEmail,
    required this.userExpierence,
    required this.region,
    required this.userAbout,
    required this.avatar,
    required this.responseState,
    required this.isInvite,
    required this.responseId,
    required this.vacancyExpierence,
  });

  ChatPreviewModel copyWith({
    int? chatId,
    int? vacancyId,
    String? employerName,
    String? employerAvatar,
    String? employerPhone,
    String? employerEmail,
    String? lastMessage,
    DateTime? lastMessageSenAt,
    bool? isEmployerLastMessage,
    bool? isSeen,
    String? title,
    String? description,
    String? createdAt,
    int? salary,
    DateTime? seenAt,
    String? userFirstName,
    String? userSurname,
    String? userAvatar,
    String? userPhone,
    String? userEmail,
    Expierence? userExpierence,
    ObjectId? region,
    String? userAbout,
    String? avatar,
    ResponseState? responseState,
    bool? isInvite,
    int? responseId,
    Expierence? vacancyExpierence,
  }) {
    return ChatPreviewModel(
      chatId: chatId ?? this.chatId,
      vacancyId: vacancyId ?? this.vacancyId,
      employerName: employerName ?? this.employerName,
      employerAvatar: employerAvatar ?? this.employerAvatar,
      employerPhone: employerPhone ?? this.employerPhone,
      employerEmail: employerEmail ?? this.employerEmail,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageSenAt: lastMessageSenAt ?? this.lastMessageSenAt,
      isEmployerLastMessage:
          isEmployerLastMessage ?? this.isEmployerLastMessage,
      isSeen: isSeen ?? this.isSeen,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      salary: salary ?? this.salary,
      seenAt: seenAt ?? this.seenAt,
      userFirstName: userFirstName ?? this.userFirstName,
      userSurname: userSurname ?? this.userSurname,
      userAvatar: userAvatar ?? this.userAvatar,
      userPhone: userPhone ?? this.userPhone,
      userEmail: userEmail ?? this.userEmail,
      userExpierence: userExpierence ?? this.userExpierence,
      region: region ?? this.region,
      userAbout: userAbout ?? this.userAbout,
      avatar: avatar ?? this.avatar,
      responseState: responseState ?? this.responseState,
      isInvite: isInvite ?? this.isInvite,
      responseId: responseId ?? this.responseId,
      vacancyExpierence: vacancyExpierence ?? this.vacancyExpierence,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': chatId,
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

    String? seenAtString = map['last_message']['seen_at'];
    DateTime? seenAt;
    if (seenAtString != null) {
      seenAtString = seenAtString.substring(0, 19);
      seenAt = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(seenAtString);
    }

    // String createdAtString = map['vacancy']['created_at'] as String;
    // DateTime createdAt;
    // createdAtString = createdAtString.substring(0, 19);
    // createdAt = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(createdAtString);

    bool isInvite = map['last_response'] == null;
    ObjectId city = const ObjectId(0, "");
    if (map['city'] != null) {
      city = ObjectId(map['city']['id'] as int, map['city']['name'] as String);
    }

    return ChatPreviewModel(
      chatId: map['id'] as int,
      vacancyId: map['vacancy']['id'] as int,
      employerName: map['employer']['name'] as String,
      employerAvatar: map['employer']['avatar'] as String,
      employerEmail: map['employer']['email'] ?? "",
      employerPhone: map['employer']['phone'] as String,
      lastMessage: map['last_message']['content'] as String,
      lastMessageSenAt: dateTime,
      isEmployerLastMessage: map['last_message']['sender_type'] != "User",
      isSeen: map['last_message']['seen'] as bool,
      title: map['vacancy']['title'] as String,
      description: map['vacancy']['description'] as String,
      createdAt: map['vacancy']['created_at'] as String,
      salary: map['vacancy']['salary'] as int,
      seenAt: seenAt,
      userFirstName: map['user']['first_name'] as String,
      userSurname: map['user']['surname'] as String,
      userAvatar: map['user']['avatar'] as String,
      userPhone: map['user']['phone'] as String,
      userEmail: map['user']['email'] as String? ?? "",
      userExpierence: Expierence.values.firstWhere((element) =>
          element.toString() ==
          "Expierence." +
              (map['user']["experience"] as String? ?? "notChosed")),
      avatar: map['vacancy']['avatar'] as String,
      responseState: !isInvite
          ? ResponseState.values.firstWhere(
              (element) =>
                  element.toString() ==
                  "ResponseState." + map['last_response']['state'],
            )
          : ResponseState.no,
      isInvite: isInvite,
      responseId: !isInvite ? map['last_response']['id'] as int : 0,
      region: city,
      vacancyExpierence: Expierence.values.firstWhere((element) =>
          element.toString() ==
          "Expierence." +
              (map['vacancy']["experience"] as String? ?? "notChosed")),
      userAbout: map['user']['about'] as String? ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatPreviewModel.fromJson(String source) =>
      ChatPreviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatPreviewModel(chatId: $chatId, vacancyId: $vacancyId, employerName: $employerName, employerAvatar: $employerAvatar, employerPhone: $employerPhone, employerEmail: $employerEmail, lastMessage: $lastMessage, lastMessageSenAt: $lastMessageSenAt, isEmployerLastMessage: $isEmployerLastMessage, isSeen: $isSeen, title: $title, description: $description, createdAt: $createdAt, salary: $salary, seenAt: $seenAt, userFirstName: $userFirstName, userSurname: $userSurname, userAvatar: $userAvatar, userPhone: $userPhone, userEmail: $userEmail, userExpierence: $userExpierence, region: $region, avatar: $avatar, responseState: $responseState, isInvite: $isInvite, responseId: $responseId, vacancyExpierence: $vacancyExpierence)';
  }

  @override
  bool operator ==(covariant ChatPreviewModel other) {
    if (identical(this, other)) return true;

    return other.chatId == chatId &&
        other.vacancyId == vacancyId &&
        other.employerName == employerName &&
        other.employerAvatar == employerAvatar &&
        other.employerPhone == employerPhone &&
        other.employerEmail == employerEmail &&
        other.lastMessage == lastMessage &&
        other.lastMessageSenAt == lastMessageSenAt &&
        other.isEmployerLastMessage == isEmployerLastMessage &&
        other.isSeen == isSeen &&
        other.title == title &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.salary == salary &&
        other.seenAt == seenAt &&
        other.userFirstName == userFirstName &&
        other.userSurname == userSurname &&
        other.userAvatar == userAvatar &&
        other.userPhone == userPhone &&
        other.userEmail == userEmail &&
        other.userExpierence == userExpierence &&
        other.region == region &&
        other.avatar == avatar &&
        other.responseState == responseState &&
        other.isInvite == isInvite &&
        other.responseId == responseId &&
        other.vacancyExpierence == vacancyExpierence;
  }

  @override
  int get hashCode {
    return chatId.hashCode ^
        vacancyId.hashCode ^
        employerName.hashCode ^
        employerAvatar.hashCode ^
        employerPhone.hashCode ^
        employerEmail.hashCode ^
        lastMessage.hashCode ^
        lastMessageSenAt.hashCode ^
        isEmployerLastMessage.hashCode ^
        isSeen.hashCode ^
        title.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        salary.hashCode ^
        seenAt.hashCode ^
        userFirstName.hashCode ^
        userSurname.hashCode ^
        userAvatar.hashCode ^
        userPhone.hashCode ^
        userEmail.hashCode ^
        userExpierence.hashCode ^
        region.hashCode ^
        avatar.hashCode ^
        responseState.hashCode ^
        isInvite.hashCode ^
        responseId.hashCode ^
        vacancyExpierence.hashCode;
  }
}
