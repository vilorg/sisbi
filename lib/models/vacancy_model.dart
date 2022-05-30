import 'dart:convert';

class VacancyModel {
  final int id;
  final String title;
  final String description;
  final String fullName;
  final String avatar;
  final String phone;
  final String email;
  final String experience;
  final int salary;
  final String createdAt;
  final String jobCategoryName;
  final int jobCategoryId;
  final List<String> schedules;
  final List<String> typeEmployments;
  final int employerId;
  final String employerName;
  final String employerAvatar;
  final String employerPhone;
  final String employerEmail;
  final String employerAbout;
  final int cityId;
  final String cityName;

  VacancyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.fullName,
    required this.avatar,
    required this.phone,
    required this.email,
    required this.experience,
    required this.salary,
    required this.createdAt,
    required this.jobCategoryName,
    required this.jobCategoryId,
    required this.schedules,
    required this.typeEmployments,
    required this.employerId,
    required this.employerName,
    required this.employerAvatar,
    required this.employerPhone,
    required this.employerEmail,
    required this.employerAbout,
    required this.cityId,
    required this.cityName,
  });

  VacancyModel copyWith({
    int? id,
    String? title,
    String? description,
    String? fullName,
    String? avatar,
    String? phone,
    String? email,
    String? experience,
    int? salary,
    String? createdAt,
    String? jobCategoryName,
    int? jobCategoryId,
    List<String>? schedules,
    List<String>? typeEmployments,
    int? employerId,
    String? employerName,
    String? employerAvatar,
    String? employerPhone,
    String? employerEmail,
    String? employerAbout,
    int? cityId,
    String? cityName,
  }) {
    return VacancyModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      fullName: fullName ?? this.fullName,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      experience: experience ?? this.experience,
      salary: salary ?? this.salary,
      createdAt: createdAt ?? this.createdAt,
      jobCategoryName: jobCategoryName ?? this.jobCategoryName,
      jobCategoryId: jobCategoryId ?? this.jobCategoryId,
      schedules: schedules ?? this.schedules,
      typeEmployments: typeEmployments ?? this.typeEmployments,
      employerId: employerId ?? this.employerId,
      employerName: employerName ?? this.employerName,
      employerAvatar: employerAvatar ?? this.employerAvatar,
      employerPhone: employerPhone ?? this.employerPhone,
      employerEmail: employerEmail ?? this.employerEmail,
      employerAbout: employerAbout ?? this.employerAbout,
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'fullName': fullName,
      'avatar': avatar,
      'phone': phone,
      'email': email,
      'experience': experience,
      'salary': salary,
      'createdAt': createdAt,
      'jobCategoryName': jobCategoryName,
      'jobCategoryId': jobCategoryId,
      'schedules': schedules,
      'typeEmployments': typeEmployments,
      'employerId': employerId,
      'employerName': employerName,
      'employerAvatar': employerAvatar,
      'employerPhone': employerPhone,
      'employerEmail': employerEmail,
      'employerAbout': employerAbout,
      'cityId': cityId,
      'cityName': cityName,
    };
  }

  factory VacancyModel.fromMap(Map<String, dynamic> json) {
    List<String> schedules = [];
    for (var i in json['schedules']) {
      schedules.add(i['name'] as String);
      //hellojhbk hbh
    }

    List<String> typeEmployments = [];
    for (var i in json['type_employments']) {
      typeEmployments.add(i['name'] as String);
    }

    return VacancyModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      fullName: json['full_name'] as String,
      avatar: json['avatar'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      experience: json['experience'] as String,
      salary: json['salary'] as int,
      createdAt: json['created_at'] as String,
      jobCategoryName: json['job_category']['name'] as String,
      jobCategoryId: json['job_category']['id'] as int,
      schedules: schedules,
      typeEmployments: typeEmployments,
      employerId: json['employer']['id'] as int,
      employerName: json['employer']['name'] as String,
      employerAvatar: json['employer']['avatar'] as String,
      employerPhone: json['employer']['phone'] as String,
      employerEmail: json['employer']['email'] as String,
      employerAbout: json['employer']['about'] as String,
      cityId: json['city']['id'] as int,
      cityName: json['city']['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VacancyModel.fromJson(String source) =>
      VacancyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VacancyModel(id: $id, title: $title, description: $description, fullName: $fullName, avatar: $avatar, phone: $phone, email: $email, experience: $experience, salary: $salary, createdAt: $createdAt, jobCategoryName: $jobCategoryName, jobCategoryId: $jobCategoryId, schedules: $schedules, typeEmployments: $typeEmployments, employerId: $employerId, employerName: $employerName, employerAvatar: $employerAvatar, employerPhone: $employerPhone, employerEmail: $employerEmail, employerAbout: $employerAbout, cityId: $cityId, cityName: $cityName)';
  }
}
