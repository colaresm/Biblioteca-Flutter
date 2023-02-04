import 'package:libraryWDA/main.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/patient_settings/patient_settings_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:libraryWDA/controllers/patient_controller.dart';
import 'package:libraryWDA/pages/widgets/cancel_button.dart';
import 'package:libraryWDA/pages/widgets/default_button.dart';
import 'package:http/http.dart';

class ChangeProfilePicture extends StatefulWidget {
  const ChangeProfilePicture({super.key});

  @override
  State<ChangeProfilePicture> createState() => _ChangeProfilePictureState();
}

class _ChangeProfilePictureState extends State<ChangeProfilePicture> {
  Uint8List _profilePicture = Uint8List(0);

  String _nameofProfilePicture = "";
  int _sizeofProfilePicture = 0;
  String name = AuthenticationController.userPayload["name"];
  getUsernameInitials(String userName) {
    return userName.substring(0, 2);
  }

  @override
  void initState() {
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

  loadProfilePicture() async {
    {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'bmp', 'jpeg']);
      if (result != null) {
        PlatformFile file = result.files.first;
        setState(() {
          _profilePicture = file.bytes ?? Uint8List(0);
          _nameofProfilePicture = file.name;
          _sizeofProfilePicture = file.size;
        });
      } else {}
    }
  }

  Widget build(BuildContext context) {
    updateProfilePicute() {
      //  File profilePicture = new File(_profilePicture, _nameofProfilePicture);

      PatientController.updateProfilePicture({
        'id': AuthenticationController.userPayload["patientId"].toString(),
        'profilePicture': {
          'bytes': _profilePicture,
          'size': _sizeofProfilePicture,
          'name': _nameofProfilePicture
        }
      });
      Get.snackbar('Sucesso', 'Foto de perfil atualizada com sucesso',
          backgroundColor: companyColors.shade400,
          borderWidth: 4,
          colorText: companyColors.shade100,
          borderColor: companyColors.shade100);
    }

    removeProfilePicture() {
      setState(() {
        _profilePicture = Uint8List(0);
      });
      PatientController.updateProfilePicture({
        'id': AuthenticationController.userPayload["patientId"].toString(),
        'profilePicture': null
      });
      Get.snackbar('Sucesso', 'Foto de perfil removida com sucesso',
          backgroundColor: companyColors.shade400,
          borderWidth: 4,
          colorText: companyColors.shade100,
          borderColor: companyColors.shade100);
    }

    backPage() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PatientSettings()),
      );
    }

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
                          Text('Foto de perfil',
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.white)),
                          IconButton(
                            onPressed: () {
                              backPage();
                            },
                            icon: Icon(
                              size: 30,
                              Icons.keyboard_double_arrow_right,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              child: Column(
                                children: [
                                  Container(
                                    child: _profilePicture.isEmpty
                                        ? CircleAvatar(
                                            radius: 50,
                                            backgroundColor:
                                                Colors.brown.shade800,
                                            child: Text(
                                                getUsernameInitials(
                                                    name.toUpperCase()),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24)),
                                          )
                                        : Container(
                                            width: 120,
                                            height: 120,
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
                              onTap: () {
                                loadProfilePicture();
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    DefaultButton(
                        'Salvar',
                        Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        updateProfilePicute)
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultButton(
                    'Remover foto',
                    Icon(
                      Icons.highlight_remove_outlined,
                      color: Colors.white,
                    ),
                    removeProfilePicture)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CancelButton(backPage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
