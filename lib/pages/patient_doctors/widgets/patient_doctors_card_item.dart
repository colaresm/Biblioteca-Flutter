import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:libraryWDA/main.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:libraryWDA/controllers/doctor_controller.dart';
import 'package:libraryWDA/utils/speciality_enum.dart';

class PatientDoctorCardItem extends StatefulWidget {
  String id;
  String name;
  String email;
  String city;
  String neighborhood;
  String number;
  String street;
  String profilePicture;
  String firstPhone;
  String serviceState;
  String speciality;
  PatientDoctorCardItem(
      this.id,
      this.name,
      this.email,
      this.city,
      this.neighborhood,
      this.number,
      this.street,
      this.profilePicture,
      this.firstPhone,
      this.serviceState,
      this.speciality);

  @override
  State<PatientDoctorCardItem> createState() => _PatientDoctorCardItemState(
      this.id,
      this.name,
      this.email,
      this.city,
      this.neighborhood,
      this.number,
      this.street,
      this.profilePicture,
      this.firstPhone,
      this.serviceState,
      this.speciality);
}

class _PatientDoctorCardItemState extends State<PatientDoctorCardItem> {
  @override
  String id;
  String name;
  String email;
  String city;
  String neighborhood;
  String number;
  String street;
  String profilePicture;
  String firstPhone;
  String serviceState;
  String speciality;
  Uint8List _profilePicture = Uint8List(0);
  _PatientDoctorCardItemState(
      this.id,
      this.name,
      this.email,
      this.city,
      this.neighborhood,
      this.number,
      this.street,
      this.profilePicture,
      this.firstPhone,
      this.serviceState,
      this.speciality);

  @override
  void initState() {
    if (profilePicture != "") {
      setState(() {
        _profilePicture = base64Decode(profilePicture.toString());
      });
    }
  }

  getUsernameInitials(String userName) {
    return userName.substring(0, 2);
  }

  SpecialityEnum specialityEnum = new SpecialityEnum();
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: <Widget>[
            Container(
              child: profilePicture.isEmpty
                  ? CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.brown.shade800,
                      child: Text(getUsernameInitials(name.toUpperCase()),
                          style: const TextStyle(color: Colors.white)),
                    )
                  : Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: MemoryImage(
                              _profilePicture,
                            ),
                            fit: BoxFit.cover),
                      )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Dr(a) $name',
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(width: 10),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Remover médico '),
                  onPressed: () {
                    DoctorController.deleteAccompayingDoctor(id);
                    Get.snackbar('Sucesso', 'Médico removido com sucesso',
                        backgroundColor: companyColors.shade400,
                        borderWidth: 4,
                        colorText: companyColors.shade100,
                        borderColor: companyColors.shade100);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MainPage('patient-doctors-list', "", 3)),
                    );
                  },
                ),
                TextButton(
                  child: const Text('Detalhes'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainPage(
                              'doctor-details',
                              {
                                'name': name,
                                'profilePicture': profilePicture,
                                'street': street,
                                'number': number,
                                'neighborhood': neighborhood,
                                'city': city,
                                'firstPhone': firstPhone,
                                'serviceState': serviceState,
                                'speciality':
                                    specialityEnum.specialityValue(speciality),
                              },
                              3)),
                    );
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
