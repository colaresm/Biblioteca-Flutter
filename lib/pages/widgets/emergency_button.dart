import 'package:flutter/material.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/controllers/patient_controller.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyButton extends StatefulWidget {
  String routeName;
  int navBarIndex;
  EmergencyButton(this.routeName, this.navBarIndex);

  @override
  State<EmergencyButton> createState() =>
      _EmergencyButtonState(this.routeName, this.navBarIndex);
}

class _EmergencyButtonState extends State<EmergencyButton> {
  String routeName;
  int navBarIndex;
  _EmergencyButtonState(this.routeName, this.navBarIndex);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(routeName, "", navBarIndex),
          ),
        );
      },
      backgroundColor: Colors.amber,
      child: Icon(Icons.add),
    );
  }
}
