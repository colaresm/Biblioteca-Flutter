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
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.amberAccent,
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
