// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EmployerDataModel {
  final String name;
  final String avatar;
  final String phone;
  final String email;
  final String about;
  EmployerDataModel({
    required this.name,
    required this.avatar,
    required this.phone,
    required this.email,
    required this.about,
  });

  EmployerDataModel copyWith({
    String? name,
    String? avatar,
    String? phone,
    String? email,
    String? about,
  }) {
    return EmployerDataModel(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      about: about ?? this.about,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'avatar': avatar,
      'phone': phone,
      'email': email,
      'about': about,
    };
  }

  factory EmployerDataModel.fromMap(Map<String, dynamic> map) {
    return EmployerDataModel(
      name: map['name'] as String,
      avatar: map['avatar'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String? ?? "",
      about: map['about'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployerDataModel.fromJson(String source) =>
      EmployerDataModel.fromMap(
          json.decode(source)['payload'] as Map<String, dynamic>);

  @override
  String toString() {
    return 'EmployerDataModel(name: $name, avatar: $avatar, phone: $phone, email: $email, about: $about)';
  }

  @override
  bool operator ==(covariant EmployerDataModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.avatar == avatar &&
        other.phone == phone &&
        other.email == email &&
        other.about == about;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        avatar.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        about.hashCode;
  }
}
