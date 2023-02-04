import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:libraryWDA/pages/loading/loading_page.dart';
import 'package:libraryWDA/pages/login/login_page.dart';
import 'package:libraryWDA/pages/recover_password/recover_password_page.dart';
import 'package:libraryWDA/pages/book/books_list_page.dart';
import 'package:libraryWDA/pages/recover_password/recover_password_success.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('tokens');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('pt', ''),
      ],
      theme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: companyColors,
      ),
      debugShowCheckedModeBanner: false,
      home: LoadingPage(),
      getPages: [
        GetPage(name: '/', page: () => MainPage('home', "", 0)),
        GetPage(
          name: '/loading',
          page: () => LoadingPage(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(),
          transition: Transition.fade,
          transitionDuration: Duration(milliseconds: 3500),
        ),
        GetPage(
          name: '/recover-password',
          page: () => RecoverPasswordPage(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 300),
        ),
        GetPage(
          name: '/recover-password-success',
          page: () => RecoverPasswordSuccess(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 300),
        ),
      ],
    );
  }
}

const MaterialColor companyColors = MaterialColor(
  0xAA0091FF,
  <int, Color>{
    50: Color.fromRGBO(47, 46, 65, 1),
    100: Color.fromRGBO(255, 255, 255, 1),
    200: Color.fromRGBO(137, 137, 137, 1),
    300: Color.fromRGBO(10, 98, 165, 1),
    400: Color.fromRGBO(0, 191, 166, 1),
    500: Color.fromRGBO(34, 199, 61, 1),
    600: Color.fromRGBO(255, 0, 51, 1),
    700: Color.fromRGBO(255, 101, 132, 1),
    800: Color.fromRGBO(124, 124, 124, 1),
    900: Color.fromRGBO(0, 145, 255, 1),
  },
);
