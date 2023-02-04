import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/doctors_list/widgets/doctors_card_list.dart';
import 'package:libraryWDA/pages/widgets/back_button.dart';
import 'dart:convert';
import 'package:libraryWDA/models/doctor_params.dart';

class DoctorsList extends StatefulWidget {
  Object doctorParams;

  DoctorsList(this.doctorParams);

  @override
  State<DoctorsList> createState() => _DoctorsListState(this.doctorParams);
}

class _DoctorsListState extends State<DoctorsList> {
  Object doctorParams;
  _DoctorsListState(this.doctorParams);
  Map<String, dynamic> doctorParamsToMap = {};
  void initState() {
    if (doctorParams != "") {
      doctorParamsToMap = json.decode(jsonEncode(doctorParams));
    }
  }

  @override
  Widget build(BuildContext context) {
    DoctorParams doctorItems = DoctorParams.fromJson(doctorParamsToMap);
    return Scaffold(
      body: Container(
          child: Column(children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(3, 0, 10, 5),
              child: Backbutton("specialites-list", ""),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(25, 8, 5, 2),
              child: Text('Médicos disponíveis',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ],
        ),
        Expanded(
            child: DoctorsCardList(doctorItems.speciality.toString(),
                doctorItems.state.toString(), doctorItems.city.toString())),
      ])),
    );
  }
}
