import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/widgets/back_button.dart';
import 'package:libraryWDA/pages/widgets/add_button.dart';
import 'package:libraryWDA/pages/patient_doctors/widgets/patient_doctors_card_list.dart';

class PatietsDoctorsList extends StatefulWidget {
  const PatietsDoctorsList({super.key});

  @override
  State<PatietsDoctorsList> createState() => _PatietsDoctorsListState();
}

class _PatietsDoctorsListState extends State<PatietsDoctorsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(3, 0, 10, 5),
            child: Backbutton("home", ""),
          ),
        ],
      ),
      Column(
        children: [
          AddButton('specialites-list', 3),
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(25, 8, 5, 2),
                child: Text('Meus médicos',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ],
          ),
          PatientDoctorsCardList(),
        ],
      )
    ]));
  }
}
