import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// name routes
class NameRoutes {
  static String homeEmployee = "/home_employee";
  static String homeEmployer = "/home_employer";
  static String login = "/login";
  static String loader = "/loader";
}

// colors
// accent colors
const Color colorAccentBlack = Color(0xFF283244);
const Color colorAccentDarkBlue = Color(0xFF575FCC);
const Color colorAccentLightBlue = Color(0xFF739EF1);
const Color colorAccentGold = Color(0xFFFABF48);
const Color colorAccentSoftGold = Color(0xFFFEF2DA);
const Color colorAccentRed = Color(0xFFFF6D3B);
const Color colorAccentGreen = Color(0xFF8FD8B5);

// text colors
const Color colorText = Color(0xFF283244);
const Color colorTextContrast = Color(0xFFFFFFFF);
const Color colorTextSecondary = Color(0xFF74767A);
const Color colorLink = Color(0xFF575FCC);

// icon colos
const Color colorIcon = Color(0xFF283244);
const Color colorIconContrast = Color(0xFFFFFFFF);
const Color colorIconSecondary = Color(0xFF919399);
const Color colorIconAccent = Color(0xFFFF6D3B);

// controls colors
const Color colorButton = Color(0xFF283244);
const Color colorButtonDisable = Color(0xFFA0A2A8);
const Color colorButtonSecondary = Color(0xFFECEDF0);
const Color colorInput = Color(0xFFF3F3F5);
const Color colorInputContent = Color(0xFF74767A);
const Color colorInputActive = Color(0xFF739EF1);
const Color colorInputError = Color(0xFFFF6D3B);

// divider & border colors
const Color colorBorder = Color(0xFFE0E1E6);
const Color colorDivider = Color(0xFFECEDF0);

// padding and radius
const double defaultPadding = 15.0;
const double defaultButtonPadding = 20.0;
const double borderRadius = 16.0;
const double borderRadiusPage = 24.0;

// mask Fomatter
final TextInputFormatter phoneMask = MaskTextInputFormatter(
  mask: '+7 │ ###-###-##-##',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

// uris
const String baseUri = "https://api.sisbi.ru/v1/";
const String getUserUri = baseUri + "user";
const String getEmployerUri = baseUri + "employer/profile";
const String getEmployerVacanciesUri = baseUri + "employer/vacancies";
const String getSmsUserUri = baseUri + "users_sms";
const String getSmsEmployerUri = baseUri + "employer/employers_sms";
const String getUserTokenUri = baseUri + "auth/user_token";
const String getEmployerTokenUri = baseUri + "auth/employer_token";
const String getAddSchedulesUri = baseUri + "user/add_schedules";
const String getRemoveSchedulesUri = baseUri + "user/remove_schedules";
const String setSchedulesUri = baseUri + "user/add_schedules";
const String getAddTypeEmploymentsUri = baseUri + "user/add_type_employments";
const String getRemoveTypeEmploymentsUri =
    baseUri + "user/remove_type_employments";
const String getVacancyUri = baseUri + "vacancies";
const String getResumeUri = baseUri + "employer/users";
const String getFavouriteVacancyUri = baseUri + "favorite_vacancies";
const String getFavouriteResumeUri = baseUri + "employer/favorite_users";
const String getRespondVacancyUri = baseUri + "responses";
const String getActionUserResponseUri = baseUri + "employer/responses";
const String getRespondResumeUri = baseUri + "employer/invites";
const String getCitiesUri = baseUri + "cities?page=1";
const String getJobCategoriesUri = baseUri + "job_categories";
const String getAllChatsEmployeeUri = baseUri + "chats";
const String getAllChatsEmployerUri = baseUri + "employer/chats";
const String getMessagesEmployeeUri = baseUri + "messages";
const String getMessagesEmployerUri = baseUri + "employer/messages";
const String getDeleteDialogEmployerUri = baseUri + "employer/chats";
const String getDeleteDialogEmployeeUri = baseUri + "chats";
const String getCityUri = baseUri + "cities?page=1";
const String getNameVacancyUri = baseUri + "name_vacancies?page=1";

String getRusMonthString(DateTime date) {
  String ans = "";
  int month = date.month;
  switch (month) {
    case 1:
      ans = "января";
      break;
    case 2:
      ans = "февраля";
      break;
    case 3:
      ans = "марта";
      break;
    case 4:
      ans = "апреля";
      break;
    case 5:
      ans = "мая";
      break;
    case 6:
      ans = "июня";
      break;
    case 7:
      ans = "июля";
      break;
    case 8:
      ans = "августа";
      break;
    case 9:
      ans = "сентября";
      break;
    case 10:
      ans = "октября";
      break;
    case 11:
      ans = "ноября";
      break;
    case 12:
      ans = "декабря";
      break;
  }
  return ans;
}
