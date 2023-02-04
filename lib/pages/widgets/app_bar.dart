import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/patient_settings/patient_settings_page.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';

class Appbar extends StatelessWidget {
  final String userName;
  final String routeName;
  Uint8List profilePicture = Uint8List(0);

  Appbar(this.userName, this.profilePicture, this.routeName);

  getFristNameOfUser(String userName) {
    return userName.substring(0, userName.indexOf(' '));
  }

  getUsernameInitials(String userName) {
    return userName.substring(0, 2);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.fromLTRB(10, 31, 0, 5),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          routeName == 'home'
                              ? FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Bem vindo, ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ))
                              : Container(),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              getFristNameOfUser(AuthenticationController
                                  .userPayload["name"]
                                  .toString()
                                  .toUpperCase()),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Icon(
                            size: 16,
                            Icons.person,
                            color: Colors.black,
                          ),
                          routeName != 'home'
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.13))
                              : Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.063)),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width) *
                                  0.40,
                              child: Container(
                                child: profilePicture.isEmpty
                                    ? CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.blue,
                                        child: Text(
                                            getUsernameInitials(
                                                userName.toUpperCase()),
                                            style:
                                                TextStyle(color: Colors.white)),
                                      )
                                    : Container(
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: MemoryImage(
                                                profilePicture,
                                              ),
                                              fit: BoxFit.cover),
                                        )),
                              )),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientSettings()),
                        );
                      }),
                ],
              ),
            ],
          ),
        ));
  }
}
