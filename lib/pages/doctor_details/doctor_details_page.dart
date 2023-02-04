import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/widgets/back_button.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:libraryWDA/utils/add_mask.dart';
import 'package:libraryWDA/pages/widgets/schedule_button.dart';

class DoctorDetails extends StatefulWidget {
  var params;
  DoctorDetails(this.params);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState(this.params);
}

class _DoctorDetailsState extends State<DoctorDetails> {
  var params;
  _DoctorDetailsState(this.params);
  Uint8List _profilePicture = Uint8List(0);
  @override
  void initState() {
    if (params['profilePicture'] != "") {
      setState(() {
        _profilePicture = base64Decode(params['profilePicture'].toString());
      });
    }
  }

  getUsernameInitials(String userName) {
    return userName.substring(0, 2);
  }

  setAndress(neighborhood, city, street, number, state) {
    return street +
        ', ' +
        number +
        ', ' +
        neighborhood +
        '-' +
        city +
        '/' +
        state;
  }

  AddMask addMask = new AddMask();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(3, 0, 10, 5),
              child: Backbutton("patient-doctors-list", ""),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  child: params['profilePicture'].isEmpty
                      ? CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.brown.shade800,
                          child: Text(
                              getUsernameInitials(params['name'].toUpperCase()),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24)),
                        )
                      : Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: MemoryImage(
                                  _profilePicture,
                                ),
                                fit: BoxFit.cover),
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Text(params['name'] + '-' + params['speciality'],
                          style: const TextStyle(fontSize: 14))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                        setAndress(
                            params['neighborhood'],
                            params['city'],
                            params['street'],
                            params['number'],
                            params['serviceState']),
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
                Row(
                  children: [
                    Text('Telefone: ${addMask.phone(params['firstPhone'])}',
                        style: const TextStyle(fontSize: 14)),
                  ],
                )
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ScheduleButton(),
        ),
      ],
    )));
  }
}
