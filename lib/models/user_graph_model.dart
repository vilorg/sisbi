class UserGraphModel {
  final String experience;
  final List<String> schedules;
  final String? city;
  UserGraphModel({
    required this.experience,
    required this.schedules,
    required this.city,
  });

  UserGraphModel copyWith({
    String? experience,
    List<String>? schedules,
    String? city,
  }) {
    return UserGraphModel(
      experience: experience ?? this.experience,
      schedules: schedules ?? this.schedules,
      city: city ?? this.city,
    );
  }

  @override
  String toString() =>
      'UserGraphModel(experience: $experience, schedules: $schedules, city: $city)';
}
