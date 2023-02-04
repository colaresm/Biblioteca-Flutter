import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:libraryWDA/pages/widgets/app_bar.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:libraryWDA/controllers/patient_controller.dart';
import 'package:libraryWDA/utils/routes.dart';

void main() => runApp(MainPage('home', "", 0));

class MainPage extends StatelessWidget {
  String routeName;
  Object params;
  int navBarItem;

  MainPage(this.routeName, this.params, this.navBarItem);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Raleway',
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      home: NavBar(routeName, params, navBarItem),
    );
  }
}

class NavBar extends StatefulWidget {
  String routeName = 'home';
  Object params = {};
  int navBarItem = 0;
  NavBar(this.routeName, this.params, this.navBarItem);
  @override
  State<NavBar> createState() =>
      _NavBartState(this.routeName, this.params, this.navBarItem);
}

class _NavBartState extends State<NavBar> {
  String routeName = 'home';
  int navBarItem = 0;
  int selectedItemOfNavBar = 0;
  Object params = {};
  _NavBartState(this.routeName, this.params, this.navBarItem);
  Uint8List _profilePicture = Uint8List(0);

  @override
  void initState() {
    setState(() {
      selectedItemOfNavBar =
          routes.getPageIndex(routes.getPageToIndex(navBarItem));
    });
    PatientController.getUserDetails(
            AuthenticationController.userPayload["patientId"].toString())
        .then(
      (response) {
        setState(
          () {
            if (response["profilePicture"] == null) {
              _profilePicture = Uint8List(0);
            } else {
              _profilePicture = base64Decode(
                response["profilePicture"]["content"].toString(),
              );
            }
          },
        );
      },
    );
  }

  final Routes routes = new Routes();
  void _onItemTapped(int index) {
    setState(() {
      selectedItemOfNavBar = index;
      routeName = routes.getPageToIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(30, 90),
          child: Appbar(AuthenticationController.userPayload["name"].toString(),
              _profilePicture, routeName)),
      body: routes.getPage(routeName, params),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note_sharp),
            label: 'Editoras',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_sharp),
            label: 'Livros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recent_actors_sharp),
            label: 'Alugueis',
          ),
        ],
        currentIndex: selectedItemOfNavBar,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
