// ignore_for_file: constant_identifier_names

import 'package:sisbi/models/object_id.dart';

enum Expierence { notChosed, no, y_1_3, y_2_6, more_6 }

String getExpierenceString(Expierence expierence) {
  String ans = "";
  switch (expierence) {
    case Expierence.notChosed:
      ans = "Не выбрано";
      break;
    case Expierence.no:
      ans = "Нет опыта";
      break;
    case Expierence.y_1_3:
      ans = "1 - 3 года";
      break;
    case Expierence.y_2_6:
      ans = "3 - 6 лет";
      break;
    case Expierence.more_6:
      ans = "Более 6 лет";
      break;
  }
  return ans;
}

int? getIntFromExpierence(Expierence expierence) {
  int? ans = 0;
  switch (expierence) {
    case Expierence.notChosed:
      ans = null;
      break;
    case Expierence.no:
      ans = 0;
      break;
    case Expierence.y_1_3:
      ans = 1;
      break;
    case Expierence.y_2_6:
      ans = 2;
      break;
    case Expierence.more_6:
      ans = 3;
      break;
  }
  return ans;
}

Expierence getExpierenceFromInt(int? exp) {
  Expierence ans = Expierence.notChosed;
  switch (exp) {
    case null:
      ans = Expierence.notChosed;
      break;
    case -1:
      ans = Expierence.notChosed;
      break;
    case 0:
      ans = Expierence.no;
      break;
    case 1:
      ans = Expierence.y_1_3;
      break;
    case 2:
      ans = Expierence.y_2_6;
      break;
    case 3:
      ans = Expierence.more_6;
      break;
  }
  return ans;
}

enum Education {
  secondary_special,
  secondary,
  incomplete_higher,
  higher,
  bachelor,
  master,
  candidate,
  doctor
}

String getEducationString(Education education) {
  String ans = "";
  switch (education) {
    case Education.secondary_special:
      ans = "Среднее образование";
      break;
    case Education.secondary:
      ans = "Среднее профессиональное образование";
      break;
    case Education.incomplete_higher:
      ans = "Неоконченное высшее образование";
      break;
    case Education.higher:
      ans = "Высшее образование";
      break;
    case Education.bachelor:
      ans = "Бакалавр";
      break;
    case Education.master:
      ans = "Магистр";
      break;
    case Education.candidate:
      ans = "Кандидат наук";
      break;
    case Education.doctor:
      ans = "Доктор наук";
      break;
  }
  return ans;
}

int? getIntFromEducation(Education education) {
  int? ans = 0;
  switch (education) {
    case Education.secondary:
      ans = 0;
      break;
    case Education.secondary_special:
      ans = 1;
      break;
    case Education.incomplete_higher:
      ans = 2;
      break;
    case Education.higher:
      ans = 3;
      break;
    case Education.bachelor:
      ans = 4;
      break;
    case Education.master:
      ans = 5;
      break;
    case Education.candidate:
      ans = 6;
      break;
    case Education.doctor:
      ans = 7;
      break;
  }
  return ans;
}

Education getEducationFromInt(int? edu) {
  Education ans = Education.secondary;
  switch (edu) {
    case 0:
      ans = Education.secondary;
      break;
    case 1:
      ans = Education.secondary_special;
      break;
    case 2:
      ans = Education.incomplete_higher;
      break;
    case 3:
      ans = Education.higher;
      break;
    case 4:
      ans = Education.bachelor;
      break;
    case 5:
      ans = Education.master;
      break;
    case 6:
      ans = Education.candidate;
      break;
    case 7:
      ans = Education.doctor;
      break;
  }
  return ans;
}

enum DrivingLicence { A, B, C, D, E, BE, CE, DE, TM, DB }

List<ObjectId> getTypeEmploymentsString() => const [
      ObjectId(4, 'Полная занятость'),
      ObjectId(3, 'Частичная занятость'),
      ObjectId(2, 'Проектная работа'),
      ObjectId(1, 'Стажировка'),
    ];

ObjectId getTypeEmploymentFromInt(int i) {
  ObjectId ans = const ObjectId(0, "");
  switch (i) {
    case 0:
      ans = const ObjectId(4, 'Полная занятость');
      break;
    case 1:
      ans = const ObjectId(3, 'Частичная занятость');
      break;
    case 2:
      ans = const ObjectId(2, 'Проектная работа');
      break;
    case 3:
      ans = const ObjectId(1, 'Стажировка');
      break;
  }
  return ans;
}

List<ObjectId> getSchedulesString() => const [
      ObjectId(4, 'Удаленная работа'),
      ObjectId(3, 'Полный день'),
      ObjectId(2, 'Гибкий график'),
      ObjectId(1, 'Сменный график'),
    ];

ObjectId getSchedulesFromInt(int i) {
  ObjectId ans = const ObjectId(0, "");
  switch (i) {
    case 0:
      ans = const ObjectId(4, 'Удаленная работа');
      break;
    case 1:
      ans = const ObjectId(3, 'Полный день');
      break;
    case 2:
      ans = const ObjectId(2, 'Гибкий график');
      break;
    case 3:
      ans = const ObjectId(1, 'Сменный график');
      break;
  }
  return ans;
}

//TODO: пофиксить y_2_6 а не y_3_6