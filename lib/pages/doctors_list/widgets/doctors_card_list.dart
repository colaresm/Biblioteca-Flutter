import 'package:flutter/material.dart';
import 'package:libraryWDA/controllers/doctor_controller.dart';
import 'package:libraryWDA/pages/doctors_list/widgets/doctors_card_item.dart';
import 'package:libraryWDA/utils/utf8_decode.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'dart:convert';

class DoctorsCardList extends StatefulWidget {
  String speciality;
  String state;
  String city;
  DoctorsCardList(this.speciality, this.state, this.city);

  @override
  State<DoctorsCardList> createState() =>
      _DoctorsCardListState(this.speciality, this.state, this.city);
}

class _DoctorsCardListState extends State<DoctorsCardList> {
  String speciality;
  String state;
  String city;
  _DoctorsCardListState(this.speciality, this.state, this.city);
  final DecodeUTF8 decodeUTF8 = new DecodeUTF8();

  @override
  Widget build(BuildContext context) {
    Object doctorParams = {
      'speciality': speciality,
      'state': state,
      'city': city,
      'patientId': AuthenticationController.userPayload["patientId"]
    };
    Map<String, dynamic> doctorParamsToMap = {};
    doctorParamsToMap = json.decode(jsonEncode(doctorParams));
    return FutureBuilder(
      future: DoctorController.getDoctorsList(doctorParamsToMap),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Não há médicos disponíveis",
                  style: TextStyle(
                    fontFamily: "Fredoka",
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                itemBuilder: (context, index) {
                  final doctors = snapshot.data?[index];

                  return Column(
                    children: [
                      DoctorsCardItem(
                          doctors.id,
                          decodeUTF8.decodeString(doctors.name),
                          decodeUTF8.decodeString(doctors.serviceNeighborhood),
                          decodeUTF8.decodeString(doctors.serviceCity),
                          decodeUTF8.decodeString(doctors.serviceNeighborhood),
                          decodeUTF8.decodeString(doctors.serviceNumber),
                          decodeUTF8.decodeString(doctors.serviceStreet),
                          doctors.profilePicture,
                          doctors.firstPhone,
                          decodeUTF8.decodeString(doctors.serviceState),
                          doctors.speciality)
                    ],
                  );
                },
              );
            }
        }
      },
    );
  }
}
