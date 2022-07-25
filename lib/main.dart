import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/ui/pages/employee/home_employee_page.dart';
import 'package:sisbi/ui/pages/employer/home_employer_page.dart';
import 'package:sisbi/ui/pages/loader_page.dart';
import 'package:sisbi/ui/pages/login/login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(0),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ru', 'RU')],
        debugShowCheckedModeBanner: false,
        title: 'SISBI',
        theme: ThemeData(
          primaryColor: colorAccentDarkBlue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            color: colorAccentDarkBlue,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              // onSurface: colorButton,
              primary: colorButton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  borderRadius,
                ),
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
          ),
          fontFamily: "ProximaNova",
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: colorText,
            ),
            headline2: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: colorText,
            ),
            headline3: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: colorText,
            ),
            subtitle1: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: colorText,
            ),
            subtitle2: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: colorText,
            ),
            bodyText1: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: colorText,
            ),
            bodyText2: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: colorText,
            ),
            button: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: colorTextContrast,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(defaultPadding)),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius))),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            focusColor: colorAccentLightBlue,
            filled: true,
            fillColor: colorInput,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: colorAccentLightBlue,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: colorInputError,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: colorInputError,
                width: 1.5,
              ),
            ),
          ),
          dividerColor: colorDivider,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: colorAccentRed,
            unselectedItemColor: colorIconSecondary,
            selectedLabelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
            unselectedLabelStyle:
                Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
          ),
        ),
        builder: (context, child) =>
            ScrollConfiguration(behavior: MyBehavior(), child: child!),
        routes: {
          NameRoutes.loader: (context) => LoaderPage.create(),
          NameRoutes.login: (context) => LoginPage.create(),
          NameRoutes.homeEmployee: (context) => HomeEmployeePage.create(),
          NameRoutes.homeEmployer: (context) => HomeEmployerPage.create(),
        },
        initialRoute: NameRoutes.loader,
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
