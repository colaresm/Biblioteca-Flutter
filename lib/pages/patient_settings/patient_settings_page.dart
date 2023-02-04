import 'package:flutter/material.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:libraryWDA/controllers/patient_controller.dart';
import 'package:libraryWDA/pages/login/login_page.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:libraryWDA/pages/patient_settings/widgets/change_profile_picture.dart';
import 'package:libraryWDA/pages/patient_settings/widgets/patient_change_password.dart';
import 'package:libraryWDA/pages/patient_settings/widgets/patient_details.dart';

class PatientSettings extends StatefulWidget {
  const PatientSettings({super.key});

  @override
  State<PatientSettings> createState() => _PatientSettingsState();
}

class _PatientSettingsState extends State<PatientSettings> {
  Uint8List _profilePicture = Uint8List(0);
  String _birthDate = "";
  String _name = "";
  getUsernameInitials(userName) {
    if (userName == "") return '';
    return userName.substring(0, 2);
  }

  calculateAge() {
    if (_birthDate != "")
      return (DateTime.now()
                  .difference(DateTime.parse(_birthDate.toString()))
                  .inDays /
              360)
          .round();
  }

  @override
  void initState() {
    PatientController.getUserDetails(
            AuthenticationController.userPayload["patientId"].toString())
        .then(
      (response) {
        setState(
          () {
            _birthDate = response['birthDate'].toString();
            _name = response['name'].toString();
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

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                    boxShadow: [
                      BoxShadow(color: Colors.blue, spreadRadius: 3),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 15, 0, 5),
                        child: Row(
                          children: [
                            Text('Configurações',
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.white)),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainPage("home", {}, 0)),
                                );
                              },
                              icon: Icon(
                                size: 30,
                                Icons.keyboard_double_arrow_right,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18.0, 36.0, 0, 5.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  child: _profilePicture.isEmpty
                                      ? CircleAvatar(
                                          radius: 30,
                                          backgroundColor:
                                              Colors.brown.shade800,
                                          child: Text(
                                              getUsernameInitials(
                                                  _name.toUpperCase()),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24)),
                                        )
                                      : Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: MemoryImage(
                                                  _profilePicture,
                                                ),
                                                fit: BoxFit.cover),
                                          )),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(' ${_name}',
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${calculateAge().toString()} anos',
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white))
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_circle_outlined,
                                color: Colors.black,
                                size: 36,
                              ),
                              Text(
                                ' Conta',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ChangeProfilePicture()),
                        );
                      },
                      child: Text(
                        'Alterar foto de perfil',
                        style: TextStyle(fontSize: 18),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PatientDetails()));
                      },
                      child: Text(
                        'Alterar informações pessoais',
                        style: TextStyle(fontSize: 18),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PatientChangePassword()));
                      },
                      child: Text(
                        'Alterar senha',
                        style: TextStyle(fontSize: 18),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Get.to(
                          LoginPage(),
                          duration: Duration(seconds: 1),
                          transition: Transition.fade,
                        );
                      },
                      child: Text(
                        'Sair',
                        style: TextStyle(fontSize: 18),
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
