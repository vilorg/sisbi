// ignore_for_file: constant_identifier_names

enum Expierence { no, y_1_3, y_3_6, more_6, notChosed }

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
    case Expierence.y_3_6:
      ans = "3 - 6 лет";
      break;
    case Expierence.more_6:
      ans = "Более 6 лет";
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

enum DrivingLicence { A, B, C, D, E, BE, CE, DE, TM, DB }
