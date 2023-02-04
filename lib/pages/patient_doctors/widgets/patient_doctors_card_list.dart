import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/patient_doctors/widgets/patient_doctors_card_item.dart';
import 'package:libraryWDA/utils/utf8_decode.dart';
import 'package:libraryWDA/controllers/doctor_controller.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';

class PatientDoctorsCardList extends StatefulWidget {
  const PatientDoctorsCardList({super.key});

  @override
  State<PatientDoctorsCardList> createState() => _PatientDoctorsCardListState();
}

class _PatientDoctorsCardListState extends State<PatientDoctorsCardList> {
  final DecodeUTF8 decodeUTF8 = new DecodeUTF8();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DoctorController.getLinkedDoctorsList(
          AuthenticationController.userPayload["patientId"]),
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
                  "Não há médicos vinculados",
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
                      PatientDoctorCardItem(
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
